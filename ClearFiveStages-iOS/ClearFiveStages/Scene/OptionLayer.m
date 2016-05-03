#import "OptionLayer.h"
#import "GameDataManager.h"
#import "SimpleAudioEngine.h"
#import "MultiLanguageUtil.h"
#import "YIPopupTextView.h"

@implementation OptionLayer
@synthesize delegate;

-(void) didLoadFromCCB {
	CGSize winSize = [CCDirector sharedDirector].winSize;
	self.position = ccp(winSize.width / 2 - self.contentSize.width / 2, winSize.height / 2 - self.contentSize.height / 2);
	[self setTouchEnabled:YES];
	[self updateLanguageButton];
	[self updateCCBElements];
}

-(void) registerWithTouchDispatcher {
	[[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:kCCMenuHandlerPriority swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

-(void) dealloc {
	if (self.delegate) [self.delegate release];
    [super dealloc];
}

// multi-language handle
-(void) updateCCBElements {
	[optionTitleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_OPTION_TITLE]];
	[languageLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_CHOOSE_LANGUAGE]];
	[musicLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_MUSIC]];
	[soundLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_SOUND]];
	[playerNameLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_PLAYERNAME]];
	[playerName setString:[GameDataManager sharedManager].playerName];
}

-(void) updateLanguageButton {
	[languageChineseMenuItem setIsEnabled:YES];
	[languageEnglishMenuItem setIsEnabled:YES];
	[languageJapaneseMenuItem setIsEnabled:YES];
	if ([GameDataManager sharedManager].languageType == LANGUAGE_CHINESE) [languageChineseMenuItem setIsEnabled:NO];
	if ([GameDataManager sharedManager].languageType == LANGUAGE_ENGLISH) [languageEnglishMenuItem setIsEnabled:NO];
	if ([GameDataManager sharedManager].languageType == LANGUAGE_JAPANESE) [languageJapaneseMenuItem setIsEnabled:NO];
}

-(void) onLanguageChinesePressed {
	if ([GameDataManager sharedManager].languageType == LANGUAGE_CHINESE) return;
	[GameDataManager sharedManager].languageType = LANGUAGE_CHINESE;
	if (self.delegate) [self.delegate languageChanged];
	[self updateLanguageButton];
	[self updateCCBElements];
}

-(void) onLanguageEnglishPressed {
	if ([GameDataManager sharedManager].languageType == LANGUAGE_ENGLISH) return;
	[GameDataManager sharedManager].languageType = LANGUAGE_ENGLISH;
	if (self.delegate) [self.delegate languageChanged];
	[self updateLanguageButton];
	[self updateCCBElements];
}

-(void) onLanguageJapanesePressed {
	if ([GameDataManager sharedManager].languageType == LANGUAGE_JAPANESE) return;
	[GameDataManager sharedManager].languageType = LANGUAGE_JAPANESE;
	if (self.delegate) [self.delegate languageChanged];
	[self updateLanguageButton];
	[self updateCCBElements];
}

-(void) onMusicOnPressed {
	if ([GameDataManager sharedManager].isMusicOn) return;
	[GameDataManager sharedManager].isMusicOn = YES;
	[musicOnMenuItem setIsEnabled:NO];
	[musicOffMenuItem setIsEnabled:YES];
    [self.delegate musicSettingChanged];
}

-(void) onMusicOffPressed {
	if (![GameDataManager sharedManager].isMusicOn) return;
    [GameDataManager sharedManager].isMusicOn = NO;
	[musicOnMenuItem setIsEnabled:YES];
	[musicOffMenuItem setIsEnabled:NO];
    [self.delegate musicSettingChanged];
}

-(void) onSoundOnPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn) return;
	[GameDataManager sharedManager].isSoundEffectOn = YES;
	[soundOnMenuItem setIsEnabled:NO];
	[soundOffMenuItem setIsEnabled:YES];
    [self.delegate soundSettingChanged];
}

-(void) onSoundOffPressed {
	if (![GameDataManager sharedManager].isSoundEffectOn) return;
	[GameDataManager sharedManager].isSoundEffectOn = NO;
	[soundOnMenuItem setIsEnabled:YES];
	[soundOffMenuItem setIsEnabled:NO];
    [self.delegate soundSettingChanged];
}

-(void) onEditNamePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	void(^changePlayerNameBlock)(NSString *text) = ^(NSString *text) {
											[[GameDataManager sharedManager] updatePlayerName:text];
											[playerName setString:[GameDataManager sharedManager].playerName];
	};
	YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Player name"
																		  content:@""
																		 maxCount:10
																			block:changePlayerNameBlock];	
	[popupTextView showInView:[[CCDirector sharedDirector] view]];
}

-(void) onClosePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
	[self removeFromParentAndCleanup:YES];
}

@end
