#import "cocos2d.h"
#import "CFSModePaiGowManager.h"
#import "PauseLayer.h"
#import "GameWinLayer.h"
#import "GameLoseLayer.h"

@interface CFSGamePlayScene : CCLayer<CFSModePaiGowManagerDelegate, PauseLayerDelegate, GameWinLayerDelegate, GameLoseLayerDelegate> {
	int timeCount;
	CFSScoreData *cfsScoreData;
	NSDate *shakeStart;
	bool isPaused;
    bool isGameOver;
	int placePaiGowRowNum;
	// cocosbuilder var
    CCSprite *tabelBgSprite;
    CCMenuItem *dealMenuItem;
    CCMenuItem *getMenuItem;
    CCMenuItem *nextMenuItem;
    CCMenuItem *hintMenuItem;
    CCMenuItem *pauseMenuItem;
	CCMenu *placePaiGowMenu;
	CCLabelTTF* timeLabel;
	CCLabelTTF* dealCardButtonLabel;
	CCLabelTTF* nextRowButtonLabel;
	CCLabelTTF* getCardButtonLabel;
	CCLabelTTF* hintButtonLabel;
    CCLabelTTF* gameTipLabel;
}
@end
