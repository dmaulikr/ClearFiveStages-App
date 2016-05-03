#import "cocos2d.h"
#import "OptionLayer.h"

@interface MainMenuScene : CCLayer <OptionLayerDelegate> {
    // cocosbuilder var
    CCLabelTTF *startPlayButtonLabel;
    CCLabelTTF *highScoreButtonLabel;
    CCLabelTTF *aboutButtonLabel;
    CCLabelTTF *helpButtonLabel;
}
@end
