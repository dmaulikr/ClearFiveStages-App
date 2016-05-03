#import "cocos2d.h"
#import "ScoreManager.h"

@interface HighScoreScene : CCLayer {
    // cocosbuilder var
    CCLabelTTF *titleLabel;
    CCLabelTTF *easyLabel;
    CCLabelTTF *normalLabel;
    CCLabelTTF *hardLabel;
    CCLabelTTF *rankTitleLabel;
    CCLabelTTF *playerNameTitleLabel;
    CCLabelTTF *playDateTitleLabel;
    CCLabelTTF *playTimeTitleLabel;
    CCLabelTTF *accurancyTitleLabel;
    
    CCMenuItem *easyModeMenuItem;
    CCMenuItem *normalModeMenuItem;
    CCMenuItem *hardModeMenuItem;
}
-(void) initRowLabel;
-(void) updateHighScoreData:(int)gameLevel;

@property(nonatomic, retain) CFSScoreData *cfsScoreData;
@end
