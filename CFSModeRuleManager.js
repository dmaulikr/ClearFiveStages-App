var RULETYPE_NONE = -1;
var RULETYPE_NORMAL = 0;
var RULETYPE_LEFT_FIVE = 1;
var RULETYPE_DIVIDE = 2;
var RULETYPE_DOUBLE = 3;
var RULETYPE_LEFT_SAME = 4;
var RULETYPE_FIVE = 5;
var RULETYPE_TTS = 6;
var RULETYPE_CONTINUE = 7;

var CFSModeRuleManager = function () {};

CFSModeRuleManager.getPaiGowRuleStyle = function (paiGowArray) {
    if (paiGowArray.length != 3) {
        return RULETYPE_NONE;
    }
    var paiGowNumArray = new Array();
    for (var i = 0; i < paiGowArray.length; i++) {
        var p = paiGowArray[i];
        paiGowNumArray.push(p.pg_preNum);
        paiGowNumArray.push(p.pg_postNum);
    }
    if (CFSModeRuleManager.isRuleTypeContinue(paiGowNumArray)) {
        return RULETYPE_CONTINUE;
    }
    if (CFSModeRuleManager.isRuleTypeTTS(paiGowNumArray)) {
        return RULETYPE_TTS;
    }
    if (CFSModeRuleManager.isRuleTypeFive(paiGowNumArray)) {
        return RULETYPE_FIVE;
    }
    if (CFSModeRuleManager.isRuleTypeDouble(paiGowNumArray)) {
        return RULETYPE_DOUBLE;
    }
    if (CFSModeRuleManager.isRuleTypeDivide(paiGowNumArray)) {
        return RULETYPE_DIVIDE;
    }
    if (CFSModeRuleManager.isRuleTypeLeftSame(paiGowNumArray)) {
        return RULETYPE_LEFT_SAME;
    }
    if (CFSModeRuleManager.isRuleTypeLeftFive(paiGowNumArray)) {
        return RULETYPE_LEFT_FIVE;
    }
    if (CFSModeRuleManager.isRuleTypeNORMAL(paiGowNumArray)) {
        return RULETYPE_NORMAL;
    }
    return RULETYPE_NONE;

};

CFSModeRuleManager.getPaiGowCountInArray = function (paiGowArray, cardValue) {
    var count = 0;
    for (var i = 0; i < paiGowArray.length; i++) {
        if (paiGowArray[i] == cardValue) count++;
    }
    return count;
};

CFSModeRuleManager.cardValueInArray = function (paiGowArray, cardCount) {
    for (var i = 0; i < paiGowArray.length; i++) {
        var count = CFSModeRuleManager.getPaiGowCountInArray(paiGowArray, paiGowArray[i]);
        if (count == cardCount) return paiGowArray[i];
    }
    return 0;
};

CFSModeRuleManager.isRuleTypeTTS = function (paiGowNumArray) {
    if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 2) != 2) return false;
    if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 3) != 2) return false;
    if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 6) != 2) return false;
    return true;
};

CFSModeRuleManager.isRuleTypeDouble = function (paiGowNumArray) {
    if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 1) != 2) {
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 4) != 2) return false;
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 5) != 2) return false;
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 6) != 2) return false;
        return true;
    }
    if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 2) != 2) {
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 4) != 2) return false;
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 5) != 2) return false;
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 6) != 2) return false;
        return true;
    }
    if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 3) != 2) {
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 4) != 2) return false;
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 5) != 2) return false;
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, 6) != 2) return false;
        return true;
    }
    return true;
};

CFSModeRuleManager.isRuleTypeFive = function (paiGowNumArray) {
    for (var i = 0; i < paiGowNumArray.length; i++) {
        if (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, paiGowNumArray[i]) == 5)  return true;
    }
    return false;
};

CFSModeRuleManager.isRuleTypeContinue = function (paiGowNumArray) {
    for (var i = 1; i < 7; i++) {
        if (!paiGowNumArray.contains(i)) return false;
    }
    return true;
};

