#import "SplashScreenLayer.h"
#import "MainMenuScene.h"
#import "GameDataManager.h"
#import "SimpleAudioEngine.h"
#import "CCBReader.h"
#import "MultiLanguageUtil.h"

#import "SettingsManager.h"

@implementation SplashScreenLayer

-(id) init {
	if( (self = [super init] )) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
		CCSprite *bg = [CCSprite spriteWithFile:@"mainBg.png"];
		bg.position = ccp(winSize.width / 2, winSize.height / 2);
		bg.scale = 0.0f;
        CCSprite *splashTitle = [CCSprite spriteWithFile:@"splashTitle.png"];
        splashTitle.position = ccp(winSize.width / 2, winSize.height / 2);
        [bg addChild:splashTitle];
		[self addChild:bg];
		[self runAction:[CCSequence actions:
						 [CCDelayTime actionWithDuration:1.0f],
						 [CCCallFunc actionWithTarget:self selector:@selector(playMusic)],
						 nil]];
		[bg runAction:[CCSequence actions:
						 [CCDelayTime actionWithDuration:2.0f],
						 [CCScaleTo actionWithDuration:1.0f scale:1.0f],
						 [CCDelayTime actionWithDuration:1.5f],
						 [CCCallFunc actionWithTarget:self
											 selector:@selector(toMainMenu)],
						 nil]];
	}
	return self;
}
		
-(void)playMusic {
	 [[SimpleAudioEngine sharedEngine] playEffect:@"Openning.mp3"];
}
-(void)toMainMenu {
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:1.5f scene:scene]];
}

@end
