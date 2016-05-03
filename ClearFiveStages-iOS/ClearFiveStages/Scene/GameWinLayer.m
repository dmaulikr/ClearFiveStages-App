#import "GameWinLayer.h"
#import "GameDataManager.h"
#import "SimpleAudioEngine.h"
#import "MultiLanguageUtil.h"
#import "CCBReader.h"
#import "AppDelegate.h"
#import <Twitter/Twitter.h>
#import "GCCache.h"
#import "YIPopupTextView.h"

@implementation GameWinLayer
@synthesize delegate;
@synthesize engine;

-(void) didLoadFromCCB {
	CGSize winSize = [CCDirector sharedDirector].winSize;
	self.position = ccp(winSize.width / 2 - self.contentSize.width / 2, winSize.height / 2 - self.contentSize.height / 2);
	[self updateCCBElements];
}

-(void) registerWithTouchDispatcher {
	[[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:kCCMenuHandlerPriority swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

-(void) dealloc {
	if (self.delegate) [self.delegate release];
    [super dealloc];
}

// multi-language handle
-(void) updateCCBElements {
	[titleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMEWIN]];
	[gameLevelLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL]];
	[finishTimeLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_HIGHSCORE_COSTTIME]];
	[accuracyLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_HIGHSCORE_ACCURACY]];
	[scoreRankLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_HIGHSCORE_RANK]];
	[restartButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_RESTART_GAME]];
	[highscoreButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAME_HIGHSCORE]];
    [shareLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_SHARE_SCORE]];
}

-(void) updateScoreInfo:(CFSScoreData *)cfsScoreData {
	[finishTime setString:[MultiLanguageUtil getTimeStringFromSecond:cfsScoreData.playTimeInSec]];
	[accuracy setString:[NSString stringWithFormat:@"%0.01f%%", cfsScoreData.hitPercentage]];
	if (cfsScoreData.rank == -1)
		[scoreRank setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_RANK_OUT]];
	else
		[scoreRank setString:[NSString stringWithFormat:@"%d", cfsScoreData.rank]];
	if (cfsScoreData.gameLevel == GAMELEVEL_EASY) [gameLevel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_EASY]];
	if (cfsScoreData.gameLevel == GAMELEVEL_NORMAL) [gameLevel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_NORMAL]];
	if (cfsScoreData.gameLevel == GAMELEVEL_HARD) [gameLevel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_HARD]];
	[self submitHighScore:cfsScoreData];
	[self submitAchievement:cfsScoreData];
}

-(void) onHighscorePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
    [self removeFromParentAndCleanup:YES];
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"HighScoreScene.ccbi"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.0f scene:scene]];
}

-(void) onRestartGamePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
	[self removeFromParentAndCleanup:YES];
	if (self.delegate) [self.delegate restartGame];
}

-(void) onShareOnTwitter {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	 if ([TWTweetComposeViewController canSendTweet]) {
		TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
		[tweetSheet setInitialText:[MultiLanguageUtil getLocalizatedStringForKey:STRING_TWITTER_CONTENT]];
		[tweetSheet addImage:[UIImage imageNamed:@"Icon.png"]];
		[tweetSheet addURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/clear-5-stages/id432737724"]];
         AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
		[app.navController presentModalViewController:tweetSheet animated:YES];
         [tweetSheet release];
	 }
	 else {
		 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
		                           	   	   	   	   	   	     message:@"Make sure your device has an internet connection and you have at least one Twitter account setup"                                                          
		                           	   	   	   	   	   	    delegate:self                                              
		                           	   	   	   	   cancelButtonTitle:@"OK"                                                   
		                           	   	   	   	   otherButtonTitles:nil];
	     [alertView show];
         [alertView release];
	 }
}

