#import "MultiLanguageUtil.h"
#import "GameDataManager.h"

@implementation MultiLanguageUtil

+(NSString *) getI18NResourceNameFrom:(NSString *)resourceName {
    NSString* resourcePureName = [[resourceName lastPathComponent] stringByDeletingPathExtension];
    NSString* resourceExtensionName = [resourceName pathExtension];
    int currentLanguageType = [GameDataManager sharedManager].languageType;
    if (currentLanguageType == LANGUAGE_CHINESE) return [NSString stringWithFormat:@"%@%@.%@", resourcePureName, @"-zh", resourceExtensionName];
    if (currentLanguageType == LANGUAGE_JAPANESE) return [NSString stringWithFormat:@"%@%@.%@", resourcePureName, @"-ja", resourceExtensionName];
    return [NSString stringWithFormat:@"%@%@.%@", resourcePureName, @"-en", resourceExtensionName];
}

+(NSString *) getTimeStringFromSecond:(int)sec {
    int currentLanguage = [GameDataManager sharedManager].languageType;
	int h = sec / 3600;
	int m = (sec - 3600 * h) / 60;
	int s = sec - m * 60 - h * 3600;
	if (sec > 3599) {
		if (currentLanguage == LANGUAGE_CHINESE) return [NSString stringWithFormat:@"%d时:%d分:%d秒", h, m, s];
		if (currentLanguage == LANGUAGE_JAPANESE) return [NSString stringWithFormat:@"%d時:%d分:%d秒", h, m, s];
		return [NSString stringWithFormat:@"%dH:%dM:%dS", h, m, s];
	}
	if (sec < 3600 && sec > 59) {
		if (currentLanguage == LANGUAGE_CHINESE) return [NSString stringWithFormat:@"%d分:%d秒", m, s];
		if (currentLanguage == LANGUAGE_JAPANESE) return [NSString stringWithFormat:@"%d分:%d秒", m, s];
		return [NSString stringWithFormat:@"%dM:%dS", m, s];
	}
	if (currentLanguage == LANGUAGE_CHINESE) return [NSString stringWithFormat:@"%d秒", s];
	if (currentLanguage == LANGUAGE_JAPANESE) return [NSString stringWithFormat:@"%d秒", s];
	return [NSString stringWithFormat:@"%dS", s];
}

