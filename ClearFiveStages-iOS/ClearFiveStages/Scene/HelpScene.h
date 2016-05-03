#import "cocos2d.h"
#import "GameDataManager.h"

@interface HelpScene : CCLayer {
	int page;
    CCLabelTTF *titleLabel;
    CCLabelTTF *subTitleLabel;
    CCLabelTTF *infoLabel;
    CCLabelTTF *currentPageLabel;
    CCLabelTTF *totalPageLabel;
}

@property(nonatomic) int page;
@end
