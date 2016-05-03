var CFSModePaiGowManager = function () {
    this.paiGowObjectDictionary = new Array();
    this.remainRows = 5;
    this.currentRow = 1;
    this.lastHintPaiGowRow = 0;
    this.rowStateArray = new Array(7);
    this.tableLayer = null;
    this.delegate = null;
    this.highlightLayer = cc.LayerColor.create(cc.c4(22, 144, 227, 100), 320, PaiGowObject.heightForPaiGow());
    this.highlightLayer.setVisible(false);
    this.winSize = cc.Director.getInstance().getWinSize();
    this.initAllPowGowObjects = function () {
        cc.SpriteFrameCache.getInstance().addSpriteFrames("paigow.plist", "paigow.png");
        var paiGowArray = new Array();
        var paiGowObject = new Array(21);
        var index = 0;
        for (var i = 1; i < 7; i++) {
            this.rowStateArray[i] = false;
            for (var j = i; j < 7; j++) {
                paiGowObject[index] = PaiGowObject.createPaiGowObject(i, j, 1, 1);
                paiGowArray.push(paiGowObject[index]);
                if ((i == 1 && j != 2 && j != 4) ||
                    (i == 2 && j != 3 && j != 4 && j != 5 && j != 6) ||
                    (i == 3 && j != 4 && j != 5 && j != 6) ||
                    (i == 4 && j != 5) ||
                    (i == 5) ||
                    (i == 6)) {
                    var paiGowObject_Pair = PaiGowObject.createPaiGowObject(i, j, 1, 1);
                    paiGowArray.push(paiGowObject_Pair);
                }
                index++;
            }
        }
		this.randomAllPaiGowPosition(paiGowArray);
    };
    this.randomAllPaiGowPosition = function (paiGowArray) {
	    var rowNum = -1;
        var colNumCount = newFilledArray(6, 0);
        var rowColCount = newFilledArray(6, 0);
	    var paiGowRowArray = new Array(6);
        for (var i = 0; i < paiGowRowArray.length; i++) {
            paiGowRowArray[i] = new Array();
        }
		for (i = 0; i < paiGowArray.length; i++) {
			var paiGowObject = paiGowArray[i];
			do {
				rowNum = parseInt(cc.RANDOM_0_1() * 6);
			} while (((rowColCount[rowNum] + 1 > 5) && rowNum > 0) ||
					 ((rowColCount[rowNum] + 1 > 7) && rowNum == 0));
			rowColCount[rowNum]++;
	        paiGowObject.updateRowAndColumn(rowNum, ++colNumCount[rowNum]);
	        paiGowObject.movePaiGowAnimation((rowNum == 0 ? 7 : 5), 0.0, 0.0);
	        paiGowRowArray[rowNum].push(paiGowObject);
		}
		for (i = 0; i < 6; i++) {
		    this.paiGowObjectDictionary["Row-{0}".format(i)] = paiGowRowArray[i];
		}
	};
    this.putAllPaiGowsOnTable = function () {
		for (var i = 0; i < Object.size(this.paiGowObjectDictionary); i++) {
			var paiGowArray = this.paiGowObjectArrayForRow(i);
			for (var j = 0; j < paiGowArray.length; j++) {	
				var paiGowObject = paiGowArray[j];
				this.tableLayer.addChild(paiGowObject.pg_sprite, 1);
			}
		}
		this.tableLayer.addChild(this.highlightLayer, 999);
	};
    this.turnAroundAllPaiGowRowsFinishedSelector = function () {
        if (this.delegate) this.delegate.turnAroundAllPaiGowRowsFinished();
    };
    this.turnAroundPaiGowForRow= function (rowNum) {
        var paiGowRowArray = this.paiGowObjectArrayForRow(rowNum);
        var waitTimeVal = 0.0;
        for (var i = 0; i < paiGowRowArray.length; i++) {
            var paiGowObject = paiGowRowArray[i];
            (function(paiGowObject){setTimeout(function(){paiGowObject.turnAroundAnimation();}, waitTimeVal * 1000);})(paiGowObject);
            waitTimeVal += 0.1;
        }
    };
    this.turnAroundAllPaiGowRowsWithInterval = function (interval) {
	    var waitTimeVal = 1;
        var that = this;
		for (var rowNum = 1; rowNum <= 5; rowNum++) {
            (function(row){setTimeout(function(){that.turnAroundPaiGowForRow(row);}, waitTimeVal * 1000);})(rowNum);
           	waitTimeVal += interval;
		}
        setTimeout(function(){that.turnAroundPaiGowForRow(0);}, waitTimeVal * 1000);
	    waitTimeVal += interval;
		setTimeout(function(){that.turnAroundAllPaiGowRowsFinishedSelector();}, waitTimeVal * 1000);
	};
    this.highlightCurrentRow = function () {
		this.highlightLayer.setVisible(true);
		this.highlightLayer.setPosition(cc.p(0, 90 + (6 - this.currentRow) * (this.winSize.height - 100) / 6 - PaiGowObject.heightForPaiGow() / 2));
    };
    this.dealPaiGow = function () {
		var paiGowBaseRowArray = this.paiGowObjectArrayForRow(0);
		if (paiGowBaseRowArray.length == 0) return;
		this.cancelAllSelectedPaiGow();
		if (paiGowBaseRowArray.length < this.remainRows) {
			if (this.delegate) this.delegate.showPlacePaiGowArrows();
			return;
		}
		var rowsToDeal = this.remainRows;
		var waitTimeVal = 0.0;
		for (var i = 4; i >= 0; i--) {
			if (this.rowStateArray[i + 1]) continue;
			// Take one paitow to deal
			var paiGowToDealIndex = paiGowBaseRowArray.length - rowsToDeal;
			var paiGowRowArray = this.paiGowObjectArrayForRow(i + 1);
			var paiGowObject = paiGowBaseRowArray[paiGowToDealIndex];
			paiGowObject.updateRowAndColumn(i + 1, paiGowRowArray.length + 1);
			// Update dic
			paiGowRowArray.push(paiGowObject);
			paiGowBaseRowArray.removeAt(paiGowToDealIndex);
			this.updateColumnForRow(0);
			//reset Position
			this.updatePaiGowPosition(0, waitTimeVal);
			this.updatePaiGowPosition(i + 1, waitTimeVal);
			waitTimeVal += 1.0;
			rowsToDeal--;
		}
        var that = this;
        setTimeout(function(){that.paiGowDealFinishedSelector();}, waitTimeVal * 1000);
    };
    this.paiGowDealFinishedSelector = function () {
	    if (this.delegate) this.delegate.paiGowDealFinished();
		this.currentRow = this.currentFirstRow();
		this.highlightCurrentRow();
	};
    this.moveToNextRow = function () {
		this.cancelAllSelectedPaiGow();
	    if (this.currentRow == 5 && !this.rowStateArray[5]) return;
	    if (this.currentRow == 5 && this.rowStateArray[5]) {
	        this.currentRow = 999;
	        this.highlightCurrentRow();
	        return;
	    }
	    for (var i = this.currentRow + 1; i <= 5; i ++) {
	        if (!this.rowStateArray[i]) {
	            this.currentRow = i;
	            this.highlightCurrentRow();
	            break;
	        }
	    }
	};
    this.placePaiGow = function (rowNum) {
		var paiGowBaseRowArray = this.paiGowObjectArrayForRow(0);
		var paiGowRowArray = this.paiGowObjectArrayForRow(rowNum);
        if (this.remainRowAbove(rowNum) < paiGowBaseRowArray.length) return false;
		var paiGowObject = paiGowBaseRowArray[0];
		paiGowObject.updateRowAndColumn(rowNum, paiGowRowArray.length + 1);
		paiGowRowArray.push(paiGowObject);
		paiGowBaseRowArray.removeAt(0);
		this.updateColumnForRow(0);
		this.updatePaiGowPosition(0, 0.0);
		this.updatePaiGowPosition(rowNum, 0.0);
		this.currentRow = this.currentFirstRow();
		this.highlightCurrentRow();
		if (paiGowBaseRowArray.length == 0) {
            this.delegate.placePaiGowFinished();
            this.updateLastHintPaiGowRow();
        }
        return true;
	};
    this.getPaiGowObjectsForRule = function () {
		var paiGowRowArray = this.paiGowObjectArrayForCurrentRow();
		if (paiGowRowArray.length < 3) return RULETYPE_NONE;
		var paiGowBaseRowArray = this.paiGowObjectArrayForRow(0);
		var paiGowSelectedArray = new Array();
		for (var i = 0; i < paiGowRowArray.length; i++) {
            var paiGowObject = paiGowRowArray[i];
			if (paiGowRowArray[i].pg_isSelected) paiGowSelectedArray.push(paiGowObject);
		}
	    // check if the selected cards are on from sides of the current stage
	    if (!this.checkSelectedPaiGowObjects(paiGowSelectedArray)) return RULETYPE_NONE;
		//Rule Judge
		var rs = CFSModeRuleManager.getPaiGowRuleStyle(paiGowSelectedArray);
		if (rs != RULETYPE_NONE) {
			for (i = paiGowRowArray.length - 1; i >= 0 ; i--) {
                paiGowObject = paiGowRowArray[i];
				if (paiGowObject.pg_isSelected) {
					paiGowRowArray.remove(paiGowObject);
                    paiGowObject.pg_rowNum = 0;
					paiGowBaseRowArray.insertAt(0, paiGowObject);
				}
			}
			this.updateColumnForRow(this.currentRow);
			this.updateColumnForRow(0);
			this.cancelAllSelectedPaiGow();
			this.updatePaiGowPosition(this.currentRow, 0.0);
			this.updatePaiGowPosition(0, 0.1);
		}
		return rs;
	};
	this.checkSelectedPaiGowObjects = function (selectedArray) {
		var paiGowRowArray = this.paiGowObjectArrayForCurrentRow();
	    var totalCount = paiGowRowArray.length;
	    var paiGowObjectFirst = selectedArray[0];
	    var paiGowObjectSecond = selectedArray[1];
	    var paiGowObjectThird = selectedArray[2];
	    if (paiGowObjectFirst.pg_colNum == 1 &&
	        paiGowObjectSecond.pg_colNum == 2 &&
	        paiGowObjectThird.pg_colNum == 3) return true;
	    
	    if (paiGowObjectFirst.pg_colNum == totalCount - 2 &&
	        paiGowObjectSecond.pg_colNum == totalCount - 1 &&
	        paiGowObjectThird.pg_colNum == totalCount) return true;
	    
	    if (paiGowObjectFirst.pg_colNum == 1 &&
	        paiGowObjectSecond.pg_colNum == totalCount - 1 &&
	        paiGowObjectThird.pg_colNum == totalCount) return true;
	    
	    if (paiGowObjectFirst.pg_colNum == 1 &&
	        paiGowObjectSecond.pg_colNum == 2 &&
	        paiGowObjectThird.pg_colNum == totalCount) return true;
	    
	    return false;
	};
    this.showHintPaiGow = function () {
        this.cancelAllSelectedPaiGow();
        for (var rowNum = this.currentRow; rowNum <= 5; rowNum++) {
            if (this.isRowCleared(rowNum)) continue;
            var hintPaiGowArray = this.hintPaiGowForRow(rowNum);
            if (hintPaiGowArray && hintPaiGowArray.length > 0) {
                for (var i = 0; i < hintPaiGowArray.length; i++) {    
                    var paiGowObject = hintPaiGowArray[i];
                    paiGowObject.pg_isSelected = true;
                    paiGowObject.selectedAnimation();
                }
                return true
            }
        }
        return false;
	};
    this.updatePaiGowPosition = function (rowNum, timeVal) {
	    var paiGowRowArray = this.paiGowObjectArrayForRow(rowNum);	
	    // no paigows left
		if (paiGowRowArray.length == 0 && rowNum !=0) {
			this.rowStateArray[rowNum] = true;
			this.remainRows--;
	        this.moveToNextRow();
	        if (this.delegate) this.delegate.removeBubForRow(rowNum);
	        if (this.delegate) this.delegate.rowCleared(rowNum);
			return;
		}
		// less then 8 paigows left
		if (paiGowRowArray.length < 8) {
			for (var i = 0; i < paiGowRowArray.length; i++) {
				var paiGowObject = paiGowRowArray[i];
	            paiGowObject.pg_sprite.setVisible(true);
				paiGowObject.movePaiGowAnimation(paiGowRowArray.length, timeVal, 0.5);
			}
	        if (this.delegate) this.delegate.removeBubForRow(rowNum);
			return;
		}
		// too many paigows left, only show 6
		var toHide = paiGowRowArray.length - 6;
		for (i = 0; i < 3; i++) {
            paiGowObject = paiGowRowArray[i];
            paiGowObject.pg_sprite.setVisible(true);
            paiGowObject.movePaiGowAnimation(paiGowRowArray.length, timeVal, 0.5);
		}
		for (i = paiGowRowArray.length - 3; i < paiGowRowArray.length; i++) {
            paiGowObject = paiGowRowArray[i];
            paiGowObject.pg_sprite.setVisible(true);
            paiGowObject.movePaiGowAnimation(paiGowRowArray.length, timeVal, 0.5);
		}
		for (i = 3; i < paiGowRowArray.length - 3; i++) {
            paiGowRowArray[i].pg_sprite.setVisible(false);
		}
		var bubPosition = cc.p(this.winSize.width / 2, paiGowRowArray[0].pg_position.y);
		if (this.delegate) this.delegate.createBubForRow(rowNum, toHide, bubPosition);
	};
    this.updateLastHintPaiGowRow = function () {
        this.lastHintPaiGowRow = 0;
        for (var rowNum = 5; rowNum >= 1; rowNum--) {
            var paiGowRowArray = this.hintPaiGowForRow(rowNum);
            if (!paiGowRowArray || paiGowRowArray.length == 0) continue;
            this.lastHintPaiGowRow = rowNum;
            break;
        }
    };
    this.isAnyPairAvialble = function () {
        if (this.paiGowCountForRow(0) == 0 && this.lastHintPaiGowRow < this.currentRow) return false;
        return true;
    };
    this.hintPaiGowForRow = function (rowNum) {
        var hintPaiGowArray = new Array();
        var paiGowRowArray = this.paiGowObjectArrayForRow(rowNum);
        if (paiGowRowArray.length >= 3) hintPaiGowArray = CFSModeRuleManager.getHintPaiGowObjects(paiGowRowArray);
        return hintPaiGowArray;
    };
    this.updateColumnForRow = function (rowNum) {
		var paiGowRowArray = this.paiGowObjectArrayForRow(rowNum);	
		for (var i = 0; i < paiGowRowArray.length; i++) {
			var paiGowObject = paiGowRowArray[i];
			paiGowObject.updateRowAndColumn(paiGowObject.pg_rowNum, i + 1);
		}
	};
    this.cancelAllSelectedPaiGow = function () {
		for (var i = 0; i < Object.size(this.paiGowObjectDictionary); i++) {
			var paiGowArray = this.paiGowObjectArrayForRow(i);
			for (var j = 0; j < paiGowArray.length; j++) {
				var paiGowObject = paiGowArray[j];
				paiGowObject.cancelSelect();
			}
		}
	};
    this.resetAllPaiGow = function () {
		for (var i = 0; i < Object.size(this.paiGowObjectDictionary); i++) {
			var paiGowArray = this.paiGowObjectArrayForRow(i);
			for (var j = 0; j < paiGowArray.length; j++) {
				var paiGowObject = paiGowArray[j];
				paiGowObject.pg_sprite.removeFromParent(true);
			}
	        if (this.delegate) this.delegate.removeBubForRow(i);
		}
	    this.rowStateArray.clear();
	    this.highlightLayer.removeFromParent(true);
		this.paiGowObjectDictionary.clear();
		this.remainRows = 5;
		this.currentRow = 1;
		this.highlightLayer.setVisible(false);
	};
    this.paiGowObjectArrayForRow = function (row) {
        return this.paiGowObjectDictionary["Row-{0}".format(row)];
    };
    this.anyPaiGowForRow = function (row) {
	    var paiGowRowArray = this.paiGowObjectArrayForRow(row);
	    return paiGowRowArray[0];
	};
    this.paiGowObjectArrayForCurrentRow = function () {
        return this.paiGowObjectArrayForRow(this.currentRow);
    };
    this.hasPaiGowSelectedInCurrentRow= function () {
        var paiGowObjectArray = this.paiGowObjectArrayForCurrentRow();
        if (!paiGowObjectArray) return false;
        for (var i = 0; i < paiGowObjectArray.length; i++) {
            var paiGowObject = paiGowObjectArray[i];
            if (paiGowObject.pg_isSelected) return true;
        }
        return false;
    };
    this.currentFirstRow = function () {
		for (var i = 1; i < 6; i++) {
			if (!this.rowStateArray[i]) return i;
		}
		return 0;
	};
    this.remainRowAbove = function (rowNum) {
        var remainRow = 1;
        for (var i = 1; i < rowNum; i ++) {
            if (!this.isRowCleared(i)) remainRow ++;
        }
        return remainRow;
    };
    this.isRowCleared = function (rowNum) {
        return this.rowStateArray[rowNum];
    };
    this.paiGowCountForRow = function (rowNum) {
        return this.paiGowObjectArrayForRow(rowNum).length;
    };
    this.handleTouch = function (touch) {
    	if (this.currentRow < 1 || this.currentRow > 5) return;
    	var paiGowRowArray = this.paiGowObjectArrayForCurrentRow();
    	if (paiGowRowArray.length < 1) return;
    	for (var i = 0; i < paiGowRowArray.length; i++) {
            var paiGowObject = paiGowRowArray[i];
            if (paiGowObject.containsTouchLocation(touch) && paiGowObject.pg_sprite.isVisible()) {
            	paiGowObject.selected();
            	break;
            }
		}
    };
};

sharedPaiGowObjectManager = null;
CFSModePaiGowManager.getInstance = function () {
    if (sharedPaiGowObjectManager == null) {
        sharedPaiGowObjectManager = new CFSModePaiGowManager();
    }
    return sharedPaiGowObjectManager;
};


