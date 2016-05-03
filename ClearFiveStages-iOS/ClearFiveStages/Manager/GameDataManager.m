#import "GameDataManager.h"
#import "SettingsManager.h"

@implementation GameDataManager

@synthesize languageType;
@synthesize gameLevel;
@synthesize tableBgIndex;
@synthesize isMusicOn;
@synthesize isSoundEffectOn;
@synthesize playerName;
@synthesize hintCount;

static GameDataManager *_sharedManager = nil;

//Init Method
+(GameDataManager *) sharedManager {
	if (!_sharedManager) {
		if( [ [GameDataManager class] isEqual:[self class]] )
			_sharedManager = [[GameDataManager alloc] init];
		else
			_sharedManager = [[self alloc] init];
	}
	return _sharedManager;
}

-(id) init {  
	if( (self=[super init]) ) {
		gameLevel = GAMELEVEL_EASY;
		hintCount = 10;
		isMusicOn = YES;
		isSoundEffectOn = YES;
        NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
        NSArray* languages = [defs objectForKey:@"AppleLanguages"];
        NSString* preferredLang = [languages objectAtIndex:0];
        self.languageType = LANGUAGE_ENGLISH;
        self.playerName = [defs objectForKey:@"PlayerName"] ? [defs objectForKey:@"PlayerName"] : @"PLAYER"; 
        if ([preferredLang isEqualToString:@"ja"]) self.languageType = LANGUAGE_JAPANESE;
        if ([preferredLang hasPrefix:@"zh-"]) self.languageType = LANGUAGE_CHINESE;
	}
	return self;
}

-(void) updateGameLevel:(GameLevel)level {
    if (gameLevel == level) return;
    gameLevel = level;
}

-(void) resetHintCount {
	if (gameLevel == GAMELEVEL_EASY) hintCount = 10;
	if (gameLevel == GAMELEVEL_NORMAL) hintCount = 5;
	if (gameLevel == GAMELEVEL_HARD) hintCount = 0; 
}

-(void) updatePlayerName:(NSString *)name {
    if ([name isEqualToString:@""]) return;
    if ([name isEqualToString:self.playerName]) return;
    self.playerName = name;
    [[NSUserDefaults standardUserDefaults] setObject:self.playerName forKey:@"PlayerName"]; 
}

-(void) dealloc {
	 [super dealloc];
}
@end
