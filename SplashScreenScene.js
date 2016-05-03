
var SplashScreen = cc.Layer.extend({
    ctor:function () {
        cc.associateWithNative( this, cc.Layer );
    },
    init:function () {
        var bRet = false;
        if (this._super()) {
			var winSize = cc.Director.getInstance().getWinSize();
			var bg = cc.Sprite.create("mainBg.png");
			bg.setPosition(cc.p(winSize.width / 2, winSize.height / 2));
			bg.setScale(0.0);
			var splashTitle = cc.Sprite.create("splashTitle.png");
			splashTitle.setPosition(cc.p(winSize.width / 2, winSize.height / 2));
			this.addChild(bg);
			bg.addChild(splashTitle, 2);
			this.runAction(cc.Sequence.create(cc.DelayTime.create(1.0), cc.CallFunc.create(this.playMusic, this), null));
			bg.runAction(cc.Sequence.create(cc.DelayTime.create(1.0), cc.ScaleTo.create(1.0, 1.0), cc.DelayTime.create(1.0), cc.CallFunc.create(this.toMainMenu, this), null));
			bRet = true;
        }
        return bRet;
    },
	playMusic:function () {
	    cc.AudioEngine.getInstance().playEffect("Openning.mp3");
	},
	toMainMenu :function () {
	    var scene = cc.BuilderReader.loadAsScene("MainMenuScene.ccbi");
    	cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
	}
});

SplashScreen.scene = function () {
    var scene = cc.Scene.create();
    var layer = SplashScreen.create();
    scene.addChild(layer);
    return scene;
};

SplashScreen.create = function () {
    var splashLayer = new SplashScreen();
    if (splashLayer && splashLayer.init()) return splashLayer;
    return null;
};
