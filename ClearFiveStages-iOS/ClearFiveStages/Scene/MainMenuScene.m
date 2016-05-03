#import "MainMenuScene.h"
#import "GameDataManager.h"
#import "SimpleAudioEngine.h"
#import "CCBReader.h"
#import "MultiLanguageUtil.h"
#import "CCBAnimationManager.h"
#import "AppDelegate.h"
#import "GCCache.h"

#define OPENNING_TITLE_NODE 8000

@implementation MainMenuScene

-(void) didLoadFromCCB {
	[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"mainBg.mp3"];
    [GCCache launchGameCenterWithCompletionTarget:nil action:nil];
}

-(void) onEnterTransitionDidFinish {
    if ([GameDataManager sharedManager].isMusicOn == YES) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"mainBg.mp3"];
    [self updateCCBElements];
}

// multi-language handle
-(void) updateCCBElements {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    [self removeChildByTag:OPENNING_TITLE_NODE cleanup:YES];
    CCNode *openningTitleNode = [CCBReader nodeGraphFromFile:[MultiLanguageUtil getI18NResourceNameFrom:@"OpenningTitle.ccbi"]];
    openningTitleNode.position = ccp(winSize.width / 2, winSize.height - 80);
    [self addChild:openningTitleNode z:1 tag:OPENNING_TITLE_NODE];
    CCBAnimationManager *animationManager = openningTitleNode.userObject;
    [animationManager runAnimationsForSequenceNamed:@"OpenningTitle"];
    [startPlayButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_START_GAME]];
    [highScoreButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAME_HIGHSCORE]];
    [aboutButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_ABOUT_GAME]];
    [helpButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAME_TUTORIAL]];
}

-(void) languageChanged {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [self updateCCBElements];
}

// gamecenter
-(void) onGameCenterPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [[GCViewHelper sharedGCViewHelper] showLeaderboard];
}


-(void) onGiveGiftPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/clear-5-stages/id432737724"]];
}

// setting
-(void)onOptionPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    OptionLayer *optionLayer = (OptionLayer *)[CCBReader nodeGraphFromFile:@"OptionLayer"];
    optionLayer.delegate = self;
    [self addChild:optionLayer z:9999];
}

-(void)onTellYourFriendPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[(AppController *)[[UIApplication sharedApplication] delegate] sendEmail];
}


-(void) musicSettingChanged {
    if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    if ([GameDataManager sharedManager].isMusicOn == YES)
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"mainBg.mp3"];
    else
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

-(void) soundSettingChanged {
    if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
}

// main menu
-(void)onStartPlayPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"LevelSelectScene.ccbi"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.0f scene:scene]];
}

-(void)onHighScorePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"HighScoreScene.ccbi"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.0f scene:scene]];
}

-(void)onAboutPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"AboutScene.ccbi"];
	[[CCDirector sharedDirector] pushScene:[CCTransitionFadeBL transitionWithDuration:1.0f scene:scene]];
}

-(void)onHelpPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"HelpScene.ccbi"];
	[[CCDirector sharedDirector] pushScene:[CCTransitionFadeBL transitionWithDuration:1.0f scene:scene]];
}

@end

