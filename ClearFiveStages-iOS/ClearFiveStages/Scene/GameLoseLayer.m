#import "GameLoseLayer.h"
#import "GameDataManager.h"
#import "SimpleAudioEngine.h"
#import "MultiLanguageUtil.h"
#import "CCBReader.h"

@implementation GameLoseLayer
@synthesize delegate;

-(void) didLoadFromCCB {
	CGSize winSize = [CCDirector sharedDirector].winSize;
	self.position = ccp(winSize.width / 2 - self.contentSize.width / 2, winSize.height / 2 - self.contentSize.height / 2);
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
	[titleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELOSE]];
	[infoLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELOSE_INFO]];
	[restartButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_RESTART_GAME]];
	[mainMenuButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_MAINMENU]];
	[helpButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAME_TUTORIAL]];
}

-(void) onHelpPressed {
    if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"HelpScene.ccbi"];
	[[CCDirector sharedDirector] pushScene:scene];
}

-(void) onRestartGamePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
	[self removeFromParentAndCleanup:YES];
	if (self.delegate) [self.delegate restartGame];
}

-(void) onMainMenuPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
	[self removeFromParentAndCleanup:YES];
	if (self.delegate) [self.delegate toMainMenu];
}

@end
