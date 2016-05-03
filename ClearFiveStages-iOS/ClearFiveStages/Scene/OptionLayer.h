#import "cocos2d.h"

@protocol OptionLayerDelegate <NSObject>
@required
-(void) languageChanged;
-(void) musicSettingChanged;
-(void) soundSettingChanged;
@optional
@end

@interface OptionLayer : CCLayer {
    id<OptionLayerDelegate> delegate;
    // cocosbuilder vars
    CCLabelTTF *optionTitleLabel;
    CCLabelTTF *languageLabel;
    CCLabelTTF *musicLabel;
    CCLabelTTF *soundLabel;
    CCLabelTTF *playerNameLabel;
    CCLabelTTF *playerName;
    
    CCMenuItem *languageChineseMenuItem;
    CCMenuItem *languageEnglishMenuItem;
    CCMenuItem *languageJapaneseMenuItem;
    CCMenuItem *musicOnMenuItem;
    CCMenuItem *musicOffMenuItem;
    CCMenuItem *soundOnMenuItem;
    CCMenuItem *soundOffMenuItem;
    CCMenuItem *eidtNameMenuItem;
}

@property(nonatomic, retain) id<OptionLayerDelegate> delegate;
@end
