#import "CFSModePaiGowManager.h"
#import "GameDataManager.h"

@interface CFSModePaiGowManager () 
-(void) turnAroundAllPaiGowRowsFinishedSelector;
-(void) paiGowDealFinishedSelector;
-(void) updatePaiGowPosition:(int)rowNum waitTime:(float)timeVal;
-(void) updateColumnForRow:(int)rowNum;
-(NSMutableArray *) paiGowRowArrayForCurrentRow;
-(int) currentFirstRow;
-(void) markRowCleared:(int)rowNum;
@end

@implementation CFSModePaiGowManager
@synthesize paiGowObjectDictionary, tableLayer, highlightLayer, delegate;
@synthesize currentRow, rowStateArray, remainRows;
@synthesize lastHintPaiGowRow;

static CFSModePaiGowManager *_sharedManager = nil;
+(CFSModePaiGowManager *) sharedManager {
	if (!_sharedManager) {
		if([[CFSModePaiGowManager class] isEqual:[self class]])
			_sharedManager = [[CFSModePaiGowManager alloc] init];
		else
			_sharedManager = [[self alloc] init];
	}
	return _sharedManager;
}

-(id) init {  
	if( (self = [super init]) ) {
		self.paiGowObjectDictionary = [NSMutableDictionary dictionary];
		self.rowStateArray = [NSMutableArray array];
		self.remainRows = 5;
		self.currentRow = 1;
		self.lastHintPaiGowRow = 0;
		self.highlightLayer = [CCLayerColor layerWithColor:ccc4(22, 144, 227, 100) width:320 height:[PaiGowObject heightForPaiGow]];
        self.highlightLayer.visible = NO;
	}
	return self;
}

- (void) dealloc {
	[self.paiGowObjectDictionary release];
	[self.rowStateArray release];
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
    [self randomAllPaiGowPosition:paiGowArray];
}

-(void) randomAllPaiGowPosition:(NSMutableArray *)paiGowArray {
    int rowNum = -1;
	int colNumCount[6] = {0};
	int rowColCount[6] = {0};
    NSMutableArray *paiGowRowArray[6];
    for (int i = 0; i < 6; i++) {
		paiGowRowArray[i] = [[NSMutableArray alloc] init];
	}
    srandom(time(NULL));
	for (int i = 0; i < paiGowArray.count; i++) {
		PaiGowObject *paiGowObject = paiGowArray[i];
		do {
			rowNum = CCRANDOM_0_1() * 6;
		} while (((rowColCount[rowNum] + 1 > 5) && rowNum > 0) ||
				 ((rowColCount[rowNum] + 1 > 7) && rowNum == 0));
		rowColCount[rowNum]++;
        [paiGowObject updateRow:rowNum andColumn:++colNumCount[rowNum]];
        [paiGowObject movePaiGowAnimationWithColumn:(rowNum == 0 ? 7 : 5) afterDelay:0.0f moveDuration:0.0f];
		[paiGowRowArray[rowNum] addObject:paiGowObject];
	}
	for (int i = 0; i < 6; i++) {
		[self.paiGowObjectDictionary setObject:paiGowRowArray[i] forKey:[NSString stringWithFormat:@"Row-%d", i]];
	}
}

