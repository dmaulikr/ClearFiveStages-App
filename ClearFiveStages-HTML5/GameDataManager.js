var LANGUAGE_CHINESE = 1;
var LANGUAGE_JAPANESE = 2;
var LANGUAGE_ENGLISH = 3;
var GAMELEVEL_EASY = 1;
var GAMELEVEL_NORMAL = 2;
var GAMELEVEL_HARD = 3;

var GameDataManager = function () {};
GameDataManager.languageType = LANGUAGE_ENGLISH;
GameDataManager.gameLevel = GAMELEVEL_EASY;
GameDataManager.tableBgIndex = 2;
GameDataManager.isMusicOn = true;
GameDataManager.isSoundEffectOn = true;
GameDataManager.playerName = "Raccoon";
GameDataManager.hintCount = 0;

GameDataManager.loadSetting= function () {
    GameDataManager.languageType = LANGUAGE_CHINESE;
};

GameDataManager.updatePlayerName= function (name) {
    if (name == "") return;
    if (name == GameDataManager.playerName) return;
    GameDataManager.playerName = name;
};

GameDataManager.updateGameLevel = function (level) {
    if (GameDataManager.gameLevel == level) return;
    GameDataManager.gameLevel = level;
};

GameDataManager.resetHintCount = function () {
	if (GameDataManager.gameLevel == GAMELEVEL_EASY) GameDataManager.hintCount = 10;
	if (GameDataManager.gameLevel == GAMELEVEL_NORMAL) GameDataManager.hintCount = 5;
	if (GameDataManager.gameLevel == GAMELEVEL_HARD) GameDataManager.hintCount = 0; 
};
