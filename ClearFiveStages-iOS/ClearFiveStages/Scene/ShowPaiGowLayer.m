#import "ShowPaiGowLayer.h"
#import "CFSModePaiGowManager.h"

@implementation ShowPaiGowLayer

+(id) layerWithRow:(int)rowNum {
    return [[[self alloc] initWithRow:rowNum] autorelease];
}

-(id) initWithRow:(int)rowNum {
	if ((self = [super initWithColor:ccc4(255, 255, 255, 0)])) {
		[self setTouchEnabled:YES];
		isDragging = NO;
		lasty = 0.0f;
		xvel = 0.0f;
		direction = BounceDirectionStayingStill;
		scrollLayer = [CCLayerColor layerWithColor:ccc4(22, 144, 227, 200)];
		
		NSMutableArray *paiGowArray = [NSMutableArray arrayWithArray:[[CFSModePaiGowManager sharedManager] paiGowRowArrayForRow:rowNum]];
        PaiGowObject *paiGowObject = paiGowArray[0];
		scrollLayer.contentSize = CGSizeMake((paiGowArray.count + 1 ) * 38, [PaiGowObject heightForPaiGow]);
		scrollLayer.position = ccp(0, paiGowObject.pg_position.y - [PaiGowObject heightForPaiGow] / 2);
		[self addChild: scrollLayer z:0];
        for (int i = 0; i < paiGowArray.count; i++) {
			PaiGowObject *paiGowObject = paiGowArray[i];			
			CCSprite *copySprite = [CCSprite spriteWithSpriteFrameName:paiGowObject.pg_name];
			copySprite.position = ccp(paiGowObject.pg_colNum * 38, [PaiGowObject heightForPaiGow] / 2);
			[scrollLayer addChild:copySprite z:2];
		}
		CCSprite *close = [CCSprite spriteWithSpriteFrameName:@"close.png"];
		close.scale = 0.7f;
		CCMenuItemSprite *menuItem = [CCMenuItemSprite itemWithNormalSprite:close selectedSprite:nil target:self selector:@selector(closeLayer)];
		CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
		menu.position = ccp(14, 60);
		[scrollLayer addChild:menu z:2];
		[self scheduleUpdate];
	}
	return self;
}

-(void) closeLayer {
	[self removeFromParentAndCleanup:YES];
}

-(void) update:(ccTime)delta {
	CGPoint pos = scrollLayer.position;	
	float right = pos.x + [self boundingBox].origin.x + scrollLayer.contentSize.width;
	float left = pos.x + [self boundingBox].origin.x;
	float minX = [self boundingBox].origin.x;
	float maxX = [self boundingBox].origin.x + [self boundingBox].size.width;	
	if(!isDragging) {
		static float friction = 0.96f;
		if(left > minX && direction != BounceDirectionGoingLeft) {
			xvel = 0;
			direction = BounceDirectionGoingLeft;
		}
		else if(right < maxX && direction != BounceDirectionGoingRight)	{
			xvel = 0;
			direction = BounceDirectionGoingRight;
		}
		if(direction == BounceDirectionGoingRight) {
			if(xvel >= 0) {
				float delta = (maxX - right);
				float yDeltaPerFrame = (delta / (BOUNCE_TIME * FRAME_RATE));
				xvel = yDeltaPerFrame;
			}
			if((right + 0.5f) == maxX) {
				pos.x = right -  scrollLayer.contentSize.width;
				xvel = 0;
				direction = BounceDirectionStayingStill;
			}
		}
		else if(direction == BounceDirectionGoingLeft) {			
			if(xvel <= 0) {
				float delta = (minX - left);
				float yDeltaPerFrame = (delta / (BOUNCE_TIME * FRAME_RATE));
				xvel = yDeltaPerFrame;
			}
			if((left + 0.5f) == minX) {
				pos.x = left - [self boundingBox].origin.x;
				xvel = 0;
				direction = BounceDirectionStayingStill;
			}
		}
		else {
			xvel *= friction;
		}
		pos.x += xvel;	
		scrollLayer.position = pos;
	}
	else {
		if(left <= minX || right >= maxX) {	
			direction = BounceDirectionStayingStill;
		}
		if(direction == BounceDirectionStayingStill) {
			xvel = (pos.x - lasty)/2;
			lasty = pos.x;
		}
	}
}

-(void) registerWithTouchDispatcher {
	[[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:0 swallowsTouches:NO];
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event {
	CGPoint location =  [[CCDirector sharedDirector] convertToGL:[touch locationInView: [touch view]]];
	if ( !CGRectContainsPoint([scrollLayer boundingBox], location)) return YES;
	isDragging = YES;	
	return YES;
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event {
	CGPoint touchLocation = [touch locationInView: [touch view]];
	CGPoint location =  [[CCDirector sharedDirector] convertToGL:touchLocation];
	if ( !CGRectContainsPoint([scrollLayer boundingBox], location)) return;
	CGPoint a = [[CCDirector sharedDirector] convertToGL:[touch previousLocationInView:[touch view]]];
	CGPoint b = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
	
	CGPoint nowPosition = scrollLayer.position;
	nowPosition.x += ( b.x - a.x );
	scrollLayer.position = nowPosition;
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event {
	isDragging = NO;
}
@end