var FRAME_RATE = 60;
var BOUNCE_TIME = 0.2;
var	BounceDirectionStayingStill = 0;
var	BounceDirectionGoingLeft = 1;
var	BounceDirectionGoingRight = 2;

var ShowPaiGowLayer = cc.Layer.extend({
	isDragging: false,
	lasty: 0,
	xvel: 0,
	direction: BounceDirectionStayingStill,
	scrollLayer: null,
    ctor:function () {
    },
    init:function (rowNum) {
        var bRet = false;
        if (this._super()) {
			this.setTouchEnabled(true);
            this.isDragging = false;
            this.lasty = 0.0;
            this.xvel = 0.0;
            this.direction = BounceDirectionStayingStill;
            var paiGowArray = CFSModePaiGowManager.getInstance().paiGowObjectArrayForRow(rowNum);
            var tempPaiGowObject = paiGowArray[0];
            this.scrollLayer = cc.LayerColor.create(cc.c4b(22, 144, 227, 200), (paiGowArray.length + 1 ) * 38, PaiGowObject.heightForPaiGow());
            this.scrollLayer.setPosition(cc.p(0, tempPaiGowObject.pg_position.y - PaiGowObject.heightForPaiGow() / 2));
            this.addChild(this.scrollLayer, 0);

            for (var i = 0; i < paiGowArray.length; i++) {
                var paiGowObject = paiGowArray[i];
                var copySprite = new cc.Sprite();
                copySprite.initWithSpriteFrameName(paiGowObject.pg_name);
                copySprite.setPosition(cc.p(paiGowObject.pg_colNum * 38, PaiGowObject.heightForPaiGow() / 2));
                this.scrollLayer.addChild(copySprite, 2);
            }
			var closeSprite = cc.Sprite.create();
			closeSprite.initWithSpriteFrameName("close.png");
            closeSprite.setScale(0.7);
			var menuItem = cc.MenuItemSprite.create(closeSprite, null, null, this.closeLayer, this);
			var menu = cc.Menu.create(menuItem, null);
			menu.setPosition(cc.p(14, 60));
            this.scrollLayer.addChild(menu, 2);
			
			this.schedule(this.onTimerUpdate);
            bRet = true;
        }
        return bRet;
    },
    closeLayer: function (sender) {
    	this.removeFromParent(true);
    },
    onTimerUpdate: function (dt) {
		var pos = this.scrollLayer.getPosition();
		var right = pos.x + this.getBoundingBox().origin.x + this.scrollLayer.getContentSize().width;
		var left = pos.x + this.getBoundingBox().origin.x;
		var minX = this.getBoundingBox().origin.x;
		var maxX = this.getBoundingBox().origin.x + this.getBoundingBox().size.width;
		if(!this.isDragging) {
			var friction = 0.96;
			if(left > minX && this.direction != BounceDirectionGoingLeft) {
                this.xvel = 0;
                this.direction = BounceDirectionGoingLeft;
			}
			else if(right < maxX && this.direction != BounceDirectionGoingRight)	{
                this.xvel = 0;
                this.direction = BounceDirectionGoingRight;
			}
			if(this.direction == BounceDirectionGoingRight) {
				if(this.xvel >= 0) {
					var delta = (maxX - right);
                    this.xvel = (delta / (BOUNCE_TIME * FRAME_RATE));
				}
				if((right + 0.5) == maxX) {
					pos.x = right -  this.scrollLayer.getContentSize().width;
                    this.xvel = 0;
                    this.direction = BounceDirectionStayingStill;
				}
			}
			else if(this.direction == BounceDirectionGoingLeft) {
				if(this.xvel <= 0) {
					delta = (minX - left);
                    this.xvel = (delta / (BOUNCE_TIME * FRAME_RATE));
				}
				if((left + 0.5) == minX) {
					pos.x = left - this.getBoundingBox().origin.x;
                    this.xvel = 0;
                    this.direction = BounceDirectionStayingStill;
				}
			}
			else {
                this.xvel *= friction;
			}
			pos.x += this.xvel;
            this.scrollLayer.setPosition(pos);
		}
		else {
			if(left <= minX || right >= maxX) {
                this.direction = BounceDirectionStayingStill;
			} 
			if(this.direction == BounceDirectionStayingStill) {
                this.xvel = (pos.x - this.lasty)/2;
                this.lasty = pos.x;
			}
		}
    },
    onTouchesBegan:function (touches, event) {
    	var location = touches[0].getLocation();
		if (!cc.Rect.CCRectContainsPoint(this.scrollLayer.getBoundingBox(), location)) {
			return true;
		}
        this.isDragging = true;
		return true;
    },
    onTouchesMoved:function (touches, event) {
    	var location = touches[0].getLocation();
		if (!cc.Rect.CCRectContainsPoint(this.scrollLayer.getBoundingBox(), location)) {
			return true;
		}
		var preLocation = touches[0].getPreviousLocation();
        var curLocation = location;
        var nowPosition = this.scrollLayer.getPosition();
		nowPosition.x += ( curLocation.x - preLocation.x );
        this.scrollLayer.setPosition(nowPosition);
    },
    onTouchesEnded:function (touches, event) {
        this.isDragging = false;
    }
});

ShowPaiGowLayer.create = function (rowNum) {
    var sg = new ShowPaiGowLayer();
    if (sg && sg.init(rowNum)) {
        return sg;
    }
    return null;
};
