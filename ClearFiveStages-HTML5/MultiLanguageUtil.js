var STRING_GAMELEVEL_EASY = 1;
var STRING_GAMELEVEL_NORMAL = 2;
var STRING_GAMELEVEL_HARD = 3;
var STRING_CONFIRM_YES = 4;
var STRING_CANCEL_NO = 5;	
var STRING_WARNING = 6;
var STRING_MAINMENU = 7;
var STRING_GAME_HIGHSCORE = 8;
var STRING_RESUME_GAME = 9;
// main scene
var STRING_START_GAME = 10;
var STRING_ABOUT_GAME = 11;
var STRING_GAME_TUTORIAL = 12;
// highscore scene
var STRING_HIGHSCORE_RANK = 13;
var STRING_HIGHSCORE_PLAYERNAME = 14;
var STRING_HIGHSCORE_PLAYDATE = 15;
var STRING_HIGHSCORE_COSTTIME = 16;
var STRING_HIGHSCORE_ACCURACY = 17;
// alert view
var STRING_ALERT_RESTART_MESSAGE = 18;
var STRING_ALERT_DEAL_MESSAGE = 19;
var STRING_ALERT_NEXT_MESSAGE = 20;
// gameplay scene
var STRING_TIMER = 21;
var STRING_DEALCARD = 22;
var STRING_GETCARD = 23;
var STRING_NEXTROW = 24;
var STRING_RESTART_GAME = 25;
var STRING_SHOWHINT = 26;
var STRING_CLEARED = 56;
var STRING_SUBMIT_SCORE = 65;
// levelselect scene
var STRING_CHOOSE_GAMELEVEL = 27;
var STRING_CHOOSE_TABLE = 28;
var STRING_GAMELEVEL_EASY_INFO = 29;
var STRING_GAMELEVEL_NORMAL_INFO = 30;
var STRING_GAMELEVEL_HARD_INFO = 31;
// paigow ruletype
var STRING_PAIGOW_RULETYPE_NONE = 32;
var STRING_PAIGOW_RULETYPE_NORMAL = 33;
var STRING_PAIGOW_RULETYPE_LEFT_FIVE = 34;
var STRING_PAIGOW_RULETYPE_DIVIDE = 35;
var STRING_PAIGOW_RULETYPE_DOUBLE = 36;
var STRING_PAIGOW_RULETYPE_LEFT_SAME = 37;
var STRING_PAIGOW_RULETYPE_FIVE = 38;
var STRING_PAIGOW_RULETYPE_TTS = 39;
var STRING_PAIGOW_RULETYPE_CONTINUE = 40;
// prompt
var STRING_PROMPT_TITLE = 60;
var STRING_PROMPT_INFO = 61;
var STRING_IOS_ONLY = 62;
var STRING_FACEBOOK_ONLY = 63;
var STRING_SINAWEIBO_ONLY = 64;
// option layer
var STRING_OPTION_TITLE = 41;
var STRING_CHOOSE_LANGUAGE = 42;
var STRING_MUSIC = 43;
var STRING_SOUND = 44;
var STRING_PLAYERNAME = 45;
// game win layer
var STRING_GAMEWIN = 46;	
var STRING_GAMELEVEL = 47;
var STRING_RANK_OUT = 59;
// game lose layer
var STRING_GAMELOSE = 48;
var STRING_GAMELOSE_INFO = 49;
var STRING_SHARE_SCORE = 66;
// social
var STRING_TWITTER_CONTENT = 57;
var STRING_FACEBOOK_CONTENT = 58;
// help scene
var STRING_TUTORIAL_TITLE_PAGE_0 = 1000;
var STRING_TUTORIAL_TITLE_PAGE_1 = 1001;
var STRING_TUTORIAL_TITLE_PAGE_2 = 1002;
var STRING_TUTORIAL_TITLE_PAGE_3 = 1003;
var STRING_TUTORIAL_TITLE_PAGE_4 = 1004;
var STRING_TUTORIAL_TITLE_PAGE_5 = 1005;
var STRING_TUTORIAL_TITLE_PAGE_6 = 1006;
var STRING_TUTORIAL_TITLE_PAGE_7 = 1007;
var STRING_TUTORIAL_TITLE_PAGE_8 = 1008;
var STRING_TUTORIAL_TITLE_PAGE_9 = 1009;
var STRING_TUTORIAL_TITLE_PAGE_10 = 1010;
var STRING_TUTORIAL_TITLE_PAGE_11 = 1011;
var STRING_TUTORIAL_TITLE_PAGE_12 = 1012;
var STRING_TUTORIAL_TITLE_PAGE_13 = 1013;
var STRING_TUTORIAL_TITLE_PAGE_14 = 1014;
var STRING_TUTORIAL_TITLE_PAGE_15 = 1015;

