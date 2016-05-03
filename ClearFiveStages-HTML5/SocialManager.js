var SocialManager = function () {};

SocialManager.initParse = function () {
	Parse.initialize("3iitu2PAVWakyCiGC17Bwj0Ch11LBEGo1dPJh45O", "LHgKe2FPApEXZzvh9vfPH5UvYO8V2lAXVj2yPXVZ");
};

SocialManager.initFB = function () {
	FB.init({
	    appId: "152248208267848",
	    cookie: true
	});
};

SocialManager.createTwitterWebIntentURL = function (content) {
    return "https://twitter.com/intent/tweet?text={0}".format(content);
};

SocialManager.createFacebookBragDialog = function (name, caption) {
	FB.ui({ method: 'feed',
        caption: caption,
        picture: 'http://a859.phobos.apple.com/us/r1000/096/Purple/v4/dc/22/7d/dc227d7b-79e7-e15d-2d53-515027e59064/mzl.qbjbheyf.170x170-75.png',
        name: name
    }, null);
};

SocialManager.createSinaWBURL = function (content) {
	WB2.anyWhere(function(W){
	    W.widget.publish({
	    			id: "",
			        toolbar:"face,image,topic",
			        button_type:"red",
			        button_size:"middle",
			        default_text:content
			    })});
};
