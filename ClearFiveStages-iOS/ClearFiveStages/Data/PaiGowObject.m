#import "PaiGowObject.h"
#import "CFSModePaiGowManager.h"

@implementation PaiGowObject
@synthesize pg_Sprite;
@synthesize pg_name;
@synthesize pg_detail;
@synthesize pg_preNum;
@synthesize pg_postNum;
@synthesize pg_rowNum;
@synthesize pg_colNum;
@synthesize pg_isSelected;
@synthesize pg_position;

#pragma mark - init
+(id) paiGowObjectWithPreNum:(int)preNum postNum:(int)postNum row:(int)row column:(int)column {
	return [[[self alloc] initWithPreNum:preNum postNum:postNum row:row column:column] autorelease];
}

+(CGSize) sizeForPaiGow {
    CCSprite *ghostSprite = [CCSprite spriteWithSpriteFrameName:@"back.png"];
    return ghostSprite.contentSize;
}

+(float) widthForPaiGow {
    CGSize size = [PaiGowObject sizeForPaiGow];
    return size.width;
}

+(float) heightForPaiGow {
	CGSize size = [PaiGowObject sizeForPaiGow];
    return size.height;
}

+(float) heightForRow:(int)rowNum {
    return (rowNum == 0) ? 90 : 90 + (6 - rowNum) * ([CCDirector sharedDirector].winSize.height - 100) / 6;
}

-(id) initWithPreNum:(int)preNum postNum:(int)postNum row:(int)row column:(int)column {
	if ((self = [super init])) {
		self.pg_name = [NSString stringWithFormat:@"%d-%d.png", preNum, postNum];
		self.pg_detail = @"";
		self.pg_preNum = preNum;
		self.pg_postNum = postNum;
		self.pg_rowNum = row;
		self.pg_colNum = column;
		self.pg_isSelected = NO;
		self.pg_position = CGPointZero;
		self.pg_Sprite = [CCSprite spriteWithSpriteFrameName:@"back.png"];
		self.pg_Sprite.position = self.pg_position;
	}
	return self;
}

#pragma mark - update
-(CGPoint) calcPositionWithPaiGowsInRow:(int)paiGowCount {
	CGPoint resultPosition;
	if (paiGowCount < 8) {
		resultPosition.x = (7 - paiGowCount) * 20 + self.pg_colNum * 40;
	}
	else {
		resultPosition.x = (self.pg_colNum < 4) ? self.pg_colNum * 40 : (self.pg_colNum - paiGowCount + 7) * 40;
	}
	resultPosition.y = (self.pg_rowNum == 0) ? 90 : 90 + (6 - self.pg_rowNum) * ([CCDirector sharedDirector].winSize.height - 100) / 6;
	return resultPosition;
}

-(void) updateRow:(int)row andColumn:(int)column {
	self.pg_rowNum = row;
	self.pg_colNum = column;
}

#pragma mark - animation
-(void) movePaiGowAnimationWithColumn:(int)columnCount afterDelay:(float)delay moveDuration:(float)duration {
    self.pg_position = [self calcPositionWithPaiGowsInRow:columnCount];
	[self.pg_Sprite runAction:[CCSequence actions:[CCDelayTime actionWithDuration:delay],
								   				  [CCMoveTo actionWithDuration:duration position:self.pg_position],
								   				  nil]];
}

-(void) turnAroundAnimation {
    [self.pg_Sprite setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:self.pg_name]];
	[self.pg_Sprite runAction:[CCFadeIn actionWithDuration:1.0f]];
}

-(void) selectedAnimation {
	if (self.pg_isSelected) {
		[self.pg_Sprite runAction:[CCRepeatForever actionWithAction:
								   [CCJumpBy actionWithDuration:1.0f position:ccp(0, 0) height:10 jumps:2]]];
	}
	else {
		[self.pg_Sprite stopAllActions];
		self.pg_Sprite.position = self.pg_position;
	}
}

-(void) selected {
	self.pg_isSelected = !self.pg_isSelected;
	[self selectedAnimation];
}

-(void) cancelSelect {
	if (self.pg_isSelected) {
		[self.pg_Sprite stopAllActions];
	}
	self.pg_Sprite.position = self.pg_position;
	pg_isSelected = NO;
}


#pragma mark - touch
-(CGRect) rect {
	return CGRectMake(self.pg_Sprite.position.x-(self.pg_Sprite.textureRect.size.width/2),
			  self.pg_Sprite.position.y-(self.pg_Sprite.textureRect.size.height/2),
			  self.pg_Sprite.textureRect.size.width,
			  self.pg_Sprite.textureRect.size.height);	
}

-(BOOL) containsTouchLocation:(UITouch *)touch {
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

-(void) dealloc {
	[super dealloc];
}

@end
