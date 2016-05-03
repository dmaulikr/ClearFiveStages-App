#import "GameDataManager.h"
#import "SimpleAudioEngine.h"
#import "UIAlertView+Blocks.h"
#import "CFSGamePlayScene.h"
#import "MultiLanguageUtil.h"
#import "CCBReader.h"
#import "CCBAnimationManager.h"
#import "ShowPaiGowLayer.h"
#import "ScoreManager.h"

#define ROW_CLEARED_LABEL   6000

@implementation CFSGamePlayScene
-(void) didLoadFromCCB {
	// add bg
    [self initData];
	[self disableFunctionMenu];
	[self disablePlacePaiGowMenu];
	[[GameDataManager sharedManager] resetHintCount];
	// update elements for multi-language support
	[self updateCCBElements];
    [tabelBgSprite setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"tableBg%d.jpg", [GameDataManager sharedManager].tableBgIndex]]];
}

-(void) initData {
	timeCount = 0;
	placePaiGowRowNum = 999;
	shakeStart = [[NSDate alloc] init];
	cfsScoreData = [[CFSScoreData alloc] init];
    cfsScoreData.playTimeInSec = 0;
	cfsScoreData.hitPercentage = 0.0f;
	isPaused = NO;
    isGameOver = NO;
	self.touchEnabled = NO;
	[CFSModePaiGowManager sharedManager].tableLayer = self;	
	[CFSModePaiGowManager sharedManager].delegate = self;
}

#pragma mark - multi-language handle
-(void) updateCCBElements {
    [dealCardButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_DEALCARD]];
    [nextRowButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_NEXTROW]];
    [getCardButtonLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_GETCARD]];
    [hintButtonLabel setString:[NSString stringWithFormat:@"%@(%d)", [MultiLanguageUtil getLocalizatedStringForKey:STRING_SHOWHINT], [GameDataManager sharedManager].hintCount]];
    [timeLabel setString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_TIMER]];
}

#pragma mar - menu
-(void) enableFunctionMenu {
    [dealMenuItem setIsEnabled:YES];
    [getMenuItem setIsEnabled:YES];
    [nextMenuItem setIsEnabled:YES];
    [pauseMenuItem setIsEnabled:YES];
    if ([GameDataManager sharedManager].hintCount > 0) [hintMenuItem setIsEnabled:YES];
}

-(void) disableFunctionMenu {
    [dealMenuItem setIsEnabled:NO];
    [getMenuItem setIsEnabled:NO];
    [nextMenuItem setIsEnabled:NO];
    [hintMenuItem setIsEnabled:NO];
    [pauseMenuItem setIsEnabled:NO];
}

-(void) enablePlacePaiGowMenu {
    for (int rowNum = 1; rowNum <= 5; rowNum ++) {
        if ([[CFSModePaiGowManager sharedManager] isRowCleared:rowNum]) continue;
        CCSprite *arrowSprite = [CCSprite spriteWithSpriteFrameName:@"arrowL.png"];
        arrowSprite.scale = 0.7f;
        CCMenuItemSprite *arrowMenuItem = [CCMenuItemSprite itemWithNormalSprite:arrowSprite selectedSprite:nil target:self selector:@selector(onPlacePaiGowPressed:)];
        arrowMenuItem.tag = rowNum;
        CCMenu *menu = [CCMenu menuWithItems:arrowMenuItem, nil];
        PaiGowObject *paiGowObject = [[CFSModePaiGowManager sharedManager] anyPaiGowForRow:rowNum];
        menu.position = ccp([CCDirector sharedDirector].winSize.width, paiGowObject.pg_position.y);
        [self addChild:menu z:1 tag:80000 + rowNum];
        [menu runAction:[CCRepeatForever actionWithAction:[CCJumpBy actionWithDuration:1.0f position:ccp(0, 0) height:10 jumps:1]]];
    }
}

-(void) disablePlacePaiGowMenu {
    for (int rowNum = 1; rowNum <= 5; rowNum ++) [self removeChildByTag:80000 + rowNum];
}

#pragma mar - animation
-(void)runReadySetGoAnimation {
    CGSize winSize = [CCDirector sharedDirector].winSize;
	CCNode *readySetGoNode = [CCBReader nodeGraphFromFile:@"ReadySetGo.ccbi"];
    readySetGoNode.position = ccp(winSize.width / 2, winSize.height / 2);
    [self addChild:readySetGoNode z:999];
	CCBAnimationManager *animationManager = readySetGoNode.userObject;
	[animationManager setCompletedAnimationCallbackBlock:^(id sender){[self schedule:@selector(timer) interval:1.0f];}];
	[animationManager runAnimationsForSequenceNamed:@"ReadySetGo"];
    [[CFSModePaiGowManager sharedManager] putAllPaiGowsOnTable];
	[[CFSModePaiGowManager sharedManager] turnAroundAllPaiGowRowsWithInterval:0.5f];
}

