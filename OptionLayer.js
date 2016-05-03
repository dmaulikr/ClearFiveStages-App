
var OptionLayer = function () {
	this.delegate = null;
};

OptionLayer.prototype.onDidLoadFromCCB = function () {
	var winSize = cc.Director.getInstance().getWinSize();
	this.rootNode.setPosition(cc.p(winSize.width / 2 - this.rootNode.getContentSize().width / 2, winSize.height / 2 - this.rootNode.getContentSize().height / 2));
	this.rootNode.setTouchEnabled(false);
	cc.Director.getInstance().getTouchDispatcher().addTargetedDelegate(this, cc.MENU_HANDLER_PRIORITY - 1, true);
	this.updateLanguageButton();
	this.updateCCBElements();
};

OptionLayer.prototype.updateLanguageButton = function () {
	this.languageChineseMenuItem.setEnabled(true);
	this.languageEnglishMenuItem.setEnabled(true);
	this.languageJapaneseMenuItem.setEnabled(true);
	if (GameDataManager.languageType == LANGUAGE_CHINESE) this.languageChineseMenuItem.setEnabled(false);
	if (GameDataManager.languageType == LANGUAGE_ENGLISH) this.languageEnglishMenuItem.setEnabled(false);
	if (GameDataManager.languageType == LANGUAGE_JAPANESE) this.languageJapaneseMenuItem.setEnabled(false);
}

OptionLayer.prototype.updateCCBElements = function () {
	this.optionTitleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_OPTION_TITLE));
	this.languageLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_CHOOSE_LANGUAGE));
	this.musicLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_MUSIC));
	this.soundLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_SOUND));
	this.playerNameLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_PLAYERNAME));
	this.playerName.setString(GameDataManager.playerName);
};

OptionLayer.prototype.onLanguageChinesePressed = function () {
	if (GameDataManager.languageType == LANGUAGE_CHINESE) return;
	GameDataManager.languageType = LANGUAGE_CHINESE;
	if (this.delegate) this.delegate.languageChanged();
	this.updateLanguageButton();
	this.updateCCBElements();
};

OptionLayer.prototype.onLanguageEnglishPressed = function () {
	if (GameDataManager.languageType == LANGUAGE_ENGLISH) return;
	GameDataManager.languageType = LANGUAGE_ENGLISH;
	if (this.delegate) this.delegate.languageChanged();
	this.updateLanguageButton();
	this.updateCCBElements();
};

OptionLayer.prototype.onLanguageJapanesePressed = function () {
	if (GameDataManager.languageType == LANGUAGE_JAPANESE) return;
	GameDataManager.languageType = LANGUAGE_JAPANESE;
	if (this.delegate) this.delegate.languageChanged();
	this.updateLanguageButton();
	this.updateCCBElements();
};

OptionLayer.prototype.onMusicOnPressed = function () {
	if (GameDataManager.isMusicOn) return;
	GameDataManager.isMusicOn = true;
	this.musicOnMenuItem.setEnabled(false);
	this.musicOffMenuItem.setEnabled(true);
	if (this.delegate) this.delegate.musicSettingChanged();
};

OptionLayer.prototype.onMusicOffPressed = function () {
	if (!GameDataManager.isMusicOn) return;
	GameDataManager.isMusicOn = false;
	this.musicOnMenuItem.setEnabled(true);
	this.musicOffMenuItem.setEnabled(false);
	if (this.delegate) this.delegate.musicSettingChanged();
};

OptionLayer.prototype.onSoundOnPressed = function () {
	if (GameDataManager.isSoundEffectOn) return;
	GameDataManager.isSoundEffectOn = true;
	this.soundOnMenuItem.setEnabled(false);
	this.soundOffMenuItem.setEnabled(true);
	if (this.delegate) this.delegate.soundSettingChanged();
};

OptionLayer.prototype.onSoundOffPressed = function () {
	if (!GameDataManager.isSoundEffectOn) return;
	GameDataManager.isSoundEffectOn = false;
	this.soundOnMenuItem.setEnabled(true);
	this.soundOffMenuItem.setEnabled(false);
	if (this.delegate) this.delegate.soundSettingChanged();
};

OptionLayer.prototype.onEditNamePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	var maxLength = 10;
	var playerName = null;
	while (!playerName || (playerName && playerName.length > maxLength)) {
		playerName = window.prompt(MultiLanguageUtil.getLocalizatedStringForKey(STRING_PROMPT_TITLE), 
								   MultiLanguageUtil.getLocalizatedStringForKey(STRING_PROMPT_INFO));
	}
	GameDataManager.updatePlayerName(playerName);
	this.playerName.setString(GameDataManager.playerName);
};

OptionLayer.prototype.onClosePressed = function () {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	cc.Director.getInstance().getTouchDispatcher().removeDelegate(this);
	this.rootNode.removeFromParent(true);
};
