var Helloworld = cc.Layer.extend({
    init:function () {
        this._super();
	var bgSprite = cc.Sprite.create(s_HelloWorld);
	bgSprite.setAnchorPoint(cc.p(0, 0));
        this.addChild(bgSprite);
        return true;
    },
});

var HelloWorldScene = cc.Scene.extend({
    onEnter:function () {
        this._super();
        var layer = new Helloworld();
        layer.init();
        this.addChild(layer);
    }
});

