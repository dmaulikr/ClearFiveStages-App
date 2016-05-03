var ScoreManager = function () {};

ScoreManager.saveScoreData = function (cfsScoreData, callback) {
	cfsScoreData.saveScore(callback);
};

ScoreManager.scoreDataArrayForGameLevel = function (gameLevel, callback) {
	var query = new Parse.Query(CFSScoreData);
	query.equalTo("gameLevel", gameLevel);
	query.ascending("playTimeInSec");
	query.limit(10);
	query.find({
	  success: function(results) {
		var array = new Array();
	    for (var i = 0; i < results.length; i++) {
	    	var cfsScoreData = results[i];
	    	cfsScoreData.playerName = cfsScoreData.get("playerName");
			cfsScoreData.playTimeInSec = cfsScoreData.get("playTimeInSec");
			cfsScoreData.successfulHit = cfsScoreData.get("successfulHit");
			cfsScoreData.failedHit = cfsScoreData.get("failedHit");
			cfsScoreData.hitPercentage = cfsScoreData.get("hitPercentage");
			cfsScoreData.gameLevel = cfsScoreData.get("gameLevel");
	    	array.push(cfsScoreData);
	    }
	    callback(array);
	  },
	  error: function(error) {
		  callback(new Array());
		  alert("error");
	  }
	});
};