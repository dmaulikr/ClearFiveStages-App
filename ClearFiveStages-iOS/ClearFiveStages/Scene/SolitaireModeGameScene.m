#import "PauseLayer.h"
#import "GameDataManager.h"
#import "HighScoreScene.h"
#import "SimpleAudioEngine.h"
#import "UIAlertView+Blocks.h"
#import "SolitaireModeGameScene.h"
#import "MultiLanguageUtil.h"
#import "CCBReader.h"
#import "CCBAnimationManager.h"
#import "ShowPaiGowLayer.h"

@implementation SolitaireModeGameScene
-(void) didLoadFromCCB {
	[self updateCCBElements];
	[[SolitaireModePaiGowManger sharedManager] setupPayers;2];
	// turn loop
	[self takeTurn];
}

-(void) callTurnLoop {
	if (isYourTurn) {
	    // info "make move"    
	}
	else {
	    // robot
	    // info "robot move"
	    [self performSelector:(robotMove) afterDelay:5.0f];
	}
}

-(void) makeMove {
	if (gameOver) {
	    return;
	}
	isYourTurn = NO;
    [self takeTurn];
}

-(void) robotMove {
	if (gameOver) {
	    return;
	}
	isYourTurn = YES;
    [self takeTurn];
}

-(void) initData {
}

#pragma mark - multi-language handle
-(void) updateCCBElements {
}

- (void) dealloc {
	[super dealloc];
}						 
@end
