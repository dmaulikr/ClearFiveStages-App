#import "cocos2d.h"

typedef enum
{
	RULETYPE_NONE = -1,
	RULETYPE_NORMAL = 0,
	RULETYPE_LEFT_FIVE = 1,
	RULETYPE_DIVIDE = 2,
	RULETYPE_DOUBLE = 3,
	RULETYPE_LEFT_SAME = 4,
	RULETYPE_FIVE = 5,
	RULETYPE_TTS = 6,
	RULETYPE_CONTINUE = 7
} RuleType;

@interface CFSModeRuleManager : CCNode {

}

+(RuleType)getPaiGowRuleStyle:(NSMutableArray *) paiGowArray;
+(bool)isRuleTypeTTS:(NSMutableArray *) paiGowNumArray;
+(bool)isRuleTypeDouble:(NSMutableArray *) paiGowNumArray;
+(bool)isRuleTypeFive:(NSMutableArray *) paiGowNumArray;
+(bool)isRuleTypeContinue:(NSMutableArray *) paiGowNumArray;
+(bool)isRuleTypeNormal:(NSMutableArray *) paiGowNumArray;
+(bool)isRuleTypeLeftSame:(NSMutableArray *) paiGowNumArray;
+(bool)isRuleTypeDivide:(NSMutableArray *) paiGowNumArray;
+(bool)isRuleTypeLeftFive:(NSMutableArray *) paiGowNumArray;

+(NSMutableArray *)getHintPaiGowObjects:(NSMutableArray *) paiGowArray;

+(NSString *)getRuleString:(RuleType) ruleType;

@end
