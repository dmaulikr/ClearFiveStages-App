
var GameLoseLayer = function () {
    this.delegate = null;
};

GameLoseLayer.prototype.onDidLoadFromCCB = function () {
    var winSize = cc.Director.getInstance().getWinSize();
    this.rootNode.setPosition(cc.p(winSize.width / 2 - this.rootNode.getContentSize().width / 2, winSize.height / 2 - this.rootNode.getContentSize().height / 2));
    cc.Director.getInstance().getTouchDispatcher().addTargetedDelegate(this, cc.MENU_HANDLER_PRIORITY - 1, true);
    this.updateCCBElements();
};

GameLoseLayer.prototype.updateCCBElements = function () {    
    this.titleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELOSE));
    this.infoLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELOSE_INFO));
    this.restartButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_RESTART_GAME));
    this.mainMenuButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_MAINMENU));
    this.helpButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAME_TUTORIAL));
};

GameLoseLayer.prototype.onHelpPressed = function () {
    if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    this.rootNode.removeFromParent(true);
    var scene = cc.BuilderReader.loadAsScene("HelpScene.ccbi");
    cc.Director.getInstance().pushScene(cc.TransitionFade.create(1.0, scene));
};

GameLoseLayer.prototype.onMainMenuPressed = function () {
	this.rootNode.removeFromParent(true);
    if (this.delegate) this.delegate.toMainMenu();
};

GameLoseLayer.prototype.onRestartGamePressed = function () {
    this.rootNode.removeFromParent(true);
    if (this.delegate) this.delegate.restartGame();
};