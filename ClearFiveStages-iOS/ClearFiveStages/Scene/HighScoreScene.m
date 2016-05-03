#import "HighScoreScene.h"
#import "GameDataManager.h"
#import "MainMenuScene.h"
#import "SimpleAudioEngine.h"
#import "MultiLanguageUtil.h"
#import "CCBReader.h"
#import "ScoreManager.h"

@implementation HighScoreScene

-(void) didLoadFromCCB {
	if ([GameDataManager sharedManager].isMusicOn == YES) [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"highsocre.mp3"];
	[self updateCCBElements];
}

-(void) updateCCBElements {
	[titleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAME_HIGHSCORE]];
	[easyLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_EASY]];
	[normalLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_NORMAL]];
	[hardLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GAMELEVEL_HARD]];

	[rankTitleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_HIGHSCORE_RANK]];
	[playerNameTitleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_HIGHSCORE_PLAYERNAME]];
	[playDateTitleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_HIGHSCORE_PLAYDATE]];
	[playTimeTitleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_HIGHSCORE_COSTTIME]];
	[accurancyTitleLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_HIGHSCORE_ACCURACY]];	
}

-(void) onEnterTransitionDidFinish {
    if ([GameDataManager sharedManager].isMusicOn == YES) [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"highsocre.mp3"];
    [self initRowLabel];
    [self updateHighScoreData:GAMELEVEL_EASY];
}

-(void) initRowLabel {
	for (int i = 1; i <= 10; i++) {
		CCLayerColor *rowLayer = (CCLayerColor *)[self getChildByTag:1000 + i];
		CCLabelTTF *rankLabel = [CCLabelTTF labelWithString:@"" fontName:@"Verdana-Italic" fontSize:13.0f];
		CCLabelTTF *playerNameLabel = [CCLabelTTF labelWithString:@"" fontName:@"Verdana-Italic" fontSize:13.0f];
		CCLabelTTF *playDateLabel = [CCLabelTTF labelWithString:@"" fontName:@"Verdana-Italic" fontSize:13.0f];
		CCLabelTTF *playTimeLabel = [CCLabelTTF labelWithString:@"" fontName:@"Verdana-Italic" fontSize:13.0f];
		CCLabelTTF *accurancyLabel = [CCLabelTTF labelWithString:@"" fontName:@"Verdana-Italic" fontSize:13.0f];
		rankLabel.color = ccYELLOW;
		playerNameLabel.color = ccYELLOW;
		playDateLabel.color = ccYELLOW;
		playTimeLabel.color = ccYELLOW;
		accurancyLabel.color = ccYELLOW;
		rankLabel.position = ccp(rankTitleLabel.position.x, rowLayer.contentSize.height / 2);
		playerNameLabel.position = ccp(playerNameTitleLabel.position.x, rowLayer.contentSize.height / 2);
		playDateLabel.position = ccp(playDateTitleLabel.position.x, rowLayer.contentSize.height / 2);
		playTimeLabel.position = ccp(playTimeTitleLabel.position.x, rowLayer.contentSize.height / 2);
		accurancyLabel.position = ccp(accurancyTitleLabel.position.x, rowLayer.contentSize.height / 2);
		[rowLayer addChild:rankLabel z:1 tag:1];
		[rowLayer addChild:playerNameLabel z:1 tag:2];
		//[rowLayer addChild:playDateLabel z:1 tag:3];
		[rowLayer addChild:playTimeLabel z:1 tag:4];
		[rowLayer addChild:accurancyLabel z:1 tag:5];
	}
}

-(void) updateHighScoreData:(int)gameLevel {
	NSMutableArray *array = [NSMutableArray arrayWithArray:[[ScoreManager sharedManager] scoreDataArrayForGameLevel:gameLevel]];
	for (int i = 1; i <= 10; i++) {
		CCLayerColor *rowLayer = (CCLayerColor *)[self getChildByTag:1000 + i];
		if (i <= array.count) {
            CFSScoreData *scoreData = [array objectAtIndex:i - 1];
			CCLabelTTF *rankLabel = (CCLabelTTF *)[rowLayer getChildByTag:1];
			[rankLabel setString:[NSString stringWithFormat:@"%d", i]];
			CCLabelTTF *playerNameLabel = (CCLabelTTF *)[rowLayer getChildByTag:2];
			[playerNameLabel setString:scoreData.playerName];
//			CCLabelTTF *playDateLabel = (CCLabelTTF *)[rowLayer getChildByTag:3];
//            NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
//            [formatter setDateFormat:@"yyyy.MM.dd"];
//			[playDateLabel setString:[formatter stringFromDate:scoreData.playDate]];
			CCLabelTTF *playTimeLabel = (CCLabelTTF *)[rowLayer getChildByTag:4];
			[playTimeLabel setString:[NSString stringWithFormat:@"%@", [MultiLanguageUtil getTimeStringFromSecond:scoreData.playTimeInSec]]];
			CCLabelTTF *accurancyLabel = (CCLabelTTF *)[rowLayer getChildByTag:5];
			[accurancyLabel setString:[NSString stringWithFormat:@"%0.01f%%", scoreData.hitPercentage]];
		}
		else {		
			for (CCLabelTTF *dataLabel in [rowLayer children]) [dataLabel setString:@""];
		}
	}
}

#pragma mark - selector
-(void) onHomePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.5f scene:scene]];
}

-(void) onEasyHighScorePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	[easyModeMenuItem setIsEnabled:NO];
    [normalModeMenuItem setIsEnabled:YES];
    [hardModeMenuItem setIsEnabled:YES];
    [self updateHighScoreData:GAMELEVEL_EASY];
}

-(void) onNormalHighScorePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [easyModeMenuItem setIsEnabled:YES];
    [normalModeMenuItem setIsEnabled:NO];
    [hardModeMenuItem setIsEnabled:YES];
    [self updateHighScoreData:GAMELEVEL_NORMAL];

}
-(void) onHardHighScorePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    [easyModeMenuItem setIsEnabled:YES];
    [normalModeMenuItem setIsEnabled:YES];
    [hardModeMenuItem setIsEnabled:NO];
    [self updateHighScoreData:GAMELEVEL_HARD];
}
@end
