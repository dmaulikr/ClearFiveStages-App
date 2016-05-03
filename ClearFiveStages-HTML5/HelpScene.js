var HelpScene = function () {};

var PAGE_SPRITE_TAG	= 8000;
var TOTAL_PAGE_COUNT = 15;

HelpScene.prototype.onDidLoadFromCCB = function () {
    cc.SpriteFrameCache.getInstance().addSpriteFrames("tutorial.plist", "tutorial.png");
	this.page = 1;
    this.showHelpInfo();
    this.updatePageInfo();
};

HelpScene.prototype.onLeftArrowPressed = function () {
    if (this.page == 1) return;
    this.page --;
    this.showHelpInfo();
    this.updatePageInfo();
};

HelpScene.prototype.onRightArrowPressed = function () {
	if (this.page == TOTAL_PAGE_COUNT) return;
    this.page ++;
    this.showHelpInfo();
    this.updatePageInfo();
};

HelpScene.prototype.onHomePressed = function () {
    cc.Director.getInstance().popScene();
};

HelpScene.prototype.updatePageInfo = function () {
	this.currentPageLabel.setString(this.page);
	this.totalPageLabel.setString(TOTAL_PAGE_COUNT);
}

HelpScene.prototype.showHelpInfo = function () {
    var helpInfoSprite = this.rootNode.getChildByTag(999);
    this.rootNode.removeChildByTag(PAGE_SPRITE_TAG, true);
    this.titleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_TUTORIAL_TITLE_PAGE_0 + this.page));
    this.subTitleLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_TUTORIAL_SUBTITLE_PAGE_0 + this.page));
    var ss = this.infoLabel.getDimensions();
    this.infoLabel.setDimensions(new cc.Size(300, 300));
    this.infoLabel.setString(MultiLanguageUtil.getLocalizatedStringForKey(STRING_TUTORIAL_INFO_PAGE_0 + this.page));
    // extra png
    if (this.page > 1 && this.page < 14) {
    	var winSize = cc.Director.getInstance().getWinSize();
		var pageSprite = new cc.Sprite();
		if (this.page == 2 || (this.page > 5 && this.page < 14)) {
            pageSprite.initWithSpriteFrameName(MultiLanguageUtil.getI18NResourceNameFrom("page{0}.png".format(this.page)));
		}
		if (this.page == 3 || this.page == 4 || this.page == 5) {
            pageSprite.initWithSpriteFrameName("page{0}.png".format(this.page));
        }
		pageSprite.setPosition(cc.p(winSize.width / 2, winSize.height / 3));
		this.rootNode.addChild(pageSprite, 999, PAGE_SPRITE_TAG);	
    }
};


