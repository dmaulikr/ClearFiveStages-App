#import "cocos2d.h"

@protocol PauseLayerDelegate <NSObject>
@required
-(void) resumeGame;
-(void) restartGame;
-(void) toMainMenu;
@optional
@end

@interface PauseLayer : CCLayer {
    id<PauseLayerDelegate> delegate;
    // cocosbuilder vars
    CCLabelTTF *resumeGameButtonLabel;
    CCLabelTTF *restartGameButtonLabel;
    CCLabelTTF *helpButtonLabel;
    CCLabelTTF *mainMenuButtonLabel;
}

@property(nonatomic, retain) id<PauseLayerDelegate> delegate;
@end
