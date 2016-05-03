#import "cocos2d.h"
#import "SolitaireModePaiGowManger.h"

@interface SolitaireModeGameScene : CCLayer {
	int timeCount;
	int shakeCount;
	CFSScoreData *cfsScoreData;
	NSDate *shakeStart;
	bool isPaused;
	// cocosbuilder var
    CCSprite *tabelBgSprite;
	CCMenu *functionMenu;
	CCMenu *placePaiGowMenu;
	CCLabelTTF* infoLabel;
	CCLabelTTF* timeLabel;
	CCLabelTTF* dealCardButtonLabel;
	CCLabelTTF* nextRowButtonLabel;
	CCLabelTTF* getCardButtonLabel;
	CCLabelTTF* newGameButtonLabel;
}

-(void)removeSpriteAndBegin;
-(void)runReadySetGoAnimation;

-(void)setInfoString:(NSString*) info;
-(void)clearString;

@end

@interface BubInfo : CCNode {
	int rowNum;
	int toHide;
	int yPos;	
}
@property (nonatomic) int rowNum;
@property (nonatomic) int toHide;
@property (nonatomic) int yPos;
@end