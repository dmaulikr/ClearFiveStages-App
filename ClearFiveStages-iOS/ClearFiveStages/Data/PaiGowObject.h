#import "cocos2d.h"

@interface PaiGowObject : CCNode {
	CCSprite *pg_Sprite;
	NSString *pg_name;
	NSString *pg_detail;
	int pg_preNum;
	int pg_postNum;
	int pg_rowNum;
	int pg_colNum;
	bool pg_isSelected;
	CGPoint pg_position;
}

+(id) paiGowObjectWithPreNum:(int)preNum postNum:(int)postNum row:(int)row column:(int)column;
+(CGSize) sizeForPaiGow;
+(float) widthForPaiGow;
+(float) heightForPaiGow;
+(float) heightForRow:(int)rowNum;

-(id) initWithPreNum:(int)preNum postNum:(int)postNum row:(int)row column:(int)column;
-(void) updateRow:(int)row andColumn:(int)column;
-(void) movePaiGowAnimationWithColumn:(int)columnCount afterDelay:(float)delay moveDuration:(float)duration;
-(void) turnAroundAnimation;
-(void) selectedAnimation;
-(void) cancelSelect;
-(void) selected;
-(BOOL)containsTouchLocation:(UITouch *)touch;

@property (nonatomic) CGPoint pg_position;
@property (nonatomic, retain) CCSprite *pg_Sprite;
@property (nonatomic, retain) NSString *pg_name;
@property (nonatomic, retain) NSString *pg_detail;
@property (nonatomic) int pg_preNum;
@property (nonatomic) int pg_postNum;
@property (nonatomic) int pg_rowNum;
@property (nonatomic) int pg_colNum;
@property (nonatomic) bool pg_isSelected;
@end
