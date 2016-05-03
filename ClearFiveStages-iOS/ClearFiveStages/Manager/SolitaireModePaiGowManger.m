#import "SolitaireModePaiGowManger.h"
#import "GameDataManager.h"

@interface SolitaireModePaiGowManger () 
-(void) turnAroundAllPaiGowRowsFinishedSelector;
-(void) paiGowDealFinishedSelector;
-(void) updatePaiGowPosition:(int)rowNum waitTime:(float)timeVal;
-(void) updateColumnForRow:(int)rowNum;
-(NSMutableArray *) paiGowRowArrayForCurrentRow;
-(int) currentFirstRow;
-(void) markRowCleared:(int)rowNum;
@end

@implementation SolitaireModePaiGowManger
@synthesize paiGowObjectDictionary;

static SolitaireModePaiGowManger *_sharedManager = nil;
+(SolitaireModePaiGowManger *) sharedManager {
	if (!_sharedManager) {
		if([[SolitaireModePaiGowManger class] isEqual:[self class]])
			_sharedManager = [[SolitaireModePaiGowManger alloc] init];
		else
			_sharedManager = [[self alloc] init];
	}
	return _sharedManager;
}

-(id) init {  
	if( (self = [super init]) ) {
		self.paiGowObjectDictionary = [[NSMutableDictionary alloc] init];
		self.connectableNumberArray = [[NSMutableArray alloc] init];
	}
	return self;
}

-(BOOL) connectPaiGow:(SolitairePayer *)player {
    PaiGowObject *selectedPaiGow = [player getSelectedPaiGowObject];
    if (!selectedPaiGow) return NO;
	for (Number *pointNumber in self.connectableNumberArray) {
		if (selectedPaiGow.pg_preNum == [pointNumber intValue] ||
			selectedPaiGow.pg_postNum == [pointNumber intValue]) {
	    	// do the connect
	    	[self.connectableNumberArray removeObject:pointNumber];
	    	int newConnectPoint = (selectedPaiGow.pg_preNum == [pointNumber intValue]) ? selectedPaiGow.pg_postNum : selectedPaiGow.pg_preNum;
	    	[self.connectableNumberArray addObject:[NSNumber numberWithInt:newConnectPoint]];
	    	[player paiGowConnected:selectedPaiGow];
	    	if ([player remainPaiGowCount] == 0) {
			    // declare win
			}
	    	return YES;
	    };
	}
	return NO;
}

- (void) dealloc {
	[self.paiGowObjectDictionary release];
	[self.rowStateArray release];
	[self.tableLayer release];
	self.tableLayer = nil;
	[super dealloc];
}

-(void) initAllPowGowObjects {
	NSMutableArray *paiGowArray = [[NSMutableArray alloc] init];
	for (int i = 1; i < 7; i++) {		
		[self.rowStateArray addObject:[NSNumber numberWithBool:NO]];
		for (int j = i; j < 7; j++) {
			PaiGowObject *paiGowObject = [PaiGowObject paiGowObjectWithPreNum:i postNum:j row:1 column:1];
			[paiGowArray addObject:paiGowObject];
			if ((i == 1 && j != 2 && j != 4) ||
				(i == 2 && j != 3 && j != 4 && j != 5 && j != 6) ||
				(i == 3 && j != 4 && j != 5 && j != 6) ||
				(i == 4 && j != 5) ||
				(i == 5) ||
				(i == 6)) {
				PaiGowObject *paiGowPairObject = [PaiGowObject paiGowObjectWithPreNum:i postNum:j row:1 column:1];
				[paiGowArray addObject:paiGowPairObject];
			}
		}
	}
}

-(void) setupPayers:(int)playerNumber {
    SolitairePayer *playerOne = [SolitairePayer playerWithType:0];
    SolitairePayer *playerTwo = [SolitairePayer playerWithType:1];
    for (PaiGowObject *paiGowObject in self.paiGowArray) {
		int randomNumber = CC_RANROM_0_1() * 10;
		if (randomNumber > 5) {
			if (playerOne.paiGowCount == 16) {
			    [playerTwo addPaiGow:paiGowObject];
			}
			else {
				[playerOne addPaiGow:paiGowObject];
			}
		}
		else {
			if (playerTwo.paiGowCount == 16) {
			    [playerOne addPaiGow:paiGowObject];
			}
			else {
				[playerTwo addPaiGow:paiGowObject];
			}
		}
	}
}

-(void) randomAllPaiGowPosition:(NSMutableArray *)paiGowArray {
    int rowNum = -1;
	int colNumCount[6] = {0};
	int rowColCount[6] = {0};
    NSMutableArray *paiGowRowArray[6];
    for (int i = 0; i < 6; i++) {
		paiGowRowArray[i] = [[NSMutableArray alloc] init];
	}
	for (int i = 0; i < paiGowArray.count; i++) {
		PaiGowObject *paiGowObject = paiGowArray[i];
		do {
			rowNum = CCRANDOM_0_1() * 6;
		} while (((rowColCount[rowNum] + 1 > 5) && rowNum > 0) ||
				 ((rowColCount[rowNum] + 1 > 7) && rowNum == 0));
		rowColCount[rowNum]++;
        [paiGowObject updateRow:rowNum andColumn:++colNumCount[rowNum]];
		[paiGowRowArray[rowNum] addObject:paiGowObject];
	}
	for (int i = 0; i < 6; i++) {
		[self.paiGowObjectDictionary setObject:paiGowRowArray[i] forKey:[NSString stringWithFormat:@"Row-%d", i]];
}

-(void) putAllPaiGowsOnTable {
	for (int i = 0; i < self.paiGowObjectDictionary.count; i++) {
		NSMutableArray *paiGowArray = [self paiGowRowArrayForRow:i];
		for (int j = 0; j < paiGowArray.count; j++) {	
			PaiGowObject *paiGowObject = paiGowArray[j];
			[self.tableLayer addChild:paiGowObject.pg_Sprite z:1];
		}
	}
}

-(void) turnAroundAllPaiGowRowsWithInterval:(float)interval {
    float waitTimeVal = 0.5f;
	for (int rowNum = 1; rowNum <= 5; rowNum++) {
        [self performSelector:@selector(turnAroundPaiGowForRow:) withObject:[NSNumber numberWithInt:rowNum] afterDelay:waitTimeVal];
		waitTimeVal += interval;
	}
    [self performSelector:@selector(turnAroundPaiGowForRow:) withObject:[NSNumber numberWithInt:0] afterDelay:waitTimeVal];
    waitTimeVal += interval;
	[self performSelector:@selector(turnAroundAllPaiGowRowsFinishedSelector) withObject:self afterDelay:waitTimeVal];
}

-(void) turnAroundAllPaiGowRowsFinishedSelector {
    if (self.delegate) [self.delegate turnAroundAllPaiGowRowsFinished];
}

-(void) turnAroundPaiGowForRow:(NSNumber *)rowNum {
	NSMutableArray *paiGowRowArray = [self paiGowRowArrayForRow:[rowNum intValue]];
	float waitTimeVal = 0.0f;
	for (int i = 0; i < paiGowRowArray.count; i++) {
		PaiGowObject *paiGowObject = paiGowRowArray[i];
		[paiGowObject performSelector:@selector(turnAroundAnimation) withObject:paiGowObject afterDelay:waitTimeVal];
		waitTimeVal += 0.1f;
	}
}
@end