-(void) putAllPaiGowsOnTable {
	for (int i = 0; i < self.paiGowObjectDictionary.count; i++) {
		NSMutableArray *paiGowArray = [self paiGowRowArrayForRow:i];
		for (int j = 0; j < paiGowArray.count; j++) {	
			PaiGowObject *paiGowObject = paiGowArray[j];
			[self.tableLayer addChild:paiGowObject.pg_Sprite z:1];
		}
	}
    [self.tableLayer addChild:self.highlightLayer z:999];
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

-(void) highlightCurrentRow {
   	self.highlightLayer.visible = YES;
	self.highlightLayer.position = ccp(0, 90 + (6 - self.currentRow) * ([CCDirector sharedDirector].winSize.height - 100) / 6 - [PaiGowObject heightForPaiGow] / 2);
}

-(void) dealPaiGow {
	NSMutableArray *paiGowBaseRowArray = [self paiGowRowArrayForRow:0];
	if (paiGowBaseRowArray.count == 0) return;
	[self cancelAllSelectedPaiGow];
	if (paiGowBaseRowArray.count < self.remainRows) {
		if (self.delegate) [self.delegate showPlacePaiGowArrows];
		return;
	}
	int rowsToDeal = self.remainRows;
	float waitTimeVal = 0.1f;
	for (int i = 4; i >= 0; i--) {
		if ([self isRowCleared:i + 1]) continue;
		// Take one paitow to deal
		int paiGowToDealIndex = paiGowBaseRowArray.count - rowsToDeal;
		NSMutableArray *paiGowRowArray = [self paiGowRowArrayForRow:i + 1];
		PaiGowObject *paiGowObject = paiGowBaseRowArray[paiGowToDealIndex];
		[paiGowObject updateRow:i + 1 andColumn:paiGowRowArray.count + 1];
		// Update dic
		[paiGowRowArray addObject:paiGowObject];
		[paiGowBaseRowArray removeObjectAtIndex:paiGowToDealIndex];
		[self updateColumnForRow:0];
		//reset Position
		[self updatePaiGowPosition:0 waitTime:waitTimeVal];
		[self updatePaiGowPosition:i + 1 waitTime:waitTimeVal];
		waitTimeVal += 0.5f;
		rowsToDeal--;
	}
	[self performSelector:@selector(paiGowDealFinishedSelector) withObject:self afterDelay:waitTimeVal];
}

-(void) paiGowDealFinishedSelector {
    if (self.delegate) [self.delegate paiGowDealFinished];
	self.currentRow = [self currentFirstRow];
	[self highlightCurrentRow];
	[self updateLastHintPaiGowRow];
}

-(void) moveToNextRow {
	[self cancelAllSelectedPaiGow];
    if (self.currentRow == 5 && ![self isRowCleared:5]) return;
    if (self.currentRow == 5 && [self isRowCleared:5]) {
        self.currentRow = 999;
        [self highlightCurrentRow];
        return;
    }
    for (int i = self.currentRow + 1; i <= 5; i ++) {
        if (![self isRowCleared:i]) {
            self.currentRow = i;
            [self highlightCurrentRow];
            break;
        }
    }
}

-(BOOL) placePaiGow:(int)rowNum {
	NSMutableArray *paiGowBaseRowArray = [self paiGowRowArrayForRow:0];
	NSMutableArray *paiGowRowArray = [self paiGowRowArrayForRow:rowNum];
	if ([self remainRowAbove:rowNum] < paiGowBaseRowArray.count) {
		return NO;
	}
	PaiGowObject *paiGowObject = [paiGowBaseRowArray objectAtIndex:0];
	[paiGowObject updateRow:rowNum andColumn:paiGowRowArray.count + 1];
	[paiGowRowArray addObject:paiGowObject];
	[paiGowBaseRowArray removeObjectAtIndex:0];
	[self updateColumnForRow:0];
	[self updatePaiGowPosition:0 waitTime:0.0f];
	[self updatePaiGowPosition:rowNum waitTime:0.0f];
	self.currentRow = [self currentFirstRow];
	[self highlightCurrentRow];
	if (paiGowBaseRowArray.count == 0) {
        [self.delegate placePaiGowFinished:rowNum];
        [self updateLastHintPaiGowRow];
    }
	return YES;
}

-(RuleType) getPaiGowObjectsForRule {
	NSMutableArray *paiGowRowArray = [self paiGowRowArrayForCurrentRow];
    if (paiGowRowArray.count < 3) return RULETYPE_NONE;
	NSMutableArray *paiGowBaseRowArray = [self paiGowRowArrayForRow:0];
	NSMutableArray *paiGowSelectedArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < paiGowRowArray.count; i++) {
		PaiGowObject *paiGowObject = paiGowRowArray[i];
		if (paiGowObject.pg_isSelected) [paiGowSelectedArray addObject:paiGowObject];
	}
    // check if the selected cards are on from sides of the current stage
    if (![self checkSelectedPaiGowObjects:paiGowSelectedArray]) return RULETYPE_NONE;
	//Rule Judge
	RuleType rs = [CFSModeRuleManager getPaiGowRuleStyle:paiGowSelectedArray];
	if (rs != RULETYPE_NONE) {
		for (int i = paiGowRowArray.count - 1; i >= 0 ; i--) {		
			PaiGowObject *paiGowObject = paiGowRowArray[i];
			if (paiGowObject.pg_isSelected) {
				[paiGowRowArray removeObject:paiGowObject];
				paiGowObject.pg_rowNum = 0;
				[paiGowBaseRowArray insertObject:paiGowObject atIndex:0];
			}
		}
		[self updateColumnForRow:self.currentRow];
		[self updateColumnForRow:0];
		[self cancelAllSelectedPaiGow];
		[self updatePaiGowPosition:self.currentRow waitTime:0.0f];
		[self updatePaiGowPosition:0 waitTime:0.1f];	
	}
	return rs;
}

