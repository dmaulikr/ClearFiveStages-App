#import "CFSModeRuleManager.h"
#import "PaiGowObject.h"
#import "GameDataManager.h"
#import "MultiLanguageUtil.h"

@implementation CFSModeRuleManager

+(RuleType)getPaiGowRuleStyle:(NSMutableArray *) paiGowArray {
	if (paiGowArray.count != 3) return RULETYPE_NONE;
	NSMutableArray *paiGowNumArray = [NSMutableArray array];
	for (int i = 0; i < paiGowArray.count; i++) {
		PaiGowObject *p = [paiGowArray objectAtIndex:i];
		[paiGowNumArray addObject:[NSNumber	numberWithInt:p.pg_preNum]];
		[paiGowNumArray addObject:[NSNumber	numberWithInt:p.pg_postNum]];
	}
	if ([self isRuleTypeContinue:paiGowNumArray]) return RULETYPE_CONTINUE;
	if ([self isRuleTypeTTS:paiGowNumArray]) return RULETYPE_TTS;
	if ([self isRuleTypeFive:paiGowNumArray]) return RULETYPE_FIVE;
	if ([self isRuleTypeDouble:paiGowNumArray]) return RULETYPE_DOUBLE;
	if ([self isRuleTypeDivide:paiGowNumArray]) return RULETYPE_DIVIDE;
	if ([self isRuleTypeLeftSame:paiGowNumArray]) return RULETYPE_LEFT_SAME;	
	if ([self isRuleTypeLeftFive:paiGowNumArray]) return RULETYPE_LEFT_FIVE;
	if ([self isRuleTypeNormal:paiGowNumArray]) return RULETYPE_NORMAL;
	return RULETYPE_NONE;
}

+(int) getPaiGowCountInArray:(NSMutableArray *)paiGowArray withValue:(int)cardValue {
	int count = 0;
	for (int i = 0; i < paiGowArray.count; i++) {
		int tmpVal = [[paiGowArray objectAtIndex:i] intValue];
		if (tmpVal == cardValue) count++;
	}
	return count;
}
 
+(int) cardValueInArray:(NSMutableArray *)paiGowArray withCount:(int)cardCount {
	for (int i = 0; i < paiGowArray.count; i++) {
		int cardValue = [paiGowArray[i] intValue];
		int count = [self getPaiGowCountInArray:paiGowArray withValue:cardValue];
		if (count == cardCount) return cardValue;
	}
	return 0;																					
}

+(bool)isRuleTypeTTS:(NSMutableArray *) paiGowNumArray {
	if ([self getPaiGowCountInArray:paiGowNumArray withValue:2] != 2) return NO;
	if ([self getPaiGowCountInArray:paiGowNumArray withValue:3] != 2) return NO;
	if ([self getPaiGowCountInArray:paiGowNumArray withValue:6] != 2) return NO;
	return YES;
}

+(bool)isRuleTypeDouble:(NSMutableArray *) paiGowNumArray {
	if ([self getPaiGowCountInArray:paiGowNumArray withValue:1] != 2) {
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:4] != 2) return NO;
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:5] != 2) return NO;
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:6] != 2) return NO;
		return YES;
	}
	if ([self getPaiGowCountInArray:paiGowNumArray withValue:2] != 2) {
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:4] != 2) return NO;
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:5] != 2) return NO;
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:6] != 2) return NO;
		return YES;
	}
	if ([self getPaiGowCountInArray:paiGowNumArray withValue:3] != 2) {	
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:4] != 2) return NO;
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:5] != 2) return NO;
		if ([self getPaiGowCountInArray:paiGowNumArray withValue:6] != 2) return NO;
		return YES;
	}
	return YES;
}

+(bool)isRuleTypeFive:(NSMutableArray *) paiGowNumArray {
	for (int i = 0; i < paiGowNumArray.count; i++) {	
		int tmpVal = [paiGowNumArray[i] intValue];
		int count = [self getPaiGowCountInArray:paiGowNumArray withValue:tmpVal];	
		if (count == 5) return YES;
	}
	return NO;
}

+(bool)isRuleTypeContinue:(NSMutableArray *) paiGowNumArray {
	for (int i = 1; i < 7; i++) {	
		int index = [paiGowNumArray indexOfObject:[NSNumber numberWithInt:i]];
		if (index == NSNotFound) return NO;
	}
	return YES;
}

+(bool)isRuleTypeNormal:(NSMutableArray *) paiGowNumArray {
	int cardValue = [self cardValueInArray:paiGowNumArray withCount:3];
	if (cardValue == 0) return NO;
	int count = 0;
	for (int i = 0; i < paiGowNumArray.count; i++) {
		int val = [paiGowNumArray[i] intValue];
		if (val != cardValue) count += val;
	}
	int criterionValue = ([GameDataManager sharedManager].gameLevel == GAMELEVEL_EASY) ? 13 : 14;
	return (count >= criterionValue) ? YES : NO;
}

