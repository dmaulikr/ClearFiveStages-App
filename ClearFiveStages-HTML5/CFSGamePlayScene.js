var ROW_CLEARED_LABEL = 6000;
var WAITING_LABEL = 7000;

// init
var CFSGamePlayScene = function () {
};

CFSGamePlayScene.prototype.onDidLoadFromCCB = function () {
    this.tabelBgSprite.setTexture(cc.TextureCache.getInstance().addImage("tableBg{0}.jpg".format(GameDataManager.tableBgIndex)));
	this.initData();
	this.disableFunctionMenu();
	this.disablePlacePaiGowMenu();
	// update elements for multi-language support
	this.updateCCBElements();
    // schedule
    this.rootNode.onTimerUpdate = function(dt) {
        this.controller.updateTimeString();
    };
    this.rootNode.onTouchesBegan = function(touches, event) {
        this.controller.onTouchesBegan(touches, event);
        return true;
    };
    if (!this.isPaused) {
        CFSModePaiGowManager.getInstance().initAllPowGowObjects();
        this.runReadySetGoAnimation();
    }
};

CFSGamePlayScene.prototype.initData = function () {
	this.timeCount = 0;
	this.placePaiGowRowNum = 999;
	this.cfsScoreData = new CFSScoreData();
	this.isPaused = false;
	this.isGameOver = false
	this.cfsScoreData.playTimeInSec = 0;
	this.cfsScoreData.hitPercentage = 0.0;
	GameDataManager.resetHintCount();
	CFSModePaiGowManager.getInstance().tableLayer = this.rootNode;
	CFSModePaiGowManager.getInstance().delegate = this;
	this.rootNode.setTouchEnabled(false);
};

CFSGamePlayScene.prototype.onEnter = function () {
	if (!this.isPaused && !this.isGameOver) {
		CFSModePaiGowManager.getInstance().initAllPowGowObjects();
		this.runReadySetGoAnimation();
	}
};

CFSGamePlayScene.prototype.updateCCBElements = function () {
    this.dealCardButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_DEALCARD));
    this.nextRowButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_NEXTROW));
    this.getCardButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GETCARD));
    this.hintButtonLabel.setString("{0}({1})".format(MultiLanguageUtil.getLocalizatedStringForKey(STRING_SHOWHINT), GameDataManager.hintCount));
    this.timeLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_TIMER));
};

// touch
CFSGamePlayScene.prototype.onTouchesBegan = function(touches, event) {
	CFSModePaiGowManager.getInstance().handleTouch(touches[0]);
};

// function menu
CFSGamePlayScene.prototype.enableFunctionMenu = function () {
    this.dealMenuItem.setEnabled(true);
    this.getMenuItem.setEnabled(true);
    this.nextMenuItem.setEnabled(true);
    this.pauseMenuItem.setEnabled(true);
    if (GameDataManager.hintCount > 0) this.hintMenuItem.setEnabled(true);
};

CFSGamePlayScene.prototype.disableFunctionMenu = function () {
    this.dealMenuItem.setEnabled(false);
    this.getMenuItem.setEnabled(false);
    this.nextMenuItem.setEnabled(false);
    this.hintMenuItem.setEnabled(false);
    this.pauseMenuItem.setEnabled(false);
};

CFSGamePlayScene.prototype.enablePlacePaiGowMenu = function () {
    for (var rowNum = 1; rowNum <= 5; rowNum ++) {
        if (CFSModePaiGowManager.getInstance().isRowCleared(rowNum)) continue;
        var arrowSprite = new cc.Sprite();
        arrowSprite.initWithSpriteFrameName("arrowL.png");
        arrowSprite.setScale(0.7);
        var arrowMenuItem = cc.MenuItemSprite.create(arrowSprite, null, null, this.onPlacePaiGowPressed, this);
        arrowMenuItem.setTag(rowNum);
        var menu = cc.Menu.create(arrowMenuItem, null);
        var paiGowObject = CFSModePaiGowManager.getInstance().anyPaiGowForRow(rowNum);
        menu.setPosition(cc.p(cc.Director.getInstance().getWinSize().width, paiGowObject.pg_position.y));
        this.rootNode.addChild(menu, 1, 80000 + rowNum);
        menu.runAction(cc.RepeatForever.create(cc.JumpBy.create(1.0, cc.p(0, 0), 10, 1)));
    }
};

CFSGamePlayScene.prototype.disablePlacePaiGowMenu = function () {
    for (var rowNum = 1; rowNum <= 5; rowNum ++) this.rootNode.removeChildByTag(80000 + rowNum);
};