-(BOOL) checkSelectedPaiGowObjects:(NSMutableArray *)selectedArray {
    NSMutableArray *paiGowRowArray = [self paiGowRowArrayForCurrentRow];
    int totalCount = paiGowRowArray.count;
    PaiGowObject *paiGowObjectFirst = selectedArray[0];
    PaiGowObject *paiGowObjectSecond = selectedArray[1];
    PaiGowObject *paiGowObjectThird = selectedArray[2];
    if (paiGowObjectFirst.pg_colNum == 1 &&
        paiGowObjectSecond.pg_colNum == 2 &&
        paiGowObjectThird.pg_colNum == 3) return YES;
    
    if (paiGowObjectFirst.pg_colNum == totalCount - 2 &&
        paiGowObjectSecond.pg_colNum == totalCount - 1 &&
        paiGowObjectThird.pg_colNum == totalCount) return YES;
    
    if (paiGowObjectFirst.pg_colNum == 1 &&
        paiGowObjectSecond.pg_colNum == totalCount - 1 &&
        paiGowObjectThird.pg_colNum == totalCount) return YES;
    
    if (paiGowObjectFirst.pg_colNum == 1 &&
        paiGowObjectSecond.pg_colNum == 2 &&
        paiGowObjectThird.pg_colNum == totalCount) return YES;
    
    return NO;
}

-(BOOL) showHintPaiGow {
	[self cancelAllSelectedPaiGow];
	for (int rowNum = self.currentRow; rowNum <= 5; rowNum++) {
	    if ([self isRowCleared:rowNum]) continue;
		NSMutableArray *hintPaiGowArray = [self hintPaiGowForRow:rowNum];
		if (hintPaiGowArray.count > 0) {
			for (int i = 0; i < hintPaiGowArray.count; i++) {	
			    PaiGowObject *paiGowObject = hintPaiGowArray[i];
				paiGowObject.pg_isSelected = YES;
				[paiGowObject selectedAnimation];
			}
			return YES;
		}
	}
	return NO;
}

-(void)updateLastHintPaiGowRow {
    self.lastHintPaiGowRow = 0;
    for (int rowNum = 5; rowNum >= 1; rowNum--) {
	    NSMutableArray *paiGowRowArray = [self hintPaiGowForRow:rowNum];
	    if (paiGowRowArray.count == 0) continue;
	    self.lastHintPaiGowRow = rowNum;
        break;
	}
}

-(BOOL)isAnyPairAvialble {
	if ([self paiGowCountForRow:0] == 0 && self.lastHintPaiGowRow < self.currentRow) return NO;
	return YES;
}

-(NSMutableArray *) hintPaiGowForRow:(int)rowNum {
	NSMutableArray *hintPaiGowArray = [NSMutableArray array];
	NSMutableArray *paiGowRowArray = [self paiGowRowArrayForRow:rowNum];
	if (paiGowRowArray.count >= 3) hintPaiGowArray = [CFSModeRuleManager getHintPaiGowObjects:paiGowRowArray];    
	return hintPaiGowArray;
}

-(void) updatePaiGowPosition:(int)rowNum waitTime:(float)timeVal {
    NSMutableArray *paiGowRowArray = [self paiGowRowArrayForRow:rowNum];	
    // no paigows left
	if (paiGowRowArray.count == 0 && rowNum !=0) {
		[self markRowCleared:rowNum];
		self.remainRows--;
        [self moveToNextRow];
        if (self.delegate) [self.delegate removeBubForRow:rowNum];
        if (self.delegate) [self.delegate rowCleared:rowNum];
		return;
	}
	// less then 8 paigows left
	if (paiGowRowArray.count < 8) {
		for (int i = 0; i < paiGowRowArray.count; i++) {
			PaiGowObject *paiGowObject = paiGowRowArray[i];
            paiGowObject.pg_Sprite.visible = YES;
			[paiGowObject movePaiGowAnimationWithColumn:paiGowRowArray.count afterDelay:timeVal moveDuration:0.5f];
		}
        if (self.delegate) [self.delegate removeBubForRow:rowNum];
		return;
	}
	// too many paigows left, only show 6
	int toHide = paiGowRowArray.count - 6;
	for (int i = 0; i < 3; i++) {
		PaiGowObject *paiGowObject = paiGowRowArray[i];
		paiGowObject.pg_Sprite.visible = YES;
		[paiGowObject movePaiGowAnimationWithColumn:paiGowRowArray.count afterDelay:timeVal moveDuration:0.5f];
	}
	for (int i = paiGowRowArray.count - 3; i < paiGowRowArray.count; i++) {	
		PaiGowObject *paiGowObject = paiGowRowArray[i];
		paiGowObject.pg_Sprite.visible = YES;
		[paiGowObject movePaiGowAnimationWithColumn:paiGowRowArray.count afterDelay:timeVal moveDuration:0.5f];
	}
	for (int i = 3; i < paiGowRowArray.count - 3; i++) {
		PaiGowObject *paiGowObject = paiGowRowArray[i];
		paiGowObject.pg_Sprite.visible = NO;
	}
	PaiGowObject *paiGowObject = paiGowRowArray[0];
	CGPoint bubPosition = ccp([CCDirector sharedDirector].winSize.width / 2, paiGowObject.pg_position.y);
	if (self.delegate) [self.delegate createBubForRow:rowNum hideCount:toHide at:bubPosition];
}

