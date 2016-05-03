
var PauseLayer = function () {
    this.delegate = null;
};

PauseLayer.prototype.onDidLoadFromCCB = function () {
    var winSize = cc.Director.getInstance().getWinSize();
    this.rootNode.setPosition(cc.p(winSize.width / 2 - this.rootNode.getContentSize().width / 2, winSize.height / 2 - this.rootNode.getContentSize().height / 2));
    cc.Director.getInstance().getTouchDispatcher().addTargetedDelegate(this, cc.MENU_HANDLER_PRIORITY - 1, true);
    this.updateCCBElements();
};

PauseLayer.prototype.updateCCBElements = function () {    
    this.resumeGameButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_RESUME_GAME));
    this.helpButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAME_TUTORIAL));
    this.restartGameButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_RESTART_GAME));
    this.mainMenuButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_MAINMENU));
};

PauseLayer.prototype.onHelpPressed = function () {
    if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    var scene = cc.BuilderReader.loadAsScene("HelpScene.ccbi");
    cc.Director.getInstance().pushScene(cc.TransitionFade.create(1.0, scene));
};

PauseLayer.prototype.onMainMenuPressed = function () {
	if (this.delegate) this.delegate.toMainMenu();
	this.rootNode.removeFromParent(true);
};

PauseLayer.prototype.onResrartGamePressed = function () {
    if (this.delegate) this.delegate.restartGame();
    this.rootNode.removeFromParent(true);
};

PauseLayer.prototype.onResumeGamePressed = function () {
    if (this.delegate) this.delegate.resumeGame();
    this.rootNode.removeFromParent(true);
};