CFSModeRuleManager.isRuleTypeNORMAL = function (paiGowNumArray) {
    var cardValue = CFSModeRuleManager.cardValueInArray(paiGowNumArray, 3);
    if (cardValue == 0) return false;
    var count = 0;
    for (var i = 0; i < paiGowNumArray.length; i++) {
        if (paiGowNumArray[i] != cardValue) count += paiGowNumArray[i];
    }
    var criterionValue = (GameDataManager.gameLevel == GAMELEVEL_EASY) ? 13 : 14;
    return (count >= criterionValue) ? true : false;
};

CFSModeRuleManager.isRuleTypeLeftFive = function (paiGowNumArray) {
    var cardValue = CFSModeRuleManager.cardValueInArray(paiGowNumArray, 3);
    if (cardValue == 0) return false;
    var count = 0;
    for (var i = 0; i < paiGowNumArray.length; i++) {
        if (paiGowNumArray[i] != cardValue) count += paiGowNumArray[i];
    }
    return (count == 5) ? true : false;
};

CFSModeRuleManager.isRuleTypeLeftSame = function (paiGowNumArray) {
    var count = 0;
    var cardValue = CFSModeRuleManager.cardValueInArray(paiGowNumArray, 4);
    if (cardValue == 0) return false;
    for (var i = 0; i < paiGowNumArray.length; i++) {
        if (paiGowNumArray[i] != cardValue) count += paiGowNumArray[i];
    }
    return (count == cardValue) ? true : false;
};

CFSModeRuleManager.isRuleTypeDivide = function (paiGowNumArray) {
    var count = 0;
    var cardValue = CFSModeRuleManager.cardValueInArray(paiGowNumArray, 3);
    if (cardValue == 0) return false;
    var criterionValue = 0;
    for (var i = 0; i < paiGowNumArray.length; i++) {
        if (paiGowNumArray[i] == cardValue) continue;
        criterionValue = paiGowNumArray[i];
        break;
    }
    return (CFSModeRuleManager.getPaiGowCountInArray(paiGowNumArray, criterionValue) == 3) ? true : false;
};

CFSModeRuleManager.getRuleString = function (ruleType) {
    switch (ruleType) {
        case RULETYPE_NONE:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_NONE);
            break;
        case RULETYPE_NORMAL:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_NORMAL);
            break;
        case RULETYPE_LEFT_FIVE:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_LEFT_FIVE);
            break;
        case RULETYPE_DIVIDE:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_DIVIDE);
            break;
        case RULETYPE_DOUBLE:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_DOUBLE);
            break;
        case RULETYPE_LEFT_SAME:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_LEFT_SAME);
            break;
        case RULETYPE_FIVE:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_FIVE);
            break;
        case RULETYPE_TTS:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_TTS);
            break;
        case RULETYPE_CONTINUE:
            return MultiLanguageUtil.getLocalizatedStringForKey(STRING_PAIGOW_RULETYPE_CONTINUE);
            break;
        default:
            break;
    }
    return "UNKNOW ERROR!";
};


CFSModeRuleManager.getHintPaiGowObjects = function (paiGowArray) {
    var count = paiGowArray.length;
    if (count < 3) return null;
    // check left 3 cards
    var tempArray = new Array(paiGowArray[0], paiGowArray[1], paiGowArray[2]);
    if (this.getPaiGowRuleStyle(tempArray) != RULETYPE_NONE) return tempArray;
    // check right 3 cards
    tempArray = new Array(paiGowArray[count - 1], paiGowArray[count - 2], paiGowArray[count - 3]);
    if (this.getPaiGowRuleStyle(tempArray) != RULETYPE_NONE) return tempArray;
    // check left 2 && right 1 cards
    tempArray = new Array(paiGowArray[0], paiGowArray[1], paiGowArray[count - 1]);
    if (this.getPaiGowRuleStyle(tempArray) != RULETYPE_NONE) return tempArray;
    // check left 1 && right 2 cards
    tempArray = new Array(paiGowArray[0], paiGowArray[count - 1], paiGowArray[count - 2]);
    if (this.getPaiGowRuleStyle(tempArray) != RULETYPE_NONE) return tempArray;
    return null;
};