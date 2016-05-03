var AboutScene = function () {
};

AboutScene.prototype.onDidLoadFromCCB = function () {
	if (GameDataManager.isMusicOn) cc.AudioEngine.getInstance().playMusic("main.mp3");
	var winSize = cc.Director.getInstance().getWinSize();
    var sprite = cc.Sprite.create(MultiLanguageUtil.getI18NResourceNameFrom("about.png"));
    sprite.setPosition(cc.p(winSize.width / 2, winSize.height / 2));
    this.rootNode.addChild(sprite);

    this.rootNode.setTouchEnabled(true);
    this.rootNode.onTouchesBegan = function(touches, event) {
        this.controller.onTouchesBegan(touches, event);
        return true;
    };
};

AboutScene.prototype.onTouchesBegan = function(touches, event) {
	if (GameDataManager.isSoundEffectOn) cc.AudioEngine.getInstance().playEffect("menu.mp3");
	cc.AudioEngine.getInstance().stopMusic();
	cc.Director.getInstance().popScene();
};