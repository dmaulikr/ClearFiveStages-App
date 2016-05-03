
var LevelSelectScene = function () {};

LevelSelectScene.prototype.onDidLoadFromCCB = function () {
    GameDataManager.tableBgIndex = 1;
    GameDataManager.updateGameLevel(GAMELEVEL_EASY);
	this.updateCCBElements();
};

LevelSelectScene.prototype.updateCCBElements = function () {
	this.chooseDifficultyLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_CHOOSE_GAMELEVEL));
    this.gameLevelEasyButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_EASY));
    this.gameLevelNormalButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_NORMAL));
    this.gameLevelHardButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_HARD));
    this.gameLevelEasyInfoLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_EASY_INFO));
    this.gameLevelNormalInfoLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_NORMAL_INFO));
    this.gameLevelHardInfoLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_GAMELEVEL_HARD_INFO));
    this.chooseTableBgLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_CHOOSE_TABLE));
    this.startPlayButtonLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_START_GAME));
};

LevelSelectScene.prototype.onPlayPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    var scene = cc.BuilderReader.loadAsScene("CFSGamePlayScene.ccbi");
    cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
};

LevelSelectScene.prototype.onEasyModePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    GameDataManager.updateGameLevel(GAMELEVEL_EASY);
    this.gameLevelEasyMenuItem.setEnabled(false);
    this.gameLevelNormalMenuItem.setEnabled(true);
    this.gameLevelHardMenuItem.setEnabled(true);
};

LevelSelectScene.prototype.onNormalModePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    GameDataManager.updateGameLevel(GAMELEVEL_NORMAL);
    this.gameLevelEasyMenuItem.setEnabled(true);
	this.gameLevelNormalMenuItem.setEnabled(false);
	this.gameLevelHardMenuItem.setEnabled(true);
};

LevelSelectScene.prototype.onHardModePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    GameDataManager.updateGameLevel(GAMELEVEL_HARD);
    this.gameLevelEasyMenuItem.setEnabled(true);
	this.gameLevelNormalMenuItem.setEnabled(true);
	this.gameLevelHardMenuItem.setEnabled(false);
};

LevelSelectScene.prototype.onLeftArrowPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    if (GameDataManager.tableBgIndex == 1) return;
    this.selectTableBgSprite.setTexture(cc.TextureCache.getInstance().addImage("tableBg{0}.jpg".format(--GameDataManager.tableBgIndex)));
};

LevelSelectScene.prototype.onRightArrowPressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    if (GameDataManager.tableBgIndex == 5) return;
    this.selectTableBgSprite.setTexture(cc.TextureCache.getInstance().addImage("tableBg{0}.jpg".format(++GameDataManager.tableBgIndex)));
};

LevelSelectScene.prototype.onHomePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
    var scene = cc.BuilderReader.loadAsScene("MainMenuScene.ccbi");
    cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
};