var STRING_TUTORIAL_SUBTITLE_PAGE_0 = 2000;
var STRING_TUTORIAL_SUBTITLE_PAGE_1 = 2001;
var STRING_TUTORIAL_SUBTITLE_PAGE_2 = 2002;
var STRING_TUTORIAL_SUBTITLE_PAGE_3 = 2003;
var STRING_TUTORIAL_SUBTITLE_PAGE_4 = 2004;
var STRING_TUTORIAL_SUBTITLE_PAGE_5 = 2005;
var STRING_TUTORIAL_SUBTITLE_PAGE_6 = 2006;
var STRING_TUTORIAL_SUBTITLE_PAGE_7 = 2007;
var STRING_TUTORIAL_SUBTITLE_PAGE_8 = 2008;
var STRING_TUTORIAL_SUBTITLE_PAGE_9 = 2009;
var STRING_TUTORIAL_SUBTITLE_PAGE_10 = 2010;
var STRING_TUTORIAL_SUBTITLE_PAGE_11 = 2011;
var STRING_TUTORIAL_SUBTITLE_PAGE_12 = 2012;
var STRING_TUTORIAL_SUBTITLE_PAGE_13 = 2013;
var STRING_TUTORIAL_SUBTITLE_PAGE_14 = 2014;
var STRING_TUTORIAL_SUBTITLE_PAGE_15 = 2015;

var STRING_TUTORIAL_INFO_PAGE_0 = 3000;
var STRING_TUTORIAL_INFO_PAGE_1 = 3001;
var STRING_TUTORIAL_INFO_PAGE_2 = 3002;
var STRING_TUTORIAL_INFO_PAGE_3 = 3003;
var STRING_TUTORIAL_INFO_PAGE_4 = 3004;
var STRING_TUTORIAL_INFO_PAGE_5 = 3005;
var STRING_TUTORIAL_INFO_PAGE_6 = 3006;
var STRING_TUTORIAL_INFO_PAGE_7 = 3007;
var STRING_TUTORIAL_INFO_PAGE_8 = 3008;
var STRING_TUTORIAL_INFO_PAGE_9 = 3009;
var STRING_TUTORIAL_INFO_PAGE_10 = 3010;
var STRING_TUTORIAL_INFO_PAGE_11 = 3011;
var STRING_TUTORIAL_INFO_PAGE_12 = 3012;
var STRING_TUTORIAL_INFO_PAGE_13 = 3013;
var STRING_TUTORIAL_INFO_PAGE_14 = 3014;
var STRING_TUTORIAL_INFO_PAGE_15 = 3015;

var MultiLanguageUtil = function () {};

MultiLanguageUtil.getI18NResourceNameFrom = function (resourceName) {
    var resourcePureName = resourceName.split(".")[0];
    var resourceExtensionName = resourceName.split(".")[1];
    var currentLanguageType = GameDataManager.languageType;
    if (currentLanguageType == LANGUAGE_CHINESE) return "{0}{1}.{2}".format(resourcePureName, "-zh", resourceExtensionName);
    if (currentLanguageType == LANGUAGE_JAPANESE) return "{0}{1}.{2}".format(resourcePureName, "-ja", resourceExtensionName);
    return "{0}{1}.{2}".format(resourcePureName, "-en", resourceExtensionName);    
};

MultiLanguageUtil.getTimeStringFromSecond = function (sec) {
    var currentLanguage = GameDataManager.languageType;
	var h = parseInt(sec / 3600);
	var m = parseInt((sec - 3600 * h) / 60);
	var s = parseInt(sec - m * 60 - h * 3600);
	if (sec > 3599) {
		if (currentLanguage == LANGUAGE_CHINESE) return "{0}时:{1}分:{2}秒".format(h, m, s);
		if (currentLanguage == LANGUAGE_JAPANESE) return "{0}時:{1}分:{2}秒".format(h, m, s);
		return "{0}H:{1}M:{2}S".format(h, m, s);
	}
	if (sec < 3600 && sec > 59) {
		if (currentLanguage == LANGUAGE_CHINESE) return "{0}分:{1}秒".format(m, s);
		if (currentLanguage == LANGUAGE_JAPANESE) return "{0}分:{1}秒".format(m, s);
		return "{0}M:{1}S".format(m, s);
	}
	if (currentLanguage == LANGUAGE_CHINESE) return "{0}秒".format(s);
	if (currentLanguage == LANGUAGE_JAPANESE) return "{0}秒".format(s);
	return "{0}S".format(s);
};

