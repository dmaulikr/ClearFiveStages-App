#import "cocos2d.h"

@protocol GameLoseLayerDelegate <NSObject>
@required
-(void) restartGame;
-(void) toMainMenu;
@optional
@end

@interface GameLoseLayer : CCLayer {
    id<GameLoseLayerDelegate> delegate;
    // cocosbuilder vars
    CCLabelTTF *titleLabel;
    CCLabelTTF *infoLabel;
    CCLabelTTF *restartButtonLabel;
    CCLabelTTF *mainMenuButtonLabel;
    CCLabelTTF *helpButtonLabel;
}

@property(nonatomic, retain) id<GameLoseLayerDelegate> delegate;
@end
