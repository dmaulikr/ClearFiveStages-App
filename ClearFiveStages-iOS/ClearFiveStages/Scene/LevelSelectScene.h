#import "cocos2d.h"

@interface LevelSelectScene : CCLayer {
    // cocosbuilder var
    CCSprite *selectTableBgSprite;
    CCLabelTTF *chooseDifficultyLabel;
    CCLabelTTF *gameLevelEasyButtonLabel;
    CCLabelTTF *gameLevelEasyInfoLabel;
    CCLabelTTF *gameLevelNormalButtonLabel;
    CCLabelTTF *gameLevelNormalInfoLabel;
    CCLabelTTF *gameLevelHardButtonLabel;
    CCLabelTTF *gameLevelHardInfoLabel;
    CCLabelTTF *chooseTableBgLabel;
    CCLabelTTF *startPlayButtonLabel;
    CCMenuItem *gameLevelEasyMenuItem;
    CCMenuItem *gameLevelNormalMenuItem;
    CCMenuItem *gameLevelHardMenuItem;
}

@end
