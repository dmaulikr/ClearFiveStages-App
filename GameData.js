var CFSScoreData = Parse.Object.extend("CFSScoreData",
	{
		initialize:function () {
		    this.playerName = "ANONYMOUS";
		    this.playTimeInSec = 99999;
		    this.rank = -1;
	        this.successfulHit = 0;
	        this.failedHit = 0;
	        this.hitPercentage = 0.0;
	        this.gameLevel = 1;
            this.platform = PLATFORM;
	        this.updateScore();
	    },
	    updateScore:function () {
	        this.set("playerName", this.playerName);
	        this.set("playTimeInSec", this.playTimeInSec);
	        this.set("rank", this.rank);
	        this.set("successfulHit", this.successfulHit);
	        this.set("failedHit", this.failedHit);
	        this.set("hitPercentage", this.hitPercentage);
	        this.set("gameLevel", this.gameLevel);
            this.set("platform", this.platform);
	    },
	    saveScore:function (callback) {
	    	this.updateScore();
	    	this.save(null, {
	    		  success: function(cfsScoreData) {
	    			  callback(cfsScoreData);
	    		  },
	    		  error: function(error) {
	    			  callback(null);
	    		  }
	    	});
	    }
    }
);