-(void)setInfoString:(NSString *) info {
    [gameTipLabel stopAllActions];
    [gameTipLabel setString:info];
    [gameTipLabel runAction:[CCSequence actions:
                             [CCFadeIn actionWithDuration:0.1f],
                             [CCBlink actionWithDuration:1.0f blinks:3],
                             [CCFadeOut actionWithDuration:0.5f], nil]];
}

#pragma mark - timer
-(void)timer {
	timeCount++;
	[timeLabel setString:[MultiLanguageUtil getTimeStringFromSecond:timeCount]];
}

#pragma mark - func menu button
-(void)onDealPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	if (![[CFSModePaiGowManager sharedManager] hasPaiGowSelectedInCurrentRow]) {
		self.touchEnabled = NO;
		[[CFSModePaiGowManager sharedManager] dealPaiGow];
        [self disableFunctionMenu];
        return;
    }
	NSString* title = [MultiLanguageUtil getLocalizatedStringForKey:STRING_WARNING];
	NSString* message = [MultiLanguageUtil getLocalizatedStringForKey:STRING_ALERT_DEAL_MESSAGE];
	NSString* yesLabel = [MultiLanguageUtil getLocalizatedStringForKey:STRING_CONFIRM_YES];
	NSString* noLabel = [MultiLanguageUtil getLocalizatedStringForKey:STRING_CANCEL_NO];
	RIButtonItem *confirmItem = [RIButtonItem itemWithLabel:yesLabel];
	confirmItem.action = ^ {self.touchEnabled = NO;[self disableFunctionMenu];[[CFSModePaiGowManager sharedManager] dealPaiGow];};
	RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:noLabel];
	cancelItem.action = nil;
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
	                                                    message:message
	                                           cancelButtonItem:cancelItem
	                                           otherButtonItems:confirmItem, nil];
	[alertView show];
	[alertView release];
}

-(void) onPlacePaiGowPressed:(id)sender {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    int rowNum = ((CCMenuItemSprite *)sender).tag;
    if (rowNum < placePaiGowRowNum) {
	    if ([[CFSModePaiGowManager sharedManager] placePaiGow:rowNum]) {
		    if (placePaiGowRowNum != 999) placePaiGowRowNum = rowNum;
	    	for (int i = rowNum; i <= 5; i ++) {
				[self removeChildByTag:80000 + i];
			}
		}
	}
}
-(void) onGetPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	RuleType rs = [[CFSModePaiGowManager sharedManager] getPaiGowObjectsForRule];
	[self setInfoString:[CFSModeRuleManager getRuleString:rs]];
	if (rs == RULETYPE_NONE) {
		cfsScoreData.failedHit ++;
		if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"error.mp3"];
	}
	else {
		cfsScoreData.successfulHit ++;
	}
	if ([[CFSModePaiGowManager sharedManager] paiGowCountForRow:0] == 32) {
        // delay anounce gameFinishedWinning
        [self disableFunctionMenu];
        [self unschedule:@selector(timer)];
        [self performSelector:@selector(gameFinishedWinning) withObject:nil afterDelay:1.0f];
    }
}

-(void)onHintPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    if ([[CFSModePaiGowManager sharedManager] showHintPaiGow]) {
	    [GameDataManager sharedManager].hintCount --;
        if ([GameDataManager sharedManager].hintCount <= 0) [hintMenuItem setIsEnabled:NO];
	    [self updateCCBElements];
	}
}

-(void)onPausePressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
    isPaused = YES;
    self.touchEnabled = NO;
    [self pauseSchedulerAndActions];
    [self disableFunctionMenu];
    PauseLayer *pauseLayer = (PauseLayer *)[CCBReader nodeGraphFromFile:@"PauseLayer.ccbi"];
    pauseLayer.delegate = self;
    [self addChild:pauseLayer z:9999];
}

