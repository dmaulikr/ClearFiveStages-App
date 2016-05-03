#import "LevelSelectScene.h"
#import "GameDataManager.h"
#import "SimpleAudioEngine.h"
#import "MultiLanguageUtil.h"
#import "CCBReader.h"

@implementation LevelSelectScene

-(void)didLoadFromCCB {
	// update elements for multi-language support
    [[GameDataManager sharedManager] updateGameLevel:GAMELEVEL_EASY];
	[GameDataManager sharedManager].tableBgIndex = 1;
	[self updateCCBElements];
}

-(void) onEnterTransitionDidFinish {}

// multi-language handle
-(void) updateCCBElements {
    [chooseDifficultyLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_CHOOSE_GAMELEVEL]];
    [gameLevelEasyButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_EASY]];
    [gameLevelNormalButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_NORMAL]];
    [gameLevelHardButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_HARD]];
    [gameLevelEasyInfoLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_EASY_INFO]];
    [gameLevelNormalInfoLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_NORMAL_INFO]];
    [gameLevelHardInfoLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_HARD_INFO]];
    [chooseTableBgLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_CHOOSE_TABLE]];
    [startPlayButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_START_GAME]];
}

-(void)onPlayPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"CFSGamePlayScene.ccbi"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.0f scene:scene]];
}

-(void)onLeftArrowPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	if ([GameDataManager sharedManager].tableBgIndex == 1) return;
	[selectTableBgSprite setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"tableBg%d.jpg", --[GameDataManager sharedManager].tableBgIndex]]];
}

-(void)onRightArrowPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	if ([GameDataManager sharedManager].tableBgIndex == 5) return;
	[selectTableBgSprite setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"tableBg%d.jpg", ++[GameDataManager sharedManager].tableBgIndex]]];
}

-(void)onEasyModePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[[GameDataManager sharedManager] updateGameLevel:GAMELEVEL_EASY];
	[gameLevelEasyMenuItem setIsEnabled:NO];
	[gameLevelNormalMenuItem setIsEnabled:YES];
	[gameLevelHardMenuItem setIsEnabled:YES];
}

-(void)onNormalModePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[[GameDataManager sharedManager] updateGameLevel:GAMELEVEL_NORMAL];
	[gameLevelEasyMenuItem setIsEnabled:YES];
	[gameLevelNormalMenuItem setIsEnabled:NO];
	[gameLevelHardMenuItem setIsEnabled:YES];
}

-(void)onHardModePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[[GameDataManager sharedManager] updateGameLevel:GAMELEVEL_HARD];
	[gameLevelEasyMenuItem setIsEnabled:YES];
	[gameLevelNormalMenuItem setIsEnabled:YES];
	[gameLevelHardMenuItem setIsEnabled:NO];
}

-(void) onHomePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.0f scene:scene]];
}

@end
