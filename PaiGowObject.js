var PaiGowObject = cc.Sprite.extend({
    pg_sprite:null,
    pg_name:"",
    pg_detail:"",
    pg_preNum:-1,
    pg_postNum:-1,
    pg_rowNum:-1,
    pg_colNum:-1,
    pg_isSelected:false,
    pg_position:cc.p(0, 0),
    init:function (i, j, r, c) {
    	var bRet = false;
        if (this._super()) {
		    this.pg_name = "{0}-{1}.png".format(i, j);
		    this.pg_detail = "";
		    this.pg_preNum = i;
		    this.pg_postNum = j;
		    this.pg_rowNum = r;
		    this.pg_colNum = c;
		    this.pg_isSelected = false;
		    this.pg_sprite = new cc.Sprite();
		    this.pg_sprite.initWithSpriteFrameName("back.png");
		    this.pg_sprite.position = this.pg_position;
		    bRet = true;
		}
		return bRet;
    },
    // touch
    rect:function () {
        return cc.rect
            (this.pg_sprite.getPositionX() - this.pg_sprite._contentSize.width / 2,
                this.pg_sprite.getPositionY() - this.pg_sprite._contentSize.height / 2,
                this.pg_sprite._contentSize.width,
                this.pg_sprite._contentSize.height);
    },
    containsTouchLocation:function (touch) {
        return cc.Rect.CCRectContainsPoint(this.rect(), touch.getLocation());
    },
    selected:function () {
    	this.pg_isSelected = !this.pg_isSelected;
    	this.selectedAnimation();
    },
    // animation
    movePaiGowAnimation:function (columnCount, delay, moveDuration) {
	    this.pg_position = this.calcPositionWithPaiGowsInRow(columnCount);
        this.pg_sprite.runAction(cc.Sequence.create(cc.DelayTime.create(delay), cc.MoveTo.create(moveDuration, this.pg_position), null));
	},
    turnAroundAnimation:function () {
        this.pg_sprite.initWithSpriteFrameName(this.pg_name);
        this.pg_sprite.setOpacity(0.0);
        this.pg_sprite.setPosition(this.pg_position);
        this.pg_sprite.runAction(cc.FadeIn.create(1.0));
    },
    selectedAnimation:function () {
        if (this.pg_isSelected) {
            this.pg_sprite.runAction(cc.RepeatForever.create(cc.JumpBy.create(1.0, cc.p(0, 0), 10, 2)));
        }
        else {
            this.pg_sprite.stopAllActions();
            this.pg_sprite.setPosition(this.pg_position);
        }
    },
    cancelSelect:function () {
        if (this.pg_isSelected) this.pg_sprite.stopAllActions();
        this.pg_sprite.setPosition(this.pg_position);
        this.pg_isSelected = false;
    },
    // position
    calcPositionWithPaiGowsInRow:function (paiGowCount) {
		var resultPosition = cc.p(0, 0);
		var winSize = cc.Director.getInstance().getWinSize();
		if (paiGowCount < 8) {
			resultPosition.x = (7 - paiGowCount) * 20 + this.pg_colNum * 40;
		}
		else {
			resultPosition.x = (this.pg_colNum < 4) ? this.pg_colNum * 40 : (this.pg_colNum - paiGowCount + 7) * 40;
		}
		resultPosition.y = (this.pg_rowNum == 0) ? 90 : 90 + (6 - this.pg_rowNum) * (winSize.height - 100) / 6;
		return resultPosition;
	},
	updateRowAndColumn:function (row, column) {
		this.pg_rowNum = row;
        this.pg_colNum = column;
	}
});

PaiGowObject.createPaiGowObject = function (i, j, r, c) {
    var paiGowObject = new PaiGowObject();
    if (paiGowObject && paiGowObject.init(i, j, r, c)) return paiGowObject;
    return null;
};

PaiGowObject.sizeForPaiGow = function () {
    var ghostSprite = cc.Sprite.create();
    ghostSprite.initWithSpriteFrameName("back.png");
    return ghostSprite.getContentSize();
};

PaiGowObject.widthForPaiGow = function () {
    var size = PaiGowObject.sizeForPaiGow();
    return size.width;
};

PaiGowObject.heightForPaiGow = function () {
    var size = PaiGowObject.sizeForPaiGow();
    return size.height;
};

PaiGowObject.heightForRow = function (rowNum) {
    return (rowNum == 0) ? 90 : 90 + (6 - rowNum) * (cc.Director.getInstance().getWinSize().height - 100) / 6;
}






