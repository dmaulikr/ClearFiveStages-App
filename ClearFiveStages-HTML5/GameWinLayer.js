
var GameWinLayer = function () {
    this.delegate = null;
};

GameWinLayer.prototype.onDidLoadFromCCB = function () {
    var winSize = cc.Director.getInstance().getWinSize();
    this.rootNode.setPosition(cc.p(winSize.width / 2 - this.rootNode.getContentSize().width / 2, winSize.height / 2 - this.rootNode.getContentSize().height / 2));
    cc.Director.getInstance().getTouchDispatcher().addTargetedDelegate(this, cc.MENU_HANDLER_PRIORITY - 1, true);
    this.updateCCBElements();
};

GameWinLayer.prototype.updateCCBElements = function () {
    this.titleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMEWIN));
    this.gameLevelLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL));
    this.finishTimeLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_HIGHSCORE_COSTTIME));
    this.accuracyLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_HIGHSCORE_ACCURACY));
    this.scoreRankLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_HIGHSCORE_RANK));
    this.restartButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_RESTART_GAME));
    this.highscoreButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAME_HIGHSCORE));
    this.shareLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_SHARE_SCORE));
};

GameWinLayer.prototype.updateScoreInfo = function (cfsScoreData) {
	this.finishTime.setString("{0}s".format(cfsScoreData.playTimeInSec));
    this.accuracy.setString("{0}%".format(cfsScoreData.hitPercentage));
    if (cfsScoreData.id == -1) 
    	this.scoreRank.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_RANK_OUT));
    else
    	this.scoreRank.setString("{0}".format(cfsScoreData.rank));
    if (cfsScoreData.gameLevel == GAMELEVEL_EASY) this.gameLevel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_EASY));
    if (cfsScoreData.gameLevel == GAMELEVEL_NORMAL) this.gameLevel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_NORMAL));
    if (cfsScoreData.gameLevel == GAMELEVEL_HARD) this.gameLevel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_HARD));
};

GameWinLayer.prototype.onHighscorePressed = function () {
    if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    this.rootNode.removeFromParentAndCleanup(true);
    var scene = cc.BuilderReader.loadAsScene("HighScoreScene.ccbi");
    cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
};

GameWinLayer.prototype.onRestartGamePressed = function () {
	this.rootNode.removeFromParentAndCleanup(true);
    if (this.delegate) this.delegate.restartGame();
};

GameWinLayer.prototype.onShareOnTwitter = function () {
	window.open(SocialManager.createTwitterWebIntentURL("{0} @supersuraccoon".format(MultiLanguageUtil.getLocalizatedStringForKey(STRING_TWITTER_CONTENT))), "share", "height=300, width=300");
}

GameWinLayer.prototype.onShareOnFacebook = function () {
	if (PLATFORM == "FACEBOOK") {
		SocialManager.initFB();
		SocialManager.createFacebookBragDialog(MultiLanguageUtil.getLocalizatedStringForKey(STRING_FACEBOOK_CONTENT), '');
	}
	else {
		alert(MultiLanguageUtil.getLocalizatedStringForKey(STRING_FACEBOOK_ONLY));
	}
}

GameWinLayer.prototype.onShareOnSinaWeibo = function () {
	if (PLATFORM == "SINAWEIBO") {
		SocialManager.createSinaWBURL(MultiLanguageUtil.getLocalizatedStringForKey(STRING_FACEBOOK_CONTENT));
	}
	else {
		alert(MultiLanguageUtil.getLocalizatedStringForKey(STRING_SINAWEIBO_ONLY));
	}
}