// animation
CFSGamePlayScene.prototype.runReadySetGoAnimation = function () {
    var winSize = cc.Director.getInstance().getWinSize();
    var readySetGoNode =  cc.BuilderReader.load("ReadySetGo.ccbi");
    readySetGoNode.setPosition(cc.p(winSize.width / 2, winSize.height / 2));
    this.rootNode.addChild(readySetGoNode, 999);
    readySetGoNode.animationManager.runAnimationsForSequenceNamed("ReadySetGo");
    readySetGoNode.animationManager.setCompletedAnimationCallback(this, this.removeSpriteAndBegin);
    CFSModePaiGowManager.getInstance().putAllPaiGowsOnTable();
    CFSModePaiGowManager.getInstance().turnAroundAllPaiGowRowsWithInterval(0.5);
};

// update UI
CFSGamePlayScene.prototype.updateTimeString = function () {
    this.timeCount ++;
    this.timeLabel.setString(MultiLanguageUtil.getTimeStringFromSecond(this.timeCount));
};

CFSGamePlayScene.prototype.setInfoString = function (info) {
	this.gameTipLabel.stopAllActions();
	this.gameTipLabel.setString(info);
	this.gameTipLabel.setOpacity(255);
	this.gameTipLabel.runAction(cc.Sequence.create(cc.Blink.create(1.0, 5), cc.FadeOut.create(0.5)));
};

CFSGamePlayScene.prototype.removeBubForRow = function (rowNum) {
    this.rootNode.removeChildByTag(rowNum, true);
};

CFSGamePlayScene.prototype.createBubForRow = function (rowNum, toHide, bubPosition) {
    this.rootNode.removeChildByTag(rowNum, true);
    var bub = new cc.Sprite();
    bub.initWithSpriteFrameName("bub.png");
    var bubInfoLabel = cc.LabelTTF.create("×{0}".format(toHide), "Verdana-BoldItalic", 15);
    bubInfoLabel.setColor(cc.black);
    bubInfoLabel.setPosition(cc.p(25, 25));
    bub.addChild(bubInfoLabel, 1);
    var menuItem = cc.MenuItemSprite.create(bub, null, null, this.showHiddenPaiGow, this);
    menuItem.setTag(rowNum);
    menuItem.setScale(0.7);
    var menu = cc.Menu.create(menuItem, null);
    menu.setPosition(bubPosition);
    this.rootNode.addChild(menu, 3, rowNum);
    menu.runAction(cc.RepeatForever.create(cc.JumpBy.create(1.5, cc.p(0, 0), 6, 1)));
};

CFSGamePlayScene.prototype.showHiddenPaiGow = function (sender) {
    if (this.rootNode.getChildByTag(400 + sender.getTag()) == null) {
        var layer = ShowPaiGowLayer.create(sender.getTag());
        this.rootNode.addChild(layer, 999, 400 + sender.getTag());
    }
};

CFSGamePlayScene.prototype.removeBubForRow = function (rowNum) {
    this.rootNode.removeChildByTag(rowNum, true);
};

// delegate
CFSGamePlayScene.prototype.placePaiGowFinished = function () {
    this.placePaiGowRowNum = 999;
    this.enableFunctionMenu();
    this.disablePlacePaiGowMenu();
    this.rootNode.setTouchEnabled(true);
};

CFSGamePlayScene.prototype.turnAroundAllPaiGowRowsFinished = function () {
    this.rootNode.schedule(this.rootNode.onTimerUpdate, 1.0);
    CFSModePaiGowManager.getInstance().highlightCurrentRow();
    this.enableFunctionMenu();
    this.rootNode.setTouchEnabled(true);
};

CFSGamePlayScene.prototype.paiGowDealFinished = function () {
    if (!CFSModePaiGowManager.getInstance().isAnyPairAvialble())  {
        this.rootNode.unschedule(this.rootNode.onTimerUpdate);
        // delay to anounce losing
        var that = this;
        setTimeout(function(){
            CFSModePaiGowManager.getInstance().resetAllPaiGow();
            that.gameFinishedLosing();
        }, 1000);
    }
    else {
        this.enableFunctionMenu();
        this.rootNode.setTouchEnabled(true);
    }
};

CFSGamePlayScene.prototype.showPlacePaiGowArrows = function () {
    this.enablePlacePaiGowMenu();
};

