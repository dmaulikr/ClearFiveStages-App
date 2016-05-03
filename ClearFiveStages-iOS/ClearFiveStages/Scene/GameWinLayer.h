#import "cocos2d.h"
#import "GameData.h"
#import "WBEngine.h"

@protocol GameWinLayerDelegate <NSObject>
@required
-(void) restartGame;
-(void) toMainMenu;
@optional
@end

@interface GameWinLayer : CCLayer <WBEngineDelegate> {
    id<GameWinLayerDelegate> delegate;
    // cocosbuilder vars
    CCLabelTTF *titleLabel;
    CCLabelTTF *restartButtonLabel;
    CCLabelTTF *highscoreButtonLabel;

    CCLabelTTF *finishTimeLabel;
    CCLabelTTF *accuracyLabel;
    CCLabelTTF *scoreRankLabel;
    CCLabelTTF *gameLevelLabel;
        
    CCLabelTTF *finishTime;
    CCLabelTTF *accuracy;
    CCLabelTTF *scoreRank;
    CCLabelTTF *gameLevel;
    
    CCLabelTTF *shareLabel;
    
    WBEngine *engine;
}

-(void) updateScoreInfo:(CFSScoreData *)cfsScoreData;

@property(nonatomic, retain) id<GameWinLayerDelegate> delegate;
@property(nonatomic, retain) WBEngine *engine;
@end