-(void) onShareOnFacebook {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	NSString *urlString = @"http://itunes.apple.com/us/app/clear-5-stages/id432737724";
	NSString *title = [MultiLanguageUtil getLocalizatedStringForKey:STRING_FACEBOOK_CONTENT];
	NSString *shareUrlString = [NSString stringWithFormat:@"http://www.facebook.com/sharer.php?u=%@&t=%@", urlString , title];
	shareUrlString = [shareUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [[NSURL alloc] initWithString:shareUrlString];
	[[UIApplication sharedApplication] openURL:url];
	[url release];
}

-(void) onShareOnSinaWeibo {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    self.engine = [[WBEngine alloc] initWithAppKey:@"xxxxxx"
                                         appSecret:@"xxxxxx"];
    [self.engine setDelegate:self];
    [self.engine logIn];
}

- (void)engineDidLogIn:(WBEngine *)engine {
    void(^sendWeibo)(NSString *text) = ^(NSString *text) {
        [self.engine sendWeiBoWithText:text image:[UIImage imageNamed:@"iTunesArtwork.png"]];
	};
	YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@""
																		  content:[MultiLanguageUtil getLocalizatedStringForKey:STRING_EMAIL_CONTENT]
																		 maxCount:140
																			block:sendWeibo];
	[popupTextView showInView:[[CCDirector sharedDirector] view]];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登录失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engineDidLogOut:(WBEngine *)engine {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"登出成功！"
													  delegate:self
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engineAuthorizeExpired:(WBEngine *)engine {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"请重新登录！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error; {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"发送失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];

}

- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"发送成功！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

#pragma mark - GameCenter
-(void) submitHighScore:(CFSScoreData *)cfsScoreData {
    if ([GameDataManager sharedManager].gameLevel == GAMELEVEL_EASY)
        [[GCCache authenticatedCache] submitScore:[NSNumber numberWithInt:cfsScoreData.playTimeInSec] toLeaderboard:@"com.clearfivestages.EasyMode"];
    if ([GameDataManager sharedManager].gameLevel == GAMELEVEL_NORMAL)
        [[GCCache authenticatedCache] submitScore:[NSNumber numberWithInt:cfsScoreData.playTimeInSec] toLeaderboard:@"com.clearfivestages.NormalMode"];
    if ([GameDataManager sharedManager].gameLevel == GAMELEVEL_HARD)
        [[GCCache authenticatedCache] submitScore:[NSNumber numberWithInt:cfsScoreData.playTimeInSec] toLeaderboard:@"com.clearfivestages.HardMode"];
}

-(void) scoreReported:(NSError *)error {}

-(void) submitAchievement:(CFSScoreData *)cfsScoreData {
    if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.FirstWin"])
        [[GCCache authenticatedCache] unlockAchievement:@"com.clearfivestages.FirstWin"];
    
	if (cfsScoreData.gameLevel == GAMELEVEL_EASY) {
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheRookie"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheRookie"];
            [[GCCache authenticatedCache] submitProgress:pr + 10.0f toAchievement:@"com.clearfivestages.TheRookie"];
        }
    }
	if (cfsScoreData.gameLevel == GAMELEVEL_NORMAL) {
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheBeginner"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheBeginner"];
            [[GCCache authenticatedCache] submitProgress:pr + 10.0f toAchievement:@"com.clearfivestages.TheBeginner"];
        }
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheSenior"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheSenior"];
            [[GCCache authenticatedCache] submitProgress:pr + 2.0f toAchievement:@"com.clearfivestages.TheSenior"];
        }
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheAllstar"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheAllstar"];
            [[GCCache authenticatedCache] submitProgress:pr + 1.0f toAchievement:@"com.clearfivestages.TheAllstar"];
        }
	}
    if (cfsScoreData.gameLevel == GAMELEVEL_HARD) {
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheJunior"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheJunior"];
            [[GCCache authenticatedCache] submitProgress:pr + 10.0f toAchievement:@"com.clearfivestages.TheJunior"];
        }
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheSenior"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheSenior"];
            [[GCCache authenticatedCache] submitProgress:pr + 2.0f toAchievement:@"com.clearfivestages.TheSenior"];
        }
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheAllstar"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheAllstar"];
            [[GCCache authenticatedCache] submitProgress:pr + 1.0f toAchievement:@"com.clearfivestages.TheAllstar"];
        }
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheSuperstar"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheSuperstar"];
            [[GCCache authenticatedCache] submitProgress:pr + 2.0f toAchievement:@"com.clearfivestages.TheSuperstar"];
        }
        if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.TheHalloffame"]) {
            double pr = [[GCCache authenticatedCache] progressOfAchievement:@"com.clearfivestages.TheHalloffame"];
            [[GCCache authenticatedCache] submitProgress:pr + 1.0f toAchievement:@"com.clearfivestages.TheHalloffame"];
        }
        if (cfsScoreData.playTimeInSec <= 60) {
            if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.Theluckguy"])
                [[GCCache authenticatedCache] unlockAchievement:@"com.clearfivestages.Theluckguy"];
        }
        if (cfsScoreData.hitPercentage == 100.0f) {
            if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.Theperfectguy"])
                [[GCCache authenticatedCache] unlockAchievement:@"com.clearfivestages.Theperfectguy"];
        }
        if (cfsScoreData.playTimeInSec <= 120) {
            if (![[GCCache authenticatedCache] isUnlockedAchievement:@"com.clearfivestages.Thequickguy"])
                [[GCCache authenticatedCache] unlockAchievement:@"com.clearfivestages.Thequickguy"];
        }
	}
}


@end
