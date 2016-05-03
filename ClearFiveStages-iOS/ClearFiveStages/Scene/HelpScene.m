#import "HelpScene.h"
#import "MultiLanguageUtil.h"
#import "SimpleAudioEngine.h"

#define PAGE_SPRITE_TAG	8000
#define TOTAL_PAGE_COUNT 15

@implementation HelpScene
@synthesize page;

-(void) didLoadFromCCB {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"tutorial.plist"];
    self.page = 1;
    [self updatePageInfo];
    [self showHelpInfo];
}

-(void) onLeftArrowPressed {
	if (self.page == 1) return;
	self.page --;
    [self updatePageInfo];
	[self showHelpInfo];
}

-(void) onRightArrowPressed {
	if (self.page == 15) return;
	self.page ++;
    [self updatePageInfo];
	[self showHelpInfo];
}

-(void) onHomePressed {
    [[CCDirector sharedDirector] popScene];
}

-(void) updatePageInfo {
	[currentPageLabel setString:[NSString stringWithFormat:@"%d", self.page]];
	[totalPageLabel setString:[NSString stringWithFormat:@"%d", TOTAL_PAGE_COUNT]];
}

-(void) showHelpInfo {
	[self removeChildByTag:PAGE_SPRITE_TAG cleanup:YES];
    [titleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_TUTORIAL_TITLE_PAGE_0 + self.page]];
    [subTitleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_TUTORIAL_SUBTITLE_PAGE_0 + self.page]];
    [infoLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_TUTORIAL_INFO_PAGE_0 + self.page]];
    // extra png
    if (self.page > 1 && self.page < 14) {
    	CGSize winSize = [CCDirector sharedDirector].winSize;
		CCSprite *pageSprite = nil;
		if (self.page == 2 || (self.page > 5 && self.page < 14)) {
			pageSprite = [CCSprite spriteWithSpriteFrameName:[MultiLanguageUtil getI18NResourceNameFrom:[NSString stringWithFormat:@"page%d.png", self.page]]];
		}
		if (self.page == 3 || self.page == 4 || self.page == 5) {
			pageSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"page%d.png", self.page]];
		}
        if (pageSprite) {
            pageSprite.position = ccp(winSize.width / 2, winSize.height / 3);
            [self addChild:pageSprite z:999 tag:PAGE_SPRITE_TAG];
        }
    }
}

@end
