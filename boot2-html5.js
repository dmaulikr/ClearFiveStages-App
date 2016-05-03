var CCBMainScene = cc.Scene.extend({
    ctor:function () {
        this._super();
        GameDataManager.loadSetting();
        //var node = cc.BuilderReader.load("MainMenuScene.ccbi");
        var node = SplashScreen.create();
        this.addChild(node);
        this.setPosition(cc.p(0, 0));
    }
});
