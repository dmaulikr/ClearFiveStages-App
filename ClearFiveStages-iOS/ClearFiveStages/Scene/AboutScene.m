#import "AboutScene.h"
#import "GameDataManager.h"
#import "SimpleAudioEngine.h"
#import "MultiLanguageUtil.h"

@implementation AboutScene

-(void) didLoadFromCCB {
    if ([GameDataManager sharedManager].isMusicOn == YES) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"main.mp3"];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite *sprite = [CCSprite spriteWithFile:[MultiLanguageUtil getI18NResourceNameFrom:@"about.png"]];
    sprite.position = ccp(winSize.width / 2, winSize.height / 2);
    [self addChild:sprite z:1];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	[[CCDirector sharedDirector] popScene];
}
@end