-(void) onNextPressed {
	if ([GameDataManager sharedManager].isSoundEffectOn == YES) [[SimpleAudioEngine sharedEngine] playEffect:@"menu.mp3"];
	if ([CFSModePaiGowManager sharedManager].currentRow == 5) return;
	if (![[CFSModePaiGowManager sharedManager] hasPaiGowSelectedInCurrentRow]) {
		[[CFSModePaiGowManager sharedManager] moveToNextRow];
		if (![[CFSModePaiGowManager sharedManager] isAnyPairAvialble]) {
            [self disableFunctionMenu];
            [self unschedule:@selector(timer)];
            [self performSelector:@selector(gameFinishedLosing) withObject:nil afterDelay:1.0f];
        }
        return;
    }
	NSString* title = [MultiLanguageUtil getLocalizatedStringForKey:STRING_WARNING];
	NSString* message = [MultiLanguageUtil getLocalizatedStringForKey:STRING_ALERT_NEXT_MESSAGE];
	NSString* yesLabel = [MultiLanguageUtil getLocalizatedStringForKey:STRING_CONFIRM_YES];
	NSString* noLabel = [MultiLanguageUtil getLocalizatedStringForKey:STRING_CANCEL_NO];
	RIButtonItem *confirmItem = [RIButtonItem itemWithLabel:yesLabel];
	confirmItem.action = ^ {[[CFSModePaiGowManager sharedManager] moveToNextRow];
        if (![[CFSModePaiGowManager sharedManager] isAnyPairAvialble]) {
            [self disableFunctionMenu];
            [self unschedule:@selector(timer)];
            [self performSelector:@selector(gameFinishedLosing) withObject:nil afterDelay:1.0f];
        }};
	RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:noLabel];
	cancelItem.action = nil;
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
	                                                    message:message
	                                           cancelButtonItem:cancelItem
	                                           otherButtonItems:confirmItem, nil];
	[alertView show];
	[alertView release];
}
#pragma mark - delegate
-(void) turnAroundAllPaiGowRowsFinished {
    [self enableFunctionMenu];
    [[CFSModePaiGowManager sharedManager] highlightCurrentRow];
    self.touchEnabled = YES;
}

-(void) paiGowDealFinished {
	[self enableFunctionMenu];
	self.touchEnabled = YES;
}

-(void) createBubForRow:(int)rowNum hideCount:(int)toHide at:(CGPoint)bubPosition {
	[self removeChildByTag:rowNum cleanup:YES];
	CCSprite *bub = [CCSprite spriteWithSpriteFrameName:@"bub.png"];
	CCLabelTTF *bubInfoLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"×%d", toHide]
											      fontName:@"Verdana-BoldItalic"
											      fontSize:15];
	bubInfoLabel.color = ccBLACK;
	bubInfoLabel.position = ccp(25, 25);
	[bub addChild:bubInfoLabel z:1];
	CCMenuItemSprite *menuItem = [CCMenuItemSprite itemWithNormalSprite:bub selectedSprite:nil target:self selector:@selector(showHiddenPaiGow:)];
    menuItem.scale = 0.7f;
    menuItem.tag = rowNum;  
	CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
	menu.position = bubPosition;
	[self addChild:menu z:3 tag:rowNum];
	[menu runAction:[CCRepeatForever actionWithAction:[CCJumpBy actionWithDuration:1.5f position:ccp(0, 0) height:6 jumps:1]]];
}

-(void) removeBubForRow:(int)rowNum {
    [self removeChildByTag:rowNum cleanup:YES];
}

-(void) placePaiGowFinished:(int)rowNum {
	placePaiGowRowNum = 999;
    [self enableFunctionMenu];
    [self disablePlacePaiGowMenu];
    self.touchEnabled = YES;
}

-(void) showPlacePaiGowArrows {
	[self enablePlacePaiGowMenu];
}

-(void)showHiddenPaiGow:(id)sender {
	int rowNum = ((CCMenuItemSprite *)sender).tag;
	if ([self getChildByTag:400 + rowNum] == nil) {
		ShowPaiGowLayer *layer = [ShowPaiGowLayer layerWithRow:rowNum];
		[self addChild:layer z:999 tag:400 + rowNum];
	}
}