+(bool)isRuleTypeLeftFive:(NSMutableArray *) paiGowNumArray {
	int cardValue = [self cardValueInArray:paiGowNumArray withCount:3];
	if (cardValue == 0) return NO;
	int count = 0;
	for (int i = 0; i < paiGowNumArray.count; i++) {
		int val = [paiGowNumArray[i] intValue];
		if (val != cardValue) count += val;
	}
	return (count == 5) ? YES : NO;
}

+(bool)isRuleTypeLeftSame:(NSMutableArray *) paiGowNumArray {
	int count = 0;
	int cardValue = [self cardValueInArray:paiGowNumArray withCount:4];
	if (cardValue == 0) return NO;
	for (int i = 0; i < paiGowNumArray.count; i++) {
		int val = [paiGowNumArray[i] intValue];
		if (val != cardValue) count += val;
	}
	return (count == cardValue) ? YES : NO;
}

+(bool)isRuleTypeDivide:(NSMutableArray *) paiGowNumArray {
	int cardValue = [self cardValueInArray:paiGowNumArray withCount:3];
	if (cardValue == 0) return NO;
    NSMutableArray *paiGowNumTempArray = [NSMutableArray arrayWithArray:paiGowNumArray];
	[paiGowNumTempArray removeObject:[NSNumber numberWithInt:cardValue]];
	return ([self getPaiGowCountInArray:paiGowNumTempArray withValue:[paiGowNumTempArray[0] intValue]] == 3) ? YES : NO;
}

+(NSMutableArray *) getHintPaiGowObjects:(NSMutableArray *) paiGowArray {
	int count = paiGowArray.count;
	if (count < 3) return nil;
	// check left 3 cards
	NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:paiGowArray[0], paiGowArray[1], paiGowArray[2], nil];
	if ([self getPaiGowRuleStyle:tempArray] != RULETYPE_NONE) return tempArray;
	if (count == 3) return nil;
	// check right 3 cards
	tempArray = [NSMutableArray arrayWithObjects:paiGowArray[-1], paiGowArray[-2], paiGowArray[-3], nil];
	if ([self getPaiGowRuleStyle:tempArray] != RULETYPE_NONE) return tempArray;	
	// check left 2 && right 1 cards
	tempArray = [NSMutableArray arrayWithObjects:paiGowArray[0], paiGowArray[1], paiGowArray[-1], nil];
	if ([self getPaiGowRuleStyle:tempArray] != RULETYPE_NONE) return tempArray;		
	// check left 1 && right 2 cards
	tempArray = [NSMutableArray arrayWithObjects:paiGowArray[0], paiGowArray[-1], paiGowArray[-2], nil];
	if ([self getPaiGowRuleStyle:tempArray] != RULETYPE_NONE) return tempArray;
	return nil;
}

+(NSString *) getRuleString:(RuleType) ruleType { 
	switch (ruleType) {
		case RULETYPE_NONE:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_NONE];
			break;
		case RULETYPE_NORMAL:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_NORMAL];		
			break;
		case RULETYPE_LEFT_FIVE:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_LEFT_FIVE];		
			break;
		case RULETYPE_DIVIDE:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_DIVIDE];
			break;
		case RULETYPE_DOUBLE:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_DOUBLE];
			break;
		case RULETYPE_LEFT_SAME:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_LEFT_SAME];
			break;
		case RULETYPE_FIVE:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_FIVE];
			break;
		case RULETYPE_TTS:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_TTS];
			break;
		case RULETYPE_CONTINUE:
			return [MultiLanguageUtil getLocalizatedStringForKey:STRING_PAIGOW_RULETYPE_CONTINUE];
			break;
		default:
			break;
	}
	return [NSString stringWithFormat:@""];
}
@end

#if __has_feature(objc_subscripting) 
#import <objc/runtime.h>
@implementation NSArray (NegativeIndexes)
+ (void)load {
    method_exchangeImplementations(
        class_getInstanceMethod(self, @selector(objectAtIndexedSubscript:)),
        class_getInstanceMethod(self, @selector(BLC_objectAtIndexedSubscript:))
    );
}
- (id)BLC_objectAtIndexedSubscript:(NSInteger)idx {
    if (idx < 0) idx = [self count] + idx;
    return [self BLC_objectAtIndexedSubscript:idx];
}
@end
 
@implementation NSMutableArray (NegativeIndexes)
+ (void)load {
    method_exchangeImplementations(
        class_getInstanceMethod(self, @selector(setObject:atIndexedSubscript:)),
        class_getInstanceMethod(self, @selector(BLC_setObject:atIndexedSubscript:))
    );
}
- (void)BLC_setObject:(id)anObject atIndexedSubscript:(NSInteger)idx {
    if (idx < 0) idx = [self count] + idx;
    [self BLC_setObject:anObject atIndexedSubscript:idx];
}
@end
#endif