MultiLanguageUtil.getLocalizatedStringForKey = function (key) {
	var currentLanguageType = GameDataManager.languageType;
	var currentGameLevel = GameDataManager.gameLevel;
	// common
	if (key == STRING_CONFIRM_YES) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "是";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "はい ";
	    return "YES";
	}
	if (key == STRING_CANCEL_NO) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "否";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "いいえ";
	    return "NO";
	}
	if (key == STRING_GAMELEVEL_EASY) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "简单";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "簡単";
	    return "Easy";
	}
	if (key == STRING_GAMELEVEL_NORMAL) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "普通";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "普通";
	    return "Normal";
	}
	if (key == STRING_GAMELEVEL_HARD) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "困难";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "困難";
	    return "Hard";
	}    
	if (key == STRING_WARNING) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "警告!";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "注意!";
	    return "Warning";
	}
	if (key == STRING_RESTART_GAME) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "新游戏";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "再挑戦";
	    return "Retry";
	}
	// main scene
	if (key == STRING_START_GAME) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "开始游戏";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "ゲーム開始";
	    return "Game Start";
	}
	if (key == STRING_GAME_HIGHSCORE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "高分榜";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "成績一覧";
	    return "HighScore";
	}
	if (key == STRING_ABOUT_GAME) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "关于游戏";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "ゲームについて";
	    return "About Game";
	}
	if (key == STRING_GAME_TUTORIAL) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "游戏帮助";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "チュートリアル";
	    return "Tutorial";
	}
	// highscore scene
	if (key == STRING_HIGHSCORE_RANK) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "名 次";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "順 位";
	    return "Rank";
	}
	if (key == STRING_HIGHSCORE_PLAYERNAME) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "姓 名";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "名 前";
	    return "Name";
	}
	if (key == STRING_HIGHSCORE_PLAYDATE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "日 期";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "日 付";
	    return "Date";
	}
	if (key == STRING_HIGHSCORE_COSTTIME) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "耗 时";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "時 間";
	    return "Time";
	}
	if (key == STRING_HIGHSCORE_ACCURACY) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "正 确 率";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "正 確 率";
	    return "Accuracy";
	}
	// alert view
	if (key == STRING_ALERT_RESTART_MESSAGE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "您想要重新开始新游戏吗?";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "ゲームを再開するの？";
	    return "Are your really going to start a new game?";
	}
	if (key == STRING_ALERT_DEAL_MESSAGE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "还有被选中的牌没有处理，是否要发牌?";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "選択された牌があります、それを無視して配牌しますか？";
	    return "You still have selected Paigows, deal cards anyway?";
	}
	if (key == STRING_ALERT_NEXT_MESSAGE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "本关中还有被选中的牌，是否要去到下一关?";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "本間まだ選択された牌があります、それを無視して次間に移動しますか?";
	    return "You still have selected Paigow in this stage, continue anyway?";
	}
	// gameplay scene
	if (key == STRING_TIMER) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "时间";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "時間";
	    return "Time";
	}
	if (key == STRING_DEALCARD) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "发牌";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "配牌";
	    return "Deal";
	}
	if (key == STRING_GETCARD) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "取牌";
	    return "Get";
	}
	if (key == STRING_NEXTROW) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "下一关";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "次行";
	    return "Next";
	}
	if (key == STRING_SHOWHINT) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "提示";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "ヒント";
	    return "Hint";
	}
	if (key == STRING_CLEARED) {
        if (currentLanguageType == LANGUAGE_CHINESE) return "已通关";
        if (currentLanguageType == LANGUAGE_JAPANESE) return "クリアー";
        return "Cleared";
    }
    if (key == STRING_SUBMIT_SCORE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return "最高分上传中";
        if (currentLanguageType == LANGUAGE_JAPANESE) return "成績アップロード中";
        return "Submitting high score";
    }
	// levelSelect scene
	if (key == STRING_CHOOSE_GAMELEVEL) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "选 择 等 度";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "難しさ選ぶ";
	    return "Choose Level";
	}
	if (key == STRING_GAMELEVEL_EASY_INFO) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "有提示，基本点数和为13";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "提示あり，基本点数要求13";
	    return "With hint, 13-point mode";
	}
	if (key == STRING_GAMELEVEL_NORMAL_INFO) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "有提示，基本点数和为14";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "提示あり，基本点数要求14";
	    return "No hint, 13-point mode";
	}
	if (key == STRING_GAMELEVEL_HARD_INFO) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "无提示，基本点数和为14";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "提示なし，基本点数要求14";
	    return "No hint, 14-point mode";
	}
	if (key == STRING_CHOOSE_TABLE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "选择桌面背景";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "テーブル選ぶ";
	    return "Choose table";
	}
	// paigow ruletype
	if (key == STRING_PAIGOW_RULETYPE_NONE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "不对哦!";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "テおっと!";
	    return "Ooops!";
	}
	if (key == STRING_PAIGOW_RULETYPE_NORMAL) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return (currentGameLevel == GAMELEVEL_HARD) ? "14点+" : "13点+";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return (currentGameLevel == GAMELEVEL_HARD) ? "43点+" : "13点+";
	    return (currentGameLevel == GAMELEVEL_HARD) ? "14-Point+" : "13-Point+";
	}
	if (key == STRING_PAIGOW_RULETYPE_LEFT_FIVE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "五元宝";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "合-5点モード";
	    return "Co-Five-Points";
	}
	if (key == STRING_PAIGOW_RULETYPE_DIVIDE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "分厢";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "分点モード";
	    return "Divide-Points";
	}
	if (key == STRING_PAIGOW_RULETYPE_DOUBLE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "双123，456";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "双点モード";
	    return "Double-Points";
	}
	if (key == STRING_PAIGOW_RULETYPE_LEFT_SAME) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "割牌";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "合点モード";
	    return "Co-Points";
	}
	if (key == STRING_PAIGOW_RULETYPE_FIVE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "五子登科";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "五同点モード";
	    return "Five-of-A-Kind";
	}   
	if (key == STRING_PAIGOW_RULETYPE_TTS) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "二三靠六";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "2-3-6モード";
	    return "2-3-6-Points";
	}  
	if (key == STRING_PAIGOW_RULETYPE_CONTINUE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "1-2-3-4-5-6";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "ストレートモード";
	    return "Straight-Points";
	}
	// pause layer
	if (key == STRING_RESUME_GAME) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "继续游戏";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "ゲーム再開";
	    return "Resume Game";
	}
	if (key == STRING_MAINMENU) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "主菜单";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "メインメニュー";
	    return "Main Menu";
	}
	// option layer
	if (key == STRING_OPTION_TITLE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "设置";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "设置";
	    return "Option";
	}
	if (key == STRING_CHOOSE_LANGUAGE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "语言";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "言語";
	    return "Language";
	}
	if (key == STRING_MUSIC) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "音乐";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "音楽";
	    return "Music";
	}
	if (key == STRING_SOUND) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "音效";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "サウンド";
	    return "Sound";
	}
	if (key == STRING_PLAYERNAME) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "玩家";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "名前";
	    return "Player Name";
	}
	// prompt
	if (key == STRING_PROMPT_TITLE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "通关成功 !!!";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "おめでとう!!!";
	    return "Congratulations!!!";
	}
	if (key == STRING_PROMPT_INFO) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "你的名字";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "お名前";
	    return "Your Name";
	}
	if (key == STRING_IOS_ONLY) {
		if (currentLanguageType == LANGUAGE_CHINESE) return "该功能仅在iphone版中提供";
		if (currentLanguageType == LANGUAGE_JAPANESE) return "iphone版のみ対応";
		return "iphone version only";
	}
	if (key == STRING_FACEBOOK_ONLY) {
		if (currentLanguageType == LANGUAGE_CHINESE) return "该功能仅在Facebook版中提供";
		if (currentLanguageType == LANGUAGE_JAPANESE) return "Facebook版のみ対応";
		return "Facebook version only";
	}
	if (key == STRING_SINAWEIBO_ONLY) {
		if (currentLanguageType == LANGUAGE_CHINESE) return "该功能仅在新浪微博版中提供";
		if (currentLanguageType == LANGUAGE_JAPANESE) return "Sina Weibo版のみ対応";
		return "Sina Weibo version only";
	}	
	// game win layer
	if (key == STRING_GAMEWIN) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "恭喜通关成功 !!!";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "クリア成功おめでとう!!!";
	    return "Congratulations!!!";
	}
	if (key == STRING_GAMELEVEL) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "难度";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "レベル";
	    return "Level";
	}
    if (key == STRING_SHARE_SCORE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return "分享:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return "シェアー:";
        return "Share:";
    }
    if (key == STRING_RANK_OUT) {
		if (currentLanguageType == LANGUAGE_CHINESE) return "未入榜";
		if (currentLanguageType == LANGUAGE_JAPANESE) return "ランクイン外";
		return "Out of Rank";
	}
	// game lose layer
	if (key == STRING_GAMELOSE) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "游戏结束 !!!";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "ゲームオーバー!!!";
	    return "Game Over!!!";
	}
	if (key == STRING_GAMELOSE_INFO) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "祝你下次好运 ^_^";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "今度クリアできるよう^_^";
	    return "Better luck next time :)";
	}
	// social
    if (key == STRING_TWITTER_CONTENT) {
        if (currentLanguageType == LANGUAGE_CHINESE) return "一起来玩通五关吧，我已经顺利通关成功:)\n\nApp下载地址：http://itunes.apple.com/us/app/clear-5-stages/id432737724";
		if (currentLanguageType == LANGUAGE_JAPANESE) return "一緒に通五関をしよ　〜　私はただいま全関をクリアーしました^_^\n\nリンク先：http://itunes.apple.com/us/app/clear-5-stages/id432737724";
		return "I just cleared all the stages in this chinese tanditional card game -- \'Clear-Five-Stages\'. Come and give it a shot :)\n\nApp link: http://itunes.apple.com/us/app/clear-5-stages/id432737724";
    }
    if (key == STRING_FACEBOOK_CONTENT) {
        if (currentLanguageType == LANGUAGE_CHINESE) return "一起来玩通五关吧，我已经顺利通关成功:)\n\nApp下载地址：http://itunes.apple.com/us/app/clear-5-stages/id432737724";
		if (currentLanguageType == LANGUAGE_JAPANESE) return "一緒に通五関をしよ　〜　私はただいま全関をクリアーしました^_^\n\nリンク先：http://itunes.apple.com/us/app/clear-5-stages/id432737724";
		return "I just cleared all the stages in this chinese tanditional card game -- \'Clear-Five-Stages\'. Come and give it a shot :)\n\nApp link: http://itunes.apple.com/us/app/clear-5-stages/id432737724";
    }
	// help scene
	// page 1
	if  (key == STRING_TUTORIAL_TITLE_PAGE_1) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "牌九简介";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "牌九について";
	    return "About PaiGow";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_1) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "";
	    return "";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_1) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n牌类娱乐用品。又称骨牌。牌九每副为32张，" +
	        		"\n用骨头、象牙、竹子或乌木制成每张呈长方体，" +
	        		"\n正面分别刻着以不同方式排列的由2到12的点子。" +
	        		"\n\n牌九起源于中国，在民间流传较广，属于娱乐" +
	        		"\n用具。牌九一般4个人玩，玩法多种变化也较多。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\nPAIGOWはパイガオポーカーで言及した牌九とい" +
	        		"\nう中国のドミノ牌を使用するゲームで、西部開拓" +
	        		"\n時代にアメリカで普及したゲームである。" +
	        		"\n\n19世紀半ばには早くもカジノゲームなり20世紀" +
	        		"\n初頭まで遊ばれたが1930年代には消滅し、1960" +
	        		"\n年代になってまた遊ばれるようになって現在にい" +
	        		"\nたっている。";
	    return "\n\n\nPaigow(牌九) is a Chinese gambling game played with a set of Chinese dominoes." +
	    		"\n\nPai gow is played in unsanctioned casinos in most Chinese communities." +
	    		"\n\nIt is played openly in major casinos in China. It dates back to at least the Song Dynasty, and is a game steeped in tradition.";
	}
	// page 2
	if  (key == STRING_TUTORIAL_TITLE_PAGE_2) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "游戏界面按钮的作用";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "それぞれのボタンの役割";
	    return "Usage of buttons";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_2) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "";
	    return "";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_2) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n发牌: 用来进行发牌的操作" +
	        	    "\n\n下一关: 用来在关与关之间进行移动(从上至下)" +
	        		"\n\n取牌: 对选取的牌进行取牌操作" +
	        		"\n\n新游戏: 放弃当前的游戏，开始新游戏" +
	        		"\n\n提示: 用来提示当前关的可取牌的组合";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n配牌: 配牌する操作を行う" +
	        		"\n\n次行: 次の関に移動する(上から下まで)" +
	        		"\n取牌: ある規則に満たせた牌を取牌する" +
	        		"\n新规: 新しゲームを開始する" +
	        		"\n提示: 本関にて規則を満たせる牌をヒントする";
	    return "\n\n\nDeal: Used to deal the cards to each stages" +
	    		"\n\nNext: Used to move to next stage" +
	    		"\nGet: Used to take the cards which match the certain rule" +
	    		"\nNew: Used to start a new game" +
	    		"\nHint: Used to show the hint of taking cards";
	}
	// page 3
	if  (key == STRING_TUTORIAL_TITLE_PAGE_3) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "如何选牌";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "牌の選び方";
	    return "How to select cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_3) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "";
	    return "";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_3) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
            return "\n\n\n永远只能从每一关的最边缘开始选牌，并且" +
            		"\n只能连续选牌，不能跳开了选。" +
            		"\n\n只需要触摸想要的牌就可以完成选牌的操作。" +
            		"\n\n再次触摸已经被选中的牌就可以取消选中。" +
            		"\n\n蓝色的区域表明当前正在进行“选牌取牌”的关卡。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
            return "\n\n\n牌を取る時両端から取る及び連続取ることが決り" +
            		"\nです。指先で欲しいの牌をタッチするより牌を選" +
            		"\nぶことができる。" +
            		"\n\n既に選択された牌をもう一回タッチするより選" +
            		"\n択された状態から外すことができる。" +
            		"\n\n青い部分は今 ”配牌・取牌” されている関を示" +
            		"\nしている。";
        return "\n\n\nYou can only take the cards from side of a stage and keep taking continuously." +
        		"\nSimply touch the cards that you think match certain rule." +
        		"\n\nTouch the selected card again to unselect it." +
        		"\n\nThe blue part indicates the current stage which is being processed.";
	}
	// page 4
	if  (key == STRING_TUTORIAL_TITLE_PAGE_4) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "如何查看被隐藏的牌";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "隠された牌を見る方法";
	    return "Check invisible cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_4) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "";
	    return "";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_4) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n如果某一关的牌数太多(超出了屏幕的显示范围)，" +
	        		"\n中间的部分就会变成小气泡，气泡中央的数字表" +
	        		"\n示有多少张牌被隐藏了。" +
	        		"\n\n触摸小气泡就可以看到被隐藏的牌。当被隐藏的牌" +
	        		"\n数较多时，可以左右滑动牌来查看所有的牌。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\nある関で牌数が一定な数に超えたら、小さいバブ" +
	        		"\nルになります。そのバブルにて書かれている数字" +
	        		"\nは隠された牌数を示している。" +
	        		"\n\nバブルをタッチするより隠された牌を見ることが" +
	        		"\nできる。大量な牌数がある場合は、牌を指でスク" +
	        		"\nロールして見ることができる。";
	    return "\n\nWhen there’re too many cards in a single stage, the middle part becomes little bubble." +
	    		"\n\nThe number in the bubble indicates how many cards are in it." +
	    		"\n\nTouch the bubble to check the invisible cards and scroll the cards with your finger easily when you have too many cards in a stage.";
	}
	// page 5
	if  (key == STRING_TUTORIAL_TITLE_PAGE_5) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "使用帮助箭头进行添牌";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "矢印より配牌する方法";
	    return "Dealing cards with arrow";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_5) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "";
	    return "";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_5) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n当剩余的牌数不够进行添牌的操作时，右侧就" +
	        		"\n会出现一排小箭头帮助您进行添牌。" +
	        		"\n\n根据添牌的规则，点击您想要添牌的关，就" +
	        		"\n可以完 成添牌的操作。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n残り牌数が配牌に足りなくなった場合、右側に黒" +
	        		"\nい矢印がでます。" +
	        		"\n\n矢印をタッチするより対応された関に配牌するこ" +
	        		"\nとができる。";
        return "\n\n\nWhen the left cards is not enough to deal, couple of arrows will help you to place cards." +
        		"\nTouch the arrow which pointed to the stage you want to put the card on.";
	}
	// page 6
	if  (key == STRING_TUTORIAL_TITLE_PAGE_6) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌规则之一";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "牌九について";
	    return "Rule 1 of taking cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_6) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "14点:";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "14点:";
	    return "14-Points mode:";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_6) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n最为基本的规则，三张牌中，三个且仅有三个花" +
	        		"\n纹是相同，而且剩下的三个花纹的点数之和达到或" +
	        		"\n超过14点的，即可以 取牌。" +
	        		"\n\n对于初学者而言，可以满13点取牌，以降低难度。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
            return "\n\n\n最も基本的な取牌規則です。三枚のカードにて3" +
            		"\nつの部分が同様になって、残り部分の点数を合わ" +
            		"\nせて\'\'総合14点になったら取牌できる初心者には" +
            		"\n13点になっても取牌できるようになってます";
	    return "\n\n\nThis is the most basic rule of taking cards." +
	    		"\n\nWhen three parts (must be exactly three) of the three cards has the same point and all the left points sums up to bigger equal then 14 points (or 13 points for a starter), then you can take the cards.";
	}
	// page 7
	if  (key == STRING_TUTORIAL_TITLE_PAGE_7) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌规则之二";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "取牌規則その二";
	    return "Rule 2 of taking cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_7) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "五点（五元宝）:";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "合-5点モード:";
	    return "Co-Five-Points mode:";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_7) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n三张牌中，三个且仅有三个花纹是相同，而且" +
	        		"\n剩下的三个花纹的点数之和正好是五点，即可以 取牌。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return  "\n\n\n残り部分の点数を\'合わせて\'五点を作りますという" +
	        		"\nことです。" +
	        		"\n\n 三枚のカードにて3つの部分が同様になって、 残" +
	        		"\nった点数の合計は5点になった場合は取牌すること" +
	        		"\nができる。" +
	        		"\n\n中国語には\'5枚の金インゴット\'という意味なんで" +
	        		"\nす。";
	    return "\n\n\nWhen three parts(must be exactly three) of the three cards has the same point and all the left points sums up to excatly five points, then you can take the cards." +
	    		"\n\nIn chinese this indicates \'Five gold ingots\'. ";
	}
	// page 8
	if  (key == STRING_TUTORIAL_TITLE_PAGE_8) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌规则之三";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "取牌規則その三";
	    return "Rule 3 of taking cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_8) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "分厢:";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "分点モード:";
	    return "Divide-Points mode:";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_8) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n三张牌中，三个且仅有三个花纹是相同，而且" +
	        		"\n剩下的三个花纹也正好相同，即可以取牌。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n6つの部分の点数を二つ組に分けて、計算するとい" +
	        		"\nうことです。" +
	        		"\n\n三枚のカードにて3つの部分が同様になって、残" +
	        		"\nった3つの部分も同様になった場合は取牌すること" +
	        		"\nができる。";
	    return "\n\n\nWhen three parts(must be exactly three) of the three cards has the same point and the left three parts also has the same point, then you can take the cards. ";
	}
	// page 9
	if  (key == STRING_TUTORIAL_TITLE_PAGE_9) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌规则之四";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "取牌規則その四";
	    return "Rule 4 of taking cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_9) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "双一二三、双四五六:";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "双点モード:";
	    return "Double-points mode:";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_9) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n三张牌中，花纹的点数恰为2个1点，2个2点，" +
	        		"\n2个3点；或恰为2个4点，2个5点，2个6点，即" +
	        		"\n可以 取牌。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n各点数の部分が二個あるということです。" +
	        		"\n\n6部分のカードの点数は、ちょうど一点二個、" +
	        		"\n2点二個、3点二個或いは4点二個、五点二個、" +
	        		"\n六点二個になった場合は取牌することができる。" +
	        		"\n\n中国語(双喜临门)には\'二つの庆事が一度に来る" +
	        		"\n\'という意味なんです。";
	    return "\n\n\nWhen the point of the three cards is exactly two \'1 point\', two \'2 point\' and two\' 3 point\' or two \'4 point\', two \'5 point\' and two \'6 point\', then you can take the cards." +
	    		"\n\nIn chinese this indicates \'Double Happiness\'.";
	}
	// page 10
	if  (key == STRING_TUTORIAL_TITLE_PAGE_10) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌规则之五";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "取牌規則その五";
	    return "Rule 5 of taking cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_10) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "割牌:";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "合点モード:";
	    return "Co-Points mode:";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_10) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n三张牌中，有四个花纹是相同的，而且剩下的" +
	        		"\n两个花纹的点数之和正好等于相同花纹的点数，" +
	        		"\n即可以取牌。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n三枚のカードにて4つの部分が同様になって、残っ" +
	        		"\nた2つの部分の合計もその4つの部分と同様になっ" +
	        		"\nた場合は取牌することができる。";
	    return "\n\n\nWhen four parts(must be exactly four) of the three cards has the same point and the left two parts also sums up to the same point (which makes five same point in total), then you can take the cards.";
	}
	// page 11
	if  (key == STRING_TUTORIAL_TITLE_PAGE_11) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌规则之六";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "取牌規則その六";
	    return "Rule 6 of taking cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_11) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "五子登科:";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "五同点モード:";
	    return "Five-Of-A-Kind-Points mode:";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_11) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n三张牌中，有五个花纹是相同的，此时不管剩下" +
	        		"\n的花纹的点数是多少，即可以取牌。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n三枚のカードにて5つの部分が同様になった場合は" +
	        		"\n、残った1つの部分の点数に関わらず、取牌するこ" +
	        		"\nとができる。" +
	        		"\n\n中国語(五子登科)には\'結婚の時に優秀な子供が生" +
	        		"\nまれることを祈って使われた祝辞\'という意味なん" +
	        		"\nです。";
	    return "\n\n\nWhen five parts(must be exactly five) of the three cards has the same point, then you can take the cards regardless of the left point." +
	    		"\n\nIn chinese this indicates \'Five sons Davydenko\'.";
	}
	// page 12
	if  (key == STRING_TUTORIAL_TITLE_PAGE_12) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌规则之七";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "取牌規則その七";
	    return "Rule 7 of taking cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_12) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "二三靠六:";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "二-三-六-点モード:";
	    return "Two-Three-Six-Points mode:";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_12) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n三张牌中，花纹的点数恰为2个2点，2个3点，" +
	        		"\n2个6点，即可以取牌。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n三枚のカードの点数は、ちょうど2枚2点、2枚3点" +
	        		"\n、2枚6点になった場合は取牌することができる。";
	    return "\n\n\nWhen the point of the three cards is exactly two \'2 point\', two \'3 point\' and two\'six point\' then you can take the cards. ";
	}
	// page 13
	if  (key == STRING_TUTORIAL_TITLE_PAGE_13) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "取牌规则之八";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "取牌規則その八";
	    return "Rule 8 of taking cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_13) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "不同:";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "ストレート-点モード:";
	    return "Straight-Points mode:";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_13) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n三张牌中，六个花纹恰不相同，点数恰为1个1点，" +
	        		"\n1个2点，1个3点，1个4点，1个5点，和1个6点，" +
	        		"\n即可以取牌。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n三枚のカードの点数は、ちょうど一点一個、" +
	        		"\n2点一個、三点一個、4点一個、5点一個、" +
	        		"\n6点一個になった場合は取牌することができる。";
	    return "\n\n\nWhen the point of the three cards is exactly one \'1 point\', one \'2 point\', one \' three point\' one \'4 point\', one \'5 point\' and one \'6 point\', then you can take the cards.";
	}
	// page 14
	if  (key == STRING_TUTORIAL_TITLE_PAGE_14) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "添牌规则之一";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "配牌規則その一";
	    return "Rule 1 of dealing cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_14) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "";
	    return "";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_14) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n每次认为完成了一轮五关(由上而下)的取牌步骤后，" +
	        		"\n就可以进行添牌。" +
	        		"\n首先从最后一行的牌的右侧，取出与剩余关数相同的" +
	        		"\n牌数。（如剩余4关就拿4张牌）" +
	        		"\n然后将取出的牌，从左往右，依次从下往上进行添牌" +
	        		"\n，添牌放在每一关的最右侧。" +
	        		"\n添牌完成后就可以继续进行取牌的步骤。";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n各関の取牌作業が終わったら、配牌を開始します。" +
	        		"\nまずは一番下の行の右側から、残り関数と同じ" +
	        		"\n数の牌数を取り出す。" +
	        		"\n取り出した牌の左から一枚一枚ずつ第五関から第" +
	        		"\n一関まで、各関の一番右に置きます。" +
	        		"\nこれで配牌終了です。" +
	        		"\n配牌終了してから、また取牌を開始します。";
	    return "\n\n\nWhen you finished the \'taking cards\' process for each \'stage\', you can start to deal cards." +
	    		"\nFirst take out the number of cards from the right side of your bottom row and make the number of cards same as the \'stages\' remains. (eg. take out 4 cards if you have 4 stages left)" +
	    		"\nThen deal the cards you took out from left to right, put it on the right side of each stage in sequence of 5th stage to 1st stage." +
	    		"\nAfter dealing cards for each stages, you can start to taking card again.";
	}
	// page 15
	if  (key == STRING_TUTORIAL_TITLE_PAGE_15) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "游戏界面按钮的作用";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "配牌規則その二";
	    return "Rule 2 of dealing cards";
	}
	if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_15) {
	    if (currentLanguageType == LANGUAGE_CHINESE) return "";
	    if (currentLanguageType == LANGUAGE_JAPANESE) return "";
	    return "";
	}
	if  (key == STRING_TUTORIAL_INFO_PAGE_15) {
	    if (currentLanguageType == LANGUAGE_CHINESE)
	        return "\n\n\n当剩余可以用来添牌的牌数少于剩余关数的时候，" +
	        		"\n需要用以下方式来指定添牌的关数。" +
	        		"\n1. 保证从下往上添牌" +
	        		"\n2. 每关最多一张添牌，可以没有添牌。" +
	        		"\n如，剩余5关，剩余可用于添牌数4张，此时可行的" +
	        		"\n添牌方式有：" +
	        		"\n第5关一张，第4关一张，第3关一张；" +
	        		"\n第5关一张，第3关一张，第2关一张；" +
	        		"\n......";
	    if (currentLanguageType == LANGUAGE_JAPANESE)
	        return "\n\n\n残り配牌に用いる牌数が残り関数より少ないの" +
	        		"\n場合は、以下の規則で指定の関に配牌する：" +
	        		"\n\n1．配牌に用いる牌の左から右まで使うこと" +
	        		"\n2．配牌するのは第五関から第一関までの順にする" +
	        		"\nこと" +
	        		"\n3．各関での配牌数は最大一枚にすべきこと。(詰" +
	        		"\nまりある関で配牌しなくでも大丈夫です)" +
	        		"\n例えば配牌に用いる牌数は3、残り関数は5にな" +
	        		"\nった場合、以下の配牌方は正解です：" +
	        		"\n1．第5関一枚、第4関一枚、第3関一枚；" +
	        		"\n2．第5関一枚、第3関一枚、第2関一枚；" +
	        		"\n......";
	    return "\n\n\nWhen the card number of the bottom row is less than the remained stage number,  you can specify the stage to deal the card according to the following ruls:" +
	    		"\n\n1.Deal remained cards from left to right" +
	    		"\n2.Deal remained cards to the stages in" +
	    		"\nSequence of lower stage to higher stage." +
	    		"\n3.Each stage can add no more then one card." +
	    		"\nEg, 3 cards to deal with 5 stages left:" +
	    		"\n5th, 4th, 3rd stage each deals with one card;" +
	    		"\n5th, 4th, 2nd stage each deals with one card;" +
	    		"\netc.";
	}
    return "ERROR";
};
