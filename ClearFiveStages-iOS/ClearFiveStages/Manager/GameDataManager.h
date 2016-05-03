#import "cocos2d.h"
#import "GameData.h"

typedef enum {
	LANGUAGE_UNKNOWN = -1,
	LANGUAGE_CHINESE = 1,
	LANGUAGE_JAPANESE = 2,
	LANGUAGE_ENGLISH = 3
} LanguageType;

typedef enum {
	GAMELEVEL_UNKNOWN = -1,
	GAMELEVEL_EASY = 1,
	GAMELEVEL_NORMAL = 2,
	GAMELEVEL_HARD = 3
} GameLevel;

@interface GameDataManager : CCNode {
	NSMutableDictionary *dataDic;
	LanguageType languageType;
	GameLevel gameLevel;
	NSString *playerName;
	int tableBgIndex;
	int hintCount;
	bool isMusicOn;
	bool isSoundEffectOn;
}

+(GameDataManager *)sharedManager;
-(void) updatePlayerName:(NSString *)name;
-(void) updateGameLevel:(GameLevel)level;
-(void) resetHintCount;

@property(nonatomic) int tableBgIndex;
@property(nonatomic) int hintCount;
@property(nonatomic) LanguageType languageType;
@property(nonatomic) GameLevel gameLevel;
@property(nonatomic) bool isMusicOn;
@property(nonatomic) bool isSoundEffectOn;
@property(nonatomic, retain) NSString *playerName;

@end