-(void) gameFinishedWinning {
    [[CFSModePaiGowManager sharedManager] resetAllPaiGow];
	int totalHit = cfsScoreData.successfulHit + cfsScoreData.failedHit;
	cfsScoreData.playTimeInSec = timeCount;
	cfsScoreData.playDate = [NSDate new];
	cfsScoreData.gameLevel = [GameDataManager sharedManager].gameLevel;
	cfsScoreData.hitPercentage = (totalHit == 0 ? 0.0f : (float)cfsScoreData.successfulHit * 100.0f / (float)totalHit);
    cfsScoreData.playerName = [GameDataManager sharedManager].playerName;
    cfsScoreData.rank = [[ScoreManager sharedManager] rankForScore:cfsScoreData];
    if (cfsScoreData.rank <= 10) [[ScoreManager sharedManager] saveHighScoreData:cfsScoreData];
	GameWinLayer *gameWinLayer = (GameWinLayer *)[CCBReader nodeGraphFromFile:@"GameWinLayer.ccbi"];
	[gameWinLayer updateScoreInfo:cfsScoreData];
	gameWinLayer.delegate = self;
	[self addChild:gameWinLayer z:9999];
}

-(void) gameFinishedLosing {
    isGameOver = YES;
    [self disableFunctionMenu];
    [self unschedule:@selector(timer)];
	GameLoseLayer *gameLoseLayer = (GameLoseLayer *)[CCBReader nodeGraphFromFile:@"GameLoseLayer.ccbi"];
	gameLoseLayer.delegate = self;
	[self addChild:gameLoseLayer z:9999];
}

-(void) restartGame {
	self.touchEnabled = NO;
    isGameOver = NO;
	if ([GameDataManager sharedManager].isSoundEffectOn == YES)[[SimpleAudioEngine sharedEngine] playEffect:@"pop.mp3"];
    [timeLabel setString:[NSString stringWithFormat:@"%@0", [MultiLanguageUtil getLocalizatedStringForKey:STRING_TIMER]]];
    [[GameDataManager sharedManager] resetHintCount];
	[self updateCCBElements];
    [self removeAllRowClearedLabel];
    [self setInfoString:@""];
    [self unschedule:@selector(timer)];
    timeCount = 0;
    cfsScoreData.playTimeInSec = 0;
    cfsScoreData.hitPercentage = 0.0f;
    cfsScoreData.successfulHit = 0;
    cfsScoreData.failedHit = 0;
    [[CFSModePaiGowManager sharedManager] resetAllPaiGow];
    [[CFSModePaiGowManager sharedManager] initAllPowGowObjects];
    [self disablePlacePaiGowMenu];
    [self runReadySetGoAnimation];
}

-(void) rowCleared:(int)rowNum {
    [self removeChildByTag:ROW_CLEARED_LABEL + rowNum cleanup:YES];
    CCSprite *clearLabelSprite = [CCSprite spriteWithSpriteFrameName:@"levelInfoBg.png"];
    clearLabelSprite.scale = 1.2f;
    clearLabelSprite.position = ccp([CCDirector sharedDirector].winSize.width / 2, [PaiGowObject heightForRow:rowNum]);
    CCLabelTTF *clearedInfoLabel = [CCLabelTTF labelWithString:[MultiLanguageUtil getLocalizatedStringForKey:STRING_CLEARED]
                                                      fontName:@"Verdana-BoldItalic"
                                                      fontSize:12];
    clearedInfoLabel.color = ccWHITE;
    clearedInfoLabel.position = ccp(clearLabelSprite.contentSize.width / 2, clearLabelSprite.contentSize.height / 2);
    [clearLabelSprite addChild:clearedInfoLabel];
    [self addChild:clearLabelSprite z:999 tag:ROW_CLEARED_LABEL + rowNum];
}

-(void) removeAllRowClearedLabel {
    [self removeChildByTag:ROW_CLEARED_LABEL + 1 cleanup:YES];
    [self removeChildByTag:ROW_CLEARED_LABEL + 2 cleanup:YES];
    [self removeChildByTag:ROW_CLEARED_LABEL + 3 cleanup:YES];
    [self removeChildByTag:ROW_CLEARED_LABEL + 4 cleanup:YES];
    [self removeChildByTag:ROW_CLEARED_LABEL + 5 cleanup:YES];
}

-(void) onEnterTransitionDidFinish {
	if (!isPaused && !isGameOver) {
		[[CFSModePaiGowManager sharedManager] initAllPowGowObjects];
		[self runReadySetGoAnimation];
	}
}

-(void) resumeGame {
	self.touchEnabled = YES;
	[self resumeSchedulerAndActions];
    [self enableFunctionMenu];
	isPaused = NO;
}

-(void) toMainMenu {
    [[CFSModePaiGowManager sharedManager] resetAllPaiGow];
	CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1.0f scene:scene]];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[[CFSModePaiGowManager sharedManager] handleTouch:[touches anyObject]];
}
		 
- (void) dealloc {
	[super dealloc];
}						 
@end
