#import "PauseLayer.h"
#import "GameDataManager.h"
#import "MainMenuScene.h"
#import "HelpScene.h"
#import "SimpleAudioEngine.h"
#import "CCBReader.h"
#import "MultiLanguageUtil.h"

@implementation PauseLayer
@synthesize delegate;

-(void) didLoadFromCCB {
	CGSize winSize = [CCDirector sharedDirector].winSize;
	self.position = ccp(winSize.width / 2 - self.contentSize.width / 2, winSize.height / 2 - self.contentSize.height / 2);
	[self updateCCBElements];
}

-(void) dealloc {
	if (self.delegate) [self.delegate release];
    [super dealloc];
}

// multi-language handle
-(void) updateCCBElements {
	[resumeGameButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_RESUME_GAME]];
    [helpButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAME_TUTORIAL]];
    [restartGameButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_RESTART_GAME]];
    [mainMenuButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_MAINMENU]];
}

-(void) onResumeGamePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[self removeFromParentAndCleanup:YES];
	if (self.delegate) [self.delegate resumeGame];
}

-(void) onResrartGamePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[self removeFromParentAndCleanup:YES];
	if (self.delegate) [self.delegate restartGame];
}

-(void) onMainMenuPressed {
	[self removeFromParentAndCleanup:YES];
	if (self.delegate) [self.delegate toMainMenu];
}

- (void) onHelpPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"HelpScene.ccbi"];
	[[CCDirector sharedDirector] pushScene:scene];
}

@end
