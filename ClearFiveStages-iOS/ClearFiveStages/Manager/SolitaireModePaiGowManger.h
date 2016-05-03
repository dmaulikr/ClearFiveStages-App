#import "PaiGowObject.h"
#import "SolitaireModePaiGowManger.h"

@protocol SolitaireModePaiGowMangerDelegate <NSObject>
@required
@optional
@end

@interface SolitaireModePaiGowManger : NSObject {
	NSMutableDictionary *paiGowObjectDictionary;
	int remainRows;
	int currentRow;
	NSMutableArray *rowStateArray;
	BOOL isPaiGowTouchDisabled;
	CCLayer *tableLayer;
	id<SolitaireModePaiGowMangerDelegate> delegate;
	CCLayerColor *highlightLayer;
}
@property (nonatomic, retain) NSMutableDictionary *paiGowObjectDictionary;
@property (nonatomic, retain) CCLayer* tableLayer;
@property (nonatomic, retain) CCLayerColor *highlightLayer;
@property (nonatomic, retain) id<CFSModePaiGowMangerDelegate> delegate;

@property (nonatomic) int currentRow;
@property (nonatomic) int remainRows;
@property (nonatomic, retain) NSMutableArray *rowStateArray;
@property (nonatomic) BOOL isPaiGowTouchDisabled;

+(CFSModePaiGowManger *) sharedManager;

-(void) initAllPowGowObjects;
-(void) putAllPaiGowsOnTable;
-(void) turnAroundAllPaiGowRowsWithInterval:(float)interval;
-(void) turnAroundPaiGowForRow:(NSNumber *)rowNum;
-(void) highlightCurrentRow;
-(void) dealPaiGow;
-(void) moveToNextRow;
-(void) placePaiGow:(int)rowNum;
-(RuleType) getPaiGowObjectsForRule;
-(void)showHintPaiGow;
-(void)cancelAllSelectedPaiGow;
-(void)resetAllPaiGow;
-(void) enablePaiGowTouch;
-(void) disablePaiGowTouch;
-(BOOL) isRowCleared:(int)rowNum;
-(NSMutableArray *) paiGowRowArrayForRow:(int)row;
-(BOOL) hasPaiGowSelectedInCurrentRow;

@end
