var HighScoreScene = function () {
};

HighScoreScene.prototype.onDidLoadFromCCB = function () {
	var winSize = cc.Director.getInstance().getWinSize();
	this.updateCCBElements();
	this.initRowLabel();
    this.updateHighScoreData(GAMELEVEL_EASY);
};

HighScoreScene.prototype.updateCCBElements = function () {
	this.titleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAME_HIGHSCORE));
	this.easyLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_EASY));
	this.normalLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_NORMAL));
	this.hardLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_HARD));
	this.rankTitleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_HIGHSCORE_RANK));
	this.playerNameTitleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_HIGHSCORE_PLAYERNAME));
	this.playTimeTitleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_HIGHSCORE_COSTTIME));
	this.accurancyTitleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_HIGHSCORE_ACCURACY));
};

HighScoreScene.prototype.onEnterTransitionDidFinish = function () {
	if (GameDataManager.isMusicOn) cc.AudioEngine.getInstance().playMusic("mainBg.mp3");
    this.initRowLabel();
    this.updateHighScoreData(GAMELEVEL_EASY);
}

HighScoreScene.prototype.initRowLabel = function () {
	for (var i = 1; i <= 10; i++) {
		var rowLayer = this.rootNode.getChildByTag(1000 + i);
		var rankLabel = cc.LabelTTF.create("", "Arial", 13.0);
		var playerNameLabel = cc.LabelTTF.create("", "Arial", 13.0);
		var playTimeLabel = cc.LabelTTF.create("", "Arial", 13.0);
		var accurancyLabel = cc.LabelTTF.create("", "Arial", 13.0);
		rankLabel.color = cc.YELLOW;
		playerNameLabel.color = cc.YELLOW;
		playTimeLabel.color = cc.YELLOW;
		accurancyLabel.color = cc.YELLOW;
		rankLabel.setPosition(cc.p(this.rankTitleLabel.getPosition().x, rowLayer.getContentSize().height / 2));
		playerNameLabel.setPosition(cc.p(this.playerNameTitleLabel.getPosition().x, rowLayer.getContentSize().height / 2));
		playTimeLabel.setPosition(cc.p(this.playTimeTitleLabel.getPosition().x, rowLayer.getContentSize().height / 2));
		accurancyLabel.setPosition(cc.p(this.accurancyTitleLabel.getPosition().x, rowLayer.getContentSize().height / 2));
		rowLayer.addChild(rankLabel, 1, 1);
		rowLayer.addChild(playerNameLabel, 1, 2);
		rowLayer.addChild(playTimeLabel, 1, 4);
		rowLayer.addChild(accurancyLabel, 1, 5);
	}
}

HighScoreScene.prototype.updateHighScoreData = function (gameLevel) {
	var that = this;
	var array = ScoreManager.scoreDataArrayForGameLevel(gameLevel, function(resultArray) {
		for (var i = 1; i <= 10; i++) {
			var rowLayer = that.rootNode.getChildByTag(1000 + i);
			if (i <= resultArray.length) {
	            var scoreData = resultArray[i - 1];
				var rankLabel = rowLayer.getChildByTag(1);
				rankLabel.setString(i);
				var playerNameLabel = rowLayer.getChildByTag(2);
				playerNameLabel.setString(scoreData.playerName);
				var playTimeLabel = rowLayer.getChildByTag(4);
				playTimeLabel.setString(scoreData.playTimeInSec);
				var accurancyLabel = rowLayer.getChildByTag(5);
				accurancyLabel.setString((scoreData.hitPercentage).toFixed(2) + "%");
			}
			else {
				for (var dataLabel in rowLayer.getChildren()) {
					var rankLabel = rowLayer.getChildByTag(1);
					rankLabel.setString("");
					var playerNameLabel = rowLayer.getChildByTag(2);
					playerNameLabel.setString("");
					var playTimeLabel = rowLayer.getChildByTag(4);
					playTimeLabel.setString("");
					var accurancyLabel = rowLayer.getChildByTag(5);
					accurancyLabel.setString("");
				}
			}
		}
	});
}

HighScoreScene.prototype.onHomePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    var scene = cc.BuilderReader.loadAsScene("MainMenuScene.ccbi");
    cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
};

HighScoreScene.prototype.onEasyHighScorePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	this.easyModeMenuItem.setEnabled(false);
	this.normalModeMenuItem.setEnabled(true);
	this.hardModeMenuItem.setEnabled(true);
    this.updateHighScoreData(GAMELEVEL_EASY);
};

HighScoreScene.prototype.onNormalHighScorePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	this.easyModeMenuItem.setEnabled(true);
	this.normalModeMenuItem.setEnabled(false);
	this.hardModeMenuItem.setEnabled(true);
    this.updateHighScoreData(GAMELEVEL_NORMAL);
};
HighScoreScene.prototype.onHardHighScorePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	this.easyModeMenuItem.setEnabled(true);
	this.normalModeMenuItem.setEnabled(true);
	this.hardModeMenuItem.setEnabled(false);
    this.updateHighScoreData(GAMELEVEL_HARD);
};