CFSGamePlayScene.prototype.restartGame = function () {
	this.rootNode.setTouchEnabled(false);
    this.timeLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_TIMER));
    GameDataManager.resetHintCount();
    this.updateCCBElements();
    this.rootNode.unschedule(this.rootNode.onTimerUpdate);
    this.timeCount = 0;
    this.isGameOver = false;
    this.cfsScoreData.playTimeInSec = 0;
    this.cfsScoreData.hitPercentage = 0.0;
    CFSModePaiGowManager.getInstance().resetAllPaiGow();
    CFSModePaiGowManager.getInstance().initAllPowGowObjects();
    this.disablePlacePaiGowMenu();
    this.runReadySetGoAnimation();
};

CFSGamePlayScene.prototype.resumeGame = function () {
	this.rootNode.setTouchEnabled(true);
    this.enableFunctionMenu();
    this.rootNode.resumeSchedulerAndActions();
    this.isPaused = false;
};

CFSGamePlayScene.prototype.toMainMenu = function () {
	CFSModePaiGowManager.getInstance().resetAllPaiGow();
	this.rootNode.setTouchEnabled(false);
	var scene = cc.BuilderReader.loadAsScene("MainMenuScene.ccbi");
    cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
};

CFSGamePlayScene.prototype.rowCleared = function (rowNum) {
    this.rootNode.removeChildByTag(ROW_CLEARED_LABEL + rowNum, true);
    var clearLabelSprite = new cc.Sprite();
    clearLabelSprite.initWithSpriteFrameName("levelInfoBg.png");
    clearLabelSprite.setScale(1.2);
    clearLabelSprite.setPosition(cc.p(cc.Director.getInstance().getWinSize().width / 2, PaiGowObject.heightForRow(rowNum)));
    var clearedInfoLabel = cc.LabelTTF.create(MultiLanguageUtil.getLocalizatedStringForKey(STRING_CLEARED), "Verdana-BoldItalic", 12.0);
    clearedInfoLabel.setColor(cc.white);
    clearedInfoLabel.setPosition(cc.p(clearLabelSprite.getContentSize().width / 2, clearLabelSprite.getContentSize().height / 2));
    clearLabelSprite.addChild(clearedInfoLabel);
    this.rootNode.addChild(clearLabelSprite, 999, ROW_CLEARED_LABEL + rowNum);
};

// menu
CFSGamePlayScene.prototype.onPausePressed = function () {
	this.rootNode.setTouchEnabled(false);
	this.disableFunctionMenu();
	this.rootNode.pauseSchedulerAndActions();
	var pauseLayer = cc.BuilderReader.load("PauseLayer.ccbi");
    pauseLayer.controller.delegate = this;
    this.rootNode.addChild(pauseLayer, 9999);
};

CFSGamePlayScene.prototype.onDealPressed = function () {
    if (CFSModePaiGowManager.getInstance().hasPaiGowSelectedInCurrentRow()) {
        if(confirm(MultiLanguageUtil.getLocalizatedStringForKey(STRING_ALERT_DEAL_MESSAGE)) == false) return;
    }
    this.rootNode.setTouchEnabled(false);
    this.disableFunctionMenu();
    CFSModePaiGowManager.getInstance().dealPaiGow();
};

CFSGamePlayScene.prototype.onPlacePaiGowPressed = function (sender) {
    var rowNum = sender.getTag();
    if (rowNum < this.placePaiGowRowNum) {
        if (CFSModePaiGowManager.getInstance().placePaiGow(rowNum)) {
            if (this.placePaiGowRowNum != 999) this.placePaiGowRowNum = rowNum;
            for (var i = rowNum; i <= 5; i ++) this.rootNode.removeChildByTag(80000 + i);
        }
    }
};

CFSGamePlayScene.prototype.onNextPressed = function () {
    if (CFSModePaiGowManager.getInstance().currentRow == 5) return;
    if (CFSModePaiGowManager.getInstance().hasPaiGowSelectedInCurrentRow()) {
        if(confirm(MultiLanguageUtil.getLocalizatedStringForKey(STRING_ALERT_NEXT_MESSAGE)) == false) return;
        CFSModePaiGowManager.getInstance().cancelAllSelectedPaiGow();
    }
    CFSModePaiGowManager.getInstance().moveToNextRow();
    if (!CFSModePaiGowManager.getInstance().isAnyPairAvialble())  {
    	this.rootNode.setTouchEnabled(false);
    	this.disableFunctionMenu();
    	this.rootNode.unschedule(this.rootNode.onTimerUpdate);
    	// delay to anounce losing
    	var that = this;
    	setTimeout(function(){
    		CFSModePaiGowManager.getInstance().resetAllPaiGow();
    		that.gameFinishedLosing();
    	}, 1000);
    }
};