+(NSString *) getLocalizatedStringForKey:(STRING_KEY)key {
    LanguageType currentLanguageType = [GameDataManager sharedManager].languageType;
    GameLevel currentGameLevel = [GameDataManager sharedManager].gameLevel;
    // common
    if (key == STRING_CONFIRM_YES) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"是";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"はい ";
        return @"YES";
    }
    if (key == STRING_CANCEL_NO) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"否";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"いいえ";
        return @"NO";
    }
    if (key == STRING_GAMELEVEL_EASY) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"简单";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"簡単";
        return @"Easy";
    }
    if (key == STRING_GAMELEVEL_NORMAL) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"普通";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"普通";
        return @"Normal";
    }
    if (key == STRING_GAMELEVEL_HARD) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"困难";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"困難";
        return @"Hard";
    }    
    if (key == STRING_WARNING) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"警告!";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"注意!";
        return @"Warning";
    }
    if (key == STRING_RESTART_GAME) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"新游戏";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"再挑戦";
        return @"Retry";
    }
    // main scene
    if (key == STRING_START_GAME) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"开始游戏";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"ゲーム開始";
        return @"Game Start";
    }
    if (key == STRING_GAME_HIGHSCORE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"高分榜";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"成績一覧";
        return @"HighScore";
    }
    if (key == STRING_ABOUT_GAME) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"关于游戏";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"ゲームについて";
        return @"About Game";
    }
    if (key == STRING_GAME_TUTORIAL) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"游戏帮助";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"チュートリアル";
        return @"Tutorial";
    }
    // highscore scene
    if (key == STRING_HIGHSCORE_RANK) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"名 次";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"順 位";
        return @"Rank";
    }
    if (key == STRING_HIGHSCORE_PLAYERNAME) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"姓 名";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"名 前";
        return @"Name";
    }
    if (key == STRING_HIGHSCORE_PLAYDATE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"日 期";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"日 付";
        return @"Date";
    }
    if (key == STRING_HIGHSCORE_COSTTIME) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"耗 时";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"時 間";
        return @"Time";
    }
    if (key == STRING_HIGHSCORE_ACCURACY) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"正 确 率";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"正 確 率";
        return @"Accuracy";
    }
    // alert view
    if (key == STRING_ALERT_RESTART_MESSAGE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"您想要重新开始新游戏吗?";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"ゲームを再開するの？";
        return @"Are your really going to start a new game?";
    }
    if (key == STRING_ALERT_DEAL_MESSAGE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"还有被选中的牌没有处理，是否要发牌?";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"選択された牌があります、それを無視して配牌しますか？";
        return @"You still have selected Paigows, deal cards anyway?";
    }
    if (key == STRING_ALERT_NEXT_MESSAGE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"本关中还有被选中的牌，是否要去到下一关?";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"本間まだ選択された牌があります、それを無視して次間に移動しますか?";
        return @"You still have selected Paigow in this stage, continue anyway?";
    }
    // gameplay scene
    if (key == STRING_TIMER) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"时间";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"時間";
        return @"Time";
    }
    if (key == STRING_DEALCARD) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"发牌";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"配牌";
        return @"Deal";
    }
    if (key == STRING_GETCARD) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌";
        return @"Get";
    }
    if (key == STRING_NEXTROW) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"下一关";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"次行";
        return @"Next";
    }
    if (key == STRING_SHOWHINT) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"提示";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"ヒント";
        return @"Hint";
    }
    if (key == STRING_CLEARED) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"已通关";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"クリアー";
        return @"Cleared";
    }
    // levelSelect scene
    if (key == STRING_CHOOSE_GAMELEVEL) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"选 择 等 度";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"難しさ選ぶ";
        return @"Choose Level";
    }
    if (key == STRING_GAMELEVEL_EASY_INFO) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"有提示，基本点数和为13";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"提示あり，基本点数要求13";
        return @"With hint, 13-point mode";
    }
    if (key == STRING_GAMELEVEL_NORMAL_INFO) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"有提示，基本点数和为14";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"提示あり，基本点数要求14";
        return @"With hint, 14-point mode";
    }
    if (key == STRING_GAMELEVEL_HARD_INFO) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"无提示，基本点数和为14";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"提示なし，基本点数要求14";
        return @"No hint, 14-point mode";
    }
    if (key == STRING_CHOOSE_TABLE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"选择桌面背景";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"テーブル選ぶ";
        return @"Choose table";
    }
    // paigow ruletype
    if (key == STRING_PAIGOW_RULETYPE_NONE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"不对哦!";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"おっと!";
        return @"Ooops!";
    }
    if (key == STRING_PAIGOW_RULETYPE_NORMAL) {
        if (currentLanguageType == LANGUAGE_CHINESE) return (currentGameLevel == GAMELEVEL_EASY) ? @"13点+" : @"14点+";
        if (currentLanguageType == LANGUAGE_JAPANESE) return (currentGameLevel == GAMELEVEL_EASY) ? @"13点+" : @"14点+";
        return (currentGameLevel == GAMELEVEL_EASY) ? @"13-Point+" : @"14-Point+";
    }
    if (key == STRING_PAIGOW_RULETYPE_LEFT_FIVE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"五元宝";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"合-5点モード";
        return @"Co-Five-Points";
    }
    if (key == STRING_PAIGOW_RULETYPE_DIVIDE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"分厢";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"分点モード";
        return @"Divide-Points";
    }
    if (key == STRING_PAIGOW_RULETYPE_DOUBLE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"双123，456";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"双点モード";
        return @"Double-Points";
    }
    if (key == STRING_PAIGOW_RULETYPE_LEFT_SAME) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"割牌";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"合点モード";
        return @"Co-Points";
    }
    if (key == STRING_PAIGOW_RULETYPE_FIVE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"五子登科";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"五同点モード";
        return @"Five-of-A-Kind";
    }   
    if (key == STRING_PAIGOW_RULETYPE_TTS) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"二三靠六";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"2-3-6モード";
        return @"2-3-6-Points";
    }  
    if (key == STRING_PAIGOW_RULETYPE_CONTINUE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"1-2-3-4-5-6";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"ストレートモード";
        return @"Straight-Points";
    }
    // pause layer
    if (key == STRING_RESUME_GAME) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"继续游戏";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"ゲーム再開";
        return @"Resume Game";
    }
    if (key == STRING_MAINMENU) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"主菜单";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"メインメニュー";
        return @"Main Menu";
    }
    // option layer
    if (key == STRING_OPTION_TITLE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"设置";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"设置";
        return @"Option";
    }
    if (key == STRING_CHOOSE_LANGUAGE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"语言";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"言語";
        return @"Language";
    }
    if (key == STRING_MUSIC) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"音乐";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"音楽";
        return @"Music";
    }
    if (key == STRING_SOUND) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"音效";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"サウンド";
        return @"Sound";
    }
    if (key == STRING_PLAYERNAME) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"玩家";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"名前";
        return @"Player Name";
    }
    // game win layer
    if (key == STRING_GAMEWIN) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"恭喜通关成功 !!!";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"クリア成功おめでとう!!!";
        return @"Congratulations!!!";
    }
    if (key == STRING_GAMELEVEL) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"难度";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"レベル";
        return @"Level";
    }
    if (key == STRING_SHARE_SCORE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"分享:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"シェアー:";
        return @"Share:";
    }
    if (key == STRING_RANK_OUT) {
		if (currentLanguageType == LANGUAGE_CHINESE) return @"无法获取名次";
		if (currentLanguageType == LANGUAGE_JAPANESE) return @"順位取得エラー";
		return @"Error fetch rank";
	}
    // game lose layer
    if (key == STRING_GAMELOSE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"游戏结束 !!!";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"ゲームオーバー!!!";
        return @"Game Over!!!";
    }
    if (key == STRING_GAMELOSE_INFO) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"祝你下次好运 ^_^";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"今度クリアできるよう^_^";
        return @"Better luck next time :)";
    }
    // email
    if  (key == STRING_EMAIL_ALERT_TITLE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"系统错误";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"システムエラー";
        return @"System Error";
    }
    if  (key == STRING_EMAIL_ALERT_MESSAGE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"请先设置邮件帐户";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"アカウントを設定してください";
        return @"Please setup a mail account first";
    }
    if  (key == STRING_EMAIL_ALERT_CONFIRM) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"知道了";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"わかりました";
        return @"OK";
    }
    if  (key == STRING_EMAIL_TITLE) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"来试试中国传统牌九游戏不一样的玩法吧!";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"牌九について";
        return @"Nice chinese tanditional card game!";
    }
    if  (key == STRING_EMAIL_RECIPIENT) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"好友地址@XXX.com";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"友達宛先@XXX.com";
        return @"yourFriend@XXX.com";
    }
    if  (key == STRING_EMAIL_CONTENT) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"只需要一个人就可以进行的玩法，消磨时间的好东西^_^ \n还可以问问你的爷爷奶奶，说不定他们也都会玩呢。 App下载地址：http://itunes.apple.com/us/app/clear-5-stages/id432737724";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"一人でも楽しめる遊び方、暇つぶし最高！リンク先：http://itunes.apple.com/us/app/clear-5-stages/id432737724";
        return @"Enjoy the PaiGow game alone, great way to kill time :)　App link: http://itunes.apple.com/us/app/clear-5-stages/id432737724";
    }
    // social
    if (key == STRING_TWITTER_CONTENT) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"一起来玩通五关吧，我已经顺利通关成功:)";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"一緒に通五関をしよ　〜　私はただいま全関をクリアーしました^_^";
        return @"A greate chinese tanditional card game -- \"Clear-Five-Stages\". Come and give it a shot :)";
    }
    if (key == STRING_FACEBOOK_CONTENT) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"一起来玩通五关吧，我已经顺利通关成功:)";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"一緒に通五関をしよ　〜　私はただいま全関をクリアーしました^_^";
        return @"I just cleared all the stages in this chinese tanditional card game -- \"Clear-Five-Stages\". Come and give it a shot :)";
    }
    
    // help scene
    // page 1
    if  (key == STRING_TUTORIAL_TITLE_PAGE_1) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"牌九简介";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"牌九について";
        return @"About PaiGow";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_1) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"";
        return @"";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_1) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"牌类娱乐用品。又称骨牌。牌九每副为32张，用骨头、象牙、竹子或乌木制成，每张呈长方体，正面分别刻着以不同方式排列的由2到12的点子。\
            		 \n\n牌九起源于中国，在民间流传较广，属于娱乐消遣用具。牌九一般为4个人玩，玩 法多种，变化也较多。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"PAIGOWはパイガオポーカーで言及した牌九という中国のドミノ牌を使用するゲームで、西部開拓時代にアメリカで普及したゲームである。\
            		 \n\n19世紀半ばには早くもカジノゲームなり20世紀初頭まで遊ばれたが、1930年代には消滅し、1960年代になってまた遊ばれるようになって現在にいたっている。";
        return @"Paigow(牌九) is a Chinese gambling game played with a set of Chinese dominoes.\
        		 \n\nPai gow is played in unsanctioned casinos in most Chinese communities.\
        		 \n\nIt is played openly in major casinos in China. It dates back to at least the Song Dynasty, and is a game steeped in tradition.";
    }
    // page 2
    if  (key == STRING_TUTORIAL_TITLE_PAGE_2) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"游戏界面按钮的作用";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"それぞれのボタンの役割";
        return @"Usage of buttons";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_2) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"";
        return @"";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_2) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"发牌: 用来进行发牌的操作\
            		 \n下一关: 用来在关与关之间进行移动(从上至下)\
            		 \n取牌: 当选好您认为满足取牌规则的牌之后，进行取牌的操作\
            		 \n新游戏: 放弃当前的游戏，开始新游戏\
            		 \n提示: 用来提示当前关的可取牌的组合";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"配牌: 配牌する操作を行う\
            		 \n次行: 次の関に移動する(上から下まで)\
            		 \n取牌: ある規則に満たせた牌を取牌する\
            		 \n新规: 新しゲームを開始する\
            		 \n提示: 本関にて規則を満たせる牌をヒントする";
        return @"Deal: Used to deal the cards to each stages\
        		\nNext: Used to move to next stage\
        		\nGet: Used to take the cards which match the certain rule.\
        		\nNew: Used to start a new game.\
        		\nHint: Used to show the hint of taking cards.";
    }
    // page 3
    if  (key == STRING_TUTORIAL_TITLE_PAGE_3) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"如何取牌";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"牌の取り方";
        return @"How to take cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_3) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"";
        return @"";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_3) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"永远只能从每一关的最边缘开始选牌，并且只能连续选牌，不能跳开了选。\
                     \n\n您只需要触摸您想要选取的牌就可以完成选牌的操作。\
            		 \n\n再次触摸已经被选中的牌就可以取消选中。\
            		 \n\n蓝色的区域表明当前正在进行“选牌取牌”的关卡。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"牌を取る時両端から取る及び連続取ることが決りなんです。\
                     \n指先で欲しいの牌をタッチするより牌を選ぶことができる。\
            		 \n\n既に選択された牌をもう一回タッチするより選択された状態から外すことができる。\
            		 \n\n青い部分は今 ”配牌・取牌” されている関を示している。";
        return @"You can only take the cards from side of a stage and keep taking continuously.\
                 \nSimply touch the cards that you think match certain rule.\
        		 \n\nTouch the selected card again to unselect it.\
        		 \n\nThe blue part indicates the current stage which is being processed.";
    }
    // page 4
    if  (key == STRING_TUTORIAL_TITLE_PAGE_4) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"如何查看被隐藏的牌";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"隠された牌を見る方法";
        return @"Check invisible cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_4) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"";
        return @"";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_4) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"如果某一关的牌数太多(超出了屏幕的显示范围)，中间的部分就会变成小气泡，气泡中央的数字表示有多少张牌被隐藏了。\
            		 \n\n触摸小气泡就可以看到被隐藏的牌。当被隐藏的牌数较多时，可以左右滑动牌来查看所有的牌。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"ある関で牌数が一定な数に超えたら、小さいバブルになります。そのバブルにて書かれている数字は隠された牌数を示している。\
            		 \n\nバブルをタッチするより隠された牌を見ることができる。大量な牌数がある場合は、牌を指でスクロールして見ることができる。";
        return @"When too many cards in a stage, the middle part becomes little bubble.\
        		 \n\nThe number in the bubble indicates how many cards are in it.\
        		 \nTouch the bubble to check the invisible cards";
    }
    // page 5
    if  (key == STRING_TUTORIAL_TITLE_PAGE_5) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"使用帮助箭头进行添牌";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"矢印より配牌する方法";
        return @"Dealing cards with arrow";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_5) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"";
        return @"";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_5) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"当剩余的牌数不够进行添牌的操作时，右侧就会出现一排小箭头帮助您进行添牌。\
            		 \n\n根据添牌的规则，点击您想要添牌的关，就可以完 成添牌的操作。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"残り牌数が配牌に足りなくなった場合、右側に黒い矢印がでます。\
            		 \n\n矢印をタッチするより対応された関に配牌することができる。";
        return @"When the left cards is not enough to deal, couple of arrows will help you to place cards.\
        		 \nTouch the arrow which pointed to the stage you want to put the card on.";
    }
    // page 6
    if  (key == STRING_TUTORIAL_TITLE_PAGE_6) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌规则之一";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌規則その一";
        return @"Rule 1 of taking cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_6) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"14点:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"14点モード:";
        return @"14-Points mode:";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_6) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"最为基本的规则，三张牌中，三个且仅有三个花纹是相同，而且剩下的三个花纹的点数之和达到或超过14点的，即可以 取牌。\
            		\n\n对于初学者而言，可以满13点取牌，以降低难度。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"最も基本的な取牌規則です。\
                    \n\n三枚のカードにて3つの部分が同様になって、残り部分の点数を\"合わせて\"総合14点になったら取牌できる\
                    \n初心者には13点になっても取牌できるようになってます。";
        return @"The most basic rule of taking cards.\
        		 \n\nWhen three parts (exactly three) of the three cards has the same point and all the left points sums up to bigger equal then 14 points (13 for starter), you can take the cards.";
    }
    // page 7
    if  (key == STRING_TUTORIAL_TITLE_PAGE_7) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌规则之二";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌規則その二";
        return @"Rule 2 of taking cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_7) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"五点（五元宝）:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"合-5点モード:";
        return @"Co-Five-Points mode:";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_7) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"三张牌中，三个且仅有三个花纹是相同，而且剩下的三个花纹的点数之和正好是五点，即可以 取牌。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"残り部分の点数を\"合わせて\"五点を作りますということです。\
            		 \n\n三枚のカードにて3つの部分が同様になって、 残った点数の合計は5点になった場合は取牌することができる。\
            		 \n中国語には\"5枚の金インゴット\"という意味なんです。";
        return @"When three parts(must be exactly three) of the three cards has the same point and all the left points sums up to excatly five points, then you can take the cards.\
        		 \nIn chinese this indicates \"Five gold ingots\". ";
    }
    // page 8
    if  (key == STRING_TUTORIAL_TITLE_PAGE_8) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌规则之三";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌規則その三";
        return @"Rule 3 of taking cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_8) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"分厢:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"分点モード:";
        return @"Divide-Points mode:";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_8) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"\n三张牌中，三个且仅有三个花纹是相同，而且 剩下的三个花纹也正好相同，即可以 取牌。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"\n6つの部分の点数を二つ組に分けて、計算するということです。\
            		 \n三枚のカードにて3つの部分が同様になって、 残った3つの部分も同様になった場合は取牌することができる。";
        return @"\nWhen three parts(must be exactly three) of the three cards has the same point and the left three parts also has the same point, then you can take the cards. ";
    }
    // page 9
    if  (key == STRING_TUTORIAL_TITLE_PAGE_9) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌规则之四";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌規則その四";
        return @"Rule 4 of taking cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_9) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"双一二三、双四五六:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"双点モード:";
        return @"Double-points mode:";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_9) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"三张牌中，花纹的点数恰为2个1点，2个2点，2个3点；或恰为2个4点，2个5点，2个6点，即可以 取牌。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"\n各点数の部分が二個あるということです。\
            		 \n6部分のカードの点数は、ちょうど一点二個、2点二個、3点二個或いは4点二個、五点二個、六点二個になった場合は取牌することができる。\
            		 \n中国語(双喜临门)には\"二つの庆事が一度に来る\"という意味なんです。";
        return @"\nWhen the point of the three cards is exactly two \"1 point\", two \"2 point\" and two\" 3 point\" or two \"4 point\", two \"5 point\" and two \"6 point\", then you can take the cards.\
        		 \nIn chinese this indicates \"Double Happiness\".";
    }
    // page 10
    if  (key == STRING_TUTORIAL_TITLE_PAGE_10) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌规则之五";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌規則その五";
        return @"Rule 5 of taking cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_10) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"割牌:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"合点モード:";
        return @"Co-Points mode:";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_10) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"\n三张牌中，有四个花纹是相同的，而且剩下的两个花纹的点数之和正好等于相同花纹的点数，即可以取牌。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"\n三枚のカードにて4つの部分が同様になって、 残った2つの部分の合計もその4つの部分と同様になった場合は取牌することができる。";
        return @"\nWhen four parts(must be exactly four) of the three cards has the same point and the left two parts also sums up to the same point (which makes five same point in total), then you can take the cards.";
    }
    // page 11
    if  (key == STRING_TUTORIAL_TITLE_PAGE_11) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌规则之六";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌規則その六";
        return @"Rule 6 of taking cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_11) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"五子登科:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"五同点モード:";
        return @"Five-Of-A-Kind-Points mode:";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_11) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"三张牌中，有五个花纹是相同的，此时不管剩下的花纹的点数是多少，即可以取牌。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"\n三枚のカードにて5つの部分が同様になった場合は、残った1つの部分の点数に関わらず、取牌することができる。\
            		 \n中国語(五子登科)には\"結婚の時に優秀な子供が生まれることを祈って使われた祝辞\"という意味なんです。";
        return @"When five parts(must be exactly five) of the three cards has the same point, then you can take the cards regardless of the left point. In chinese this indicates \"Five sons Davydenko\".";
    }
    // page 12
    if  (key == STRING_TUTORIAL_TITLE_PAGE_12) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌规则之七";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌規則その七";
        return @"Rule 7 of taking cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_12) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"二三靠六:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"二-三-六-点モード:";
        return @"Two-Three-Six-Points mode:";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_12) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"三张牌中，花纹的点数恰为2个2点，2个3点，2个6点，即可以取牌。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"三枚のカードの点数は、ちょうど2枚2点、2枚3点、2枚6点になった場合は取牌することができる。";
        return @"When the point of the three cards is exactly two \"2 point\", two \"3 point\" and two\"six point\" then you can take the cards. ";
    }
    // page 13
    if  (key == STRING_TUTORIAL_TITLE_PAGE_13) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"取牌规则之八";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"取牌規則その八";
        return @"Rule 8 of taking cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_13) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"不同:";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"ストレート-点モード:";
        return @"Straight-Points mode:";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_13) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"\n三张牌中，六个花纹恰不相同，点数恰为1个1点，1个2点，1个3点，1个4点，1个5点，和1个6点，即可以取牌。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"\n三枚のカードの点数は、ちょうど一点一個、2点一個、三点一個、4点一個、5点一個、6点一個になった場合は取牌することができる。";
        return @"\nWhen the point of the three cards is exactly one \"1 point\", one \"2 point\", one \" three point\" one \"4 point\", one \"5 point\" and one \"6 point\", then you can take the cards.";
    }
    // page 14
    if  (key == STRING_TUTORIAL_TITLE_PAGE_14) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"添牌规则之一";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"配牌規則その一";
        return @"Rule 1 of dealing cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_14) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"";
        return @"";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_14) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"每次认为完成了一轮五关(由上而下)的取牌步骤后，就可以进行添牌。\
            		 \n首先从最后一行的牌的右侧，取出与剩余关数相同的牌数。（如剩余4关就拿4张牌）\
            		 \n然后将取出的牌，从左往右，依次从下往上进行添牌,添牌放在每一关的最右侧。\
            		 \n添牌完成后就可以继续进行取牌的步骤。";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"各関の取牌作業が終わったら、配牌を開始します。\
            		 \nまずは一番下の行の右側から、残り関数と同じ数の牌数を取り出す。\
            		 \n取り出した牌の左から一枚一枚ずつ第五関から第一関まで、各関の一番右に置きます。\
            		 \nこれで配牌終了です。\
            		 \n配牌終了してから、また取牌を開始します。";
        return @"After finished taking cards for each stage, you can start to deal cards.\
        		 \nTake out the number of cards from the right side of the bottom row and make the number same as the stages remains.\
        		 \nThen deal the cards you took out from left to right, put it at the right side of each stage in sequence of 5th stage to 1st stage (from lower row to higher row).";
    }
    // page 15
    if  (key == STRING_TUTORIAL_TITLE_PAGE_15) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"添牌规则之二";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"配牌規則その二";
        return @"Rule 2 of dealing cards";
    }
    if  (key == STRING_TUTORIAL_SUBTITLE_PAGE_15) {
        if (currentLanguageType == LANGUAGE_CHINESE) return @"";
        if (currentLanguageType == LANGUAGE_JAPANESE) return @"";
        return @"";
    }
    if  (key == STRING_TUTORIAL_INFO_PAGE_15) {
        if (currentLanguageType == LANGUAGE_CHINESE)
            return @"\n当剩余可以用来添牌的牌数少于剩余关数的时候，需要用以下方式来指定添牌的关数。\
            		 \n1. 保证从下往上添牌\
            		 \n2. 每关最多一张添牌，可以没有添牌。\
            		 \n如，剩余5关，剩余可用于添牌数4张，此时可行的添牌方式有：\
            		 \n第5关一张，第4关一张，第3关一张；\
            		 \n第5关一张，第3关一张，第2关一张；\
            		 \n第5关一张，第3关一张，第1关一张；\
            		 \n第4关一张，第2关一张，第1关一张；\
            		 \n......";
        if (currentLanguageType == LANGUAGE_JAPANESE)
            return @"\n残り配牌に用いる牌数が残り関数より少ないの場合は、以下の規則で指定の関に配牌する：\
            		 \n\n1．配牌に用いる牌の左から右まで使うこと\
            		 \n2．配牌するのは第五関から第一関までの順にすること\
            		 \n3．各関での配牌数は最大一枚にすべきこと。(詰まりある関で配牌しなくでも大丈夫です)\
            		 \n例えば配牌に用いる牌数は3、残り関数は5になった場合、以下の配牌方は正解です：\
            		 \n1．第5関一枚、第4関一枚、第3関一枚；\
            		 \n2．第5関一枚、第3関一枚、第2関一枚；\
            		 \n......";
        return @"\nWhen the card number of the bottom row is less than the remained stage number,  you can specify the stage to deal the card according to the following ruls:\
        		 \n1.Deal remained cards from left to right\
        		 \n2.Deal remained cards to the stages in sequence of lower stage to higher stage.\
        		 \n3.Each stage can add no more then one card.\
        		 \nEg, 3 cards to deal with 5 stages left:\
        		 \n5th, 4th, 3rd stage each deals with one card;\
        		 \n5th, 4th, 2nd stage each deals with one card;\
        		 \netc.";
    }
    return @"ERROR";
}

@end
