#import "cocos2d.h"

#define FRAME_RATE 60
#define BOUNCE_TIME 0.2f

typedef enum {
	BounceDirectionGoingUp = 1,
	BounceDirectionStayingStill = 0,
	BounceDirectionGoingDown = -1,
	BounceDirectionGoingLeft = 2,
	BounceDirectionGoingRight = 3
} BounceDirection;

@interface ShowPaiGowLayer : CCLayerColor {
	BounceDirection direction;
	CCLayer *scrollLayer;
	BOOL isDragging;
	float lasty;
	float xvel;
	float contentHeight;
}

+(id) layerWithRow:(int)rowNum;
-(id) initWithRow:(int)rowNum;
-(void) closeLayer;
@end
