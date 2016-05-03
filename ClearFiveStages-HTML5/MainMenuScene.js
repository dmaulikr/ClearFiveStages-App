var OPENNING_TITLE_NODE = 8000; 

var MainMenuScene = function () {
	cc.AudioEngine.getInstance().preloadMusic("mainBg.mp3");
};

MainMenuScene.prototype.onDidLoadFromCCB = function () {
	SocialManager.initParse();
	cc.SpriteFrameCache.getInstance().addSpriteFrames("element.plist", "element.png");
    //update elements for multi-language support
    this.updateCCBElements();
    this.rootNode.onEnterTransitionDidFinish = function () {
    	cc.AudioEngine.getInstance().playMusic("mainBg.mp3");
    };
};

MainMenuScene.prototype.updateCCBElements = function () {
	var winSize = cc.Director.getInstance().getWinSize();
	this.rootNode.removeChildByTag(OPENNING_TITLE_NODE, true);
    var openningTitleNode = cc.BuilderReader.load(MultiLanguageUtil.getI18NResourceNameFrom("OpenningTitle.ccbi"));
    openningTitleNode.setPosition(cc.p(winSize.width / 2, winSize.height - 80));
    this.rootNode.addChild(openningTitleNode, 999, OPENNING_TITLE_NODE);
    openningTitleNode.animationManager.runAnimationsForSequenceNamed("OpenningTitle");
    this.startPlayButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_START_GAME));
    this.highScoreButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAME_HIGHSCORE));
    this.aboutButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_ABOUT_GAME));
    this.helpButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAME_TUTORIAL));
};

// menu function
MainMenuScene.prototype.onGameCenterPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	alert(MultiLanguageUtil.getLocalizatedStringForKey(STRING_IOS_ONLY));
};

MainMenuScene.prototype.onOptionPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	var optionLayer = cc.BuilderReader.load("OptionLayer.ccbi");
	optionLayer.controller.delegate = this;
	this.rootNode.addChild(optionLayer, 9999);
};

MainMenuScene.prototype.onTellYourFriendPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	alert(MultiLanguageUtil.getLocalizatedStringForKey(STRING_IOS_ONLY));
};

MainMenuScene.prototype.onStartPlayPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    var scene = cc.BuilderReader.loadAsScene("LevelSelectScene.ccbi");
    cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
};

MainMenuScene.prototype.onHighScorePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    var scene = cc.BuilderReader.loadAsScene("HighScoreScene.ccbi");
    cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
};

MainMenuScene.prototype.onHelpPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	var scene = cc.BuilderReader.loadAsScene("HelpScene.ccbi");
	cc.Director.getInstance().pushScene(cc.TransitionFade.create(1.0, scene));
};

MainMenuScene.prototype.onAboutPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    var scene = cc.BuilderReader.loadAsScene("AboutScene.ccbi");
    cc.Director.getInstance().pushScene(cc.TransitionFade.create(1.0, scene));
};

MainMenuScene.prototype.onGiveGiftPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    window.open("http://itunes.apple.com/us/app/clear-5-stages/id432737724", "ClearFiveStages");
};


// delegate
MainMenuScene.prototype.musicSettingChanged = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	if (GameDataManager.isMusicOn) 
		cc.AudioEngine.getInstance().playMusic("mainBg.mp3");
	else
		cc.AudioEngine.getInstance().stopMusic();	
};

MainMenuScene.prototype.soundSettingChanged = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
};

MainMenuScene.prototype.languageChanged = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    this.updateCCBElements();
};
