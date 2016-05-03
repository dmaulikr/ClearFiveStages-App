#import "PaiGowObject.h"
#import "CFSModeRuleManager.h"

@protocol CFSModePaiGowManagerDelegate <NSObject>
@required
-(void) turnAroundAllPaiGowRowsFinished;
-(void) showPlacePaiGowArrows;
-(void) paiGowDealFinished;
-(void) placePaiGowFinished:(int)rowNum;
-(void) gameFinishedWinning;
-(void) gameFinishedLosing;
-(void) createBubForRow:(int)rowNum hideCount:(int)toHide at:(CGPoint)bubPosition;
-(void) removeBubForRow:(int)rowNum;
-(void) rowCleared:(int)rowNum;
@optional
@end

@interface CFSModePaiGowManager : NSObject {
	NSMutableDictionary *paiGowObjectDictionary;
	int remainRows;
	int currentRow;
	int lastHintPaiGowRow;
	NSMutableArray *rowStateArray;
	CCLayer *tableLayer;
	id<CFSModePaiGowManagerDelegate> delegate;
	CCLayerColor *highlightLayer;
}
@property (nonatomic, retain) NSMutableDictionary *paiGowObjectDictionary;
@property (nonatomic, retain) CCLayer* tableLayer;
@property (nonatomic, retain) CCLayerColor *highlightLayer;
@property (nonatomic, retain) id<CFSModePaiGowManagerDelegate> delegate;

@property (nonatomic) int currentRow;
@property (nonatomic) int remainRows;
@property (nonatomic, retain) NSMutableArray *rowStateArray;
@property (nonatomic) int lastHintPaiGowRow;

+(CFSModePaiGowManager *) sharedManager;

-(void) initAllPowGowObjects;
-(void) putAllPaiGowsOnTable;
-(BOOL)isAnyPairAvialble;
-(void) turnAroundAllPaiGowRowsWithInterval:(float)interval;
-(void) turnAroundPaiGowForRow:(NSNumber *)rowNum;
-(void) highlightCurrentRow;
-(BOOL) placePaiGow:(int)rowNum;
-(void) dealPaiGow;
-(void) moveToNextRow;
-(RuleType) getPaiGowObjectsForRule;
-(BOOL)showHintPaiGow;
-(void)cancelAllSelectedPaiGow;
-(void)resetAllPaiGow;
-(void) handleTouch:(UITouch *)touch;
-(BOOL) isRowCleared:(int)rowNum;
-(int)remainRowAbove:(int)rowNum;
-(NSMutableArray *) paiGowRowArrayForRow:(int)row;
-(PaiGowObject *) anyPaiGowForRow:(int)row;
-(BOOL) hasPaiGowSelectedInCurrentRow;
-(int) paiGowCountForRow:(int)rowNum;

@end