-(void)updateColumnForRow:(int)rowNum {
	NSMutableArray *paiGowRowArray = [self paiGowRowArrayForRow:rowNum];	
	for (int i = 0; i < paiGowRowArray.count; i++) {
		PaiGowObject *paiGowObject = paiGowRowArray[i];
		[paiGowObject updateRow:paiGowObject.pg_rowNum andColumn:i + 1];
	}
}

-(void)cancelAllSelectedPaiGow {
	for (int i = 0; i < self.paiGowObjectDictionary.count; i++) {
		NSMutableArray *paiGowArray = [self paiGowRowArrayForRow:i];
		for (int j = 0; j < paiGowArray.count; j++) {
			PaiGowObject *paiGowObject = paiGowArray[j];
			[paiGowObject cancelSelect];
		}
	}
}

-(void)resetAllPaiGow {
	for (int i = 0; i < self.paiGowObjectDictionary.count; i++) {
		NSMutableArray *paiGowArray = [self paiGowRowArrayForRow:i];
		for (int j = 0; j < paiGowArray.count; j++) {
			PaiGowObject *paiGowObject = paiGowArray[j];
			[paiGowObject.pg_Sprite removeFromParentAndCleanup:YES];
		}
        if (self.delegate) [self.delegate removeBubForRow:i];
	}
    [self.rowStateArray removeAllObjects];
    [self.highlightLayer removeFromParentAndCleanup:YES];
	[self.paiGowObjectDictionary removeAllObjects];
	self.remainRows = 5;
	self.currentRow = 1;
	self.highlightLayer.visible = NO;
}

-(NSMutableArray *) paiGowRowArrayForRow:(int)row {
	return [self.paiGowObjectDictionary objectForKey:[NSString stringWithFormat:@"Row-%d", row]];
}

-(PaiGowObject *) anyPaiGowForRow:(int)row {
    NSMutableArray *paiGowRowArray = [self paiGowRowArrayForRow:row];
    return paiGowRowArray[0];
}

-(int)remainRowAbove:(int)rowNum {
	int remainRow = 1;
	for (int i = 1; i < rowNum; i ++) {
		if (![self isRowCleared:i]) remainRow ++;
	}
	return remainRow;
}

-(NSMutableArray *) paiGowRowArrayForCurrentRow {
	return [self paiGowRowArrayForRow:currentRow];
}

-(int) paiGowCountForRow:(int)rowNum {
    NSMutableArray *paiGowRowArray = [self paiGowRowArrayForRow:rowNum];
    return paiGowRowArray.count;
}

-(BOOL) hasPaiGowSelectedInCurrentRow {
	NSMutableArray *paiGowRowArray = [self paiGowRowArrayForCurrentRow];
	for (int i = 0; i < paiGowRowArray.count; i++) {
		PaiGowObject* paiGowObject = paiGowRowArray[i];
		if (paiGowObject.pg_isSelected) return true;
	}
	return false;
}

-(int) currentFirstRow {
	for (int i = 1; i < 6; i++) {
		if (![self isRowCleared:i]) return i;
	}
	return 0;
}

-(BOOL) isRowCleared:(int)rowNum {
    return [self.rowStateArray[rowNum] boolValue];
}

-(void) markRowCleared:(int)rowNum {
    return [self.rowStateArray replaceObjectAtIndex:rowNum withObject:[NSNumber numberWithBool:YES]];
}

-(void) handleTouch:(UITouch *)touch {
	if (self.currentRow < 1 || self.currentRow > 5) return;
	NSMutableArray *paiGowRowArray = [self paiGowRowArrayForCurrentRow];
	if (paiGowRowArray.count < 1) return;
	for (int i = 0; i < paiGowRowArray.count; i++) {
		PaiGowObject* paiGowObject = paiGowRowArray[i];
		if ([paiGowObject containsTouchLocation:touch] && paiGowObject.pg_Sprite.visible) {
			[paiGowObject selected];
			break;
		}
	}
}

@end