CFSGamePlayScene.prototype.onGetPressed = function () {
    if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    var rs = CFSModePaiGowManager.getInstance().getPaiGowObjectsForRule();
    this.setInfoString(CFSModeRuleManager.getRuleString(rs));
    if (rs == RULETYPE_NONE) {
        this.cfsScoreData.failedHit ++;
        if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("error.mp3");
    }
    else {
        this.cfsScoreData.successfulHit ++;
    }
    if (CFSModePaiGowManager.getInstance().paiGowCountForRow(0) == 32) {
    	this.rootNode.unschedule(this.rootNode.onTimerUpdate);
    	this.rootNode.setTouchEnabled(false);
    	// delay to announce winning
    	var that = this;
    	setTimeout(function(){
    		that.disableFunctionMenu();
    		that.gameFinishedWinning();
    				}, 1000);
    }
};

CFSGamePlayScene.prototype.onHintPressed = function () {
    if (CFSModePaiGowManager.getInstance().showHintPaiGow()) {
        GameDataManager.hintCount --;
        if (GameDataManager.hintCount == 0) this.hintMenuItem.setEnabled(false);
        this.updateCCBElements();
    }
};

// game finish handle
CFSGamePlayScene.prototype.gameFinishedWinning = function () {
	CFSModePaiGowManager.getInstance().resetAllPaiGow();
    var totalHit = this.cfsScoreData.successfulHit + this.cfsScoreData.failedHit;
    this.cfsScoreData.playTimeInSec = this.timeCount;
    //this.cfsScoreData.playDate = new Date();
    this.cfsScoreData.gameLevel = GameDataManager.gameLevel;
    this.cfsScoreData.hitPercentage = (totalHit == 0 ? 0.0 : this.cfsScoreData.successfulHit * 100.0 / totalHit);
    // player name
	var playerName = null;
	var maxLength = 10;
	while (!playerName || (playerName && playerName.length > maxLength)) 
		playerName = window.prompt(MultiLanguageUtil.getLocalizatedStringForKey(STRING_PROMPT_TITLE), 
				   				   MultiLanguageUtil.getLocalizatedStringForKey(STRING_PROMPT_INFO));
	this.cfsScoreData.playerName = playerName;
	// add a waiting label
	var waitingLabel = cc.LabelTTF.create(MultiLanguageUtil.getLocalizatedStringForKey(STRING_SUBMIT_SCORE), "Verdana-BoldItalic", 24);
	waitingLabel.setColor(cc.white);
	waitingLabel.setPosition(cc.p(cc.Director.getInstance().getWinSize().width / 2, cc.Director.getInstance().getWinSize().height / 2));
    this.rootNode.addChild(waitingLabel, 999, WAITING_LABEL);
    // submit score
	var that = this;
	ScoreManager.saveScoreData(that.cfsScoreData, function (cfsScoreData) {
		var gameWinLayer = cc.BuilderReader.load("GameWinLayer.ccbi");
	    gameWinLayer.controller.delegate = that;
		if (!cfsScoreData || !cfsScoreData.id) {
			that.cfsScoreData.id = -1;
			that.rootNode.removeChildByTag(WAITING_LABEL, true);
			gameWinLayer.controller.updateScoreInfo(that.cfsScoreData);
			that.rootNode.addChild(gameWinLayer, 9999);
		}
		else {
			ScoreManager.scoreDataArrayForGameLevel(that.cfsScoreData.gameLevel, function(resultArray) {
																					for (var i = 0; i < Object.size(resultArray); i++) {
																				    	if (resultArray[i].id == cfsScoreData.id) {
																				    		cfsScoreData.rank = i + 1;
																				    		break;
																				    	}
																				    }
																					that.rootNode.removeChildByTag(WAITING_LABEL, true);
																					gameWinLayer.controller.updateScoreInfo(cfsScoreData);
																					that.rootNode.addChild(gameWinLayer, 9999);
																				 }
			);
		}});
};

CFSGamePlayScene.prototype.gameFinishedLosing = function () {
    var gameLoseLayer = cc.BuilderReader.load("GameLoseLayer.ccbi");
    gameLoseLayer.controller.delegate = this;
    this.isGameOver = true;
    this.rootNode.addChild(gameLoseLayer, 9999);
};
