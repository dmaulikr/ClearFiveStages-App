#import "GameData.h"

@implementation CFSScoreData
@synthesize playerName;
@synthesize playTimeInSec;
@synthesize playDate;
@synthesize rank;
@synthesize successfulHit;
@synthesize failedHit;
@synthesize hitPercentage;
@synthesize gameLevel;

#define kPlayerNameKey					@"playerName"
#define kPlayTimeInSecKey				@"playTimeInSec"
#define kPlayDateKey					@"playDate"
#define kRankKey                        @"rank"
#define kSuccessfulHitKey			@"successfulHit"
#define kFailedHitKey				@"failedHit"
#define kHitPercentageKey		    @"hitPercentage"
#define kGameLevelKey		    	@"gameLevel"

-(id)init {  
	if( (self = [super init]) ) {
        self.playTimeInSec = 0;
		self.playerName = @"anonymous";
        self.playDate = [NSDate new];
        self.rank = 9999;
		self.successfulHit = 0;
		self.failedHit = 0;
		self.hitPercentage = 0.0f;
		self.gameLevel = 0;
	}
	return self;
}
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.playerName forKey:kPlayerNameKey];
	[encoder encodeObject:self.playDate forKey:kPlayDateKey];
	[encoder encodeObject:[NSNumber numberWithInt:self.playTimeInSec] forKey:kPlayTimeInSecKey];
    [encoder encodeObject:[NSNumber numberWithInt:self.rank] forKey:kRankKey];
	[encoder encodeObject:[NSNumber numberWithInt:self.successfulHit] forKey:kSuccessfulHitKey];
	[encoder encodeObject:[NSNumber numberWithInt:self.failedHit] forKey:kFailedHitKey];
	[encoder encodeObject:[NSNumber numberWithFloat:self.hitPercentage] forKey:kHitPercentageKey];
	[encoder encodeObject:[NSNumber numberWithInt:self.gameLevel] forKey:kGameLevelKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
	CFSScoreData *cfsScoreData = [[CFSScoreData alloc] init];
    cfsScoreData.playerName = [decoder decodeObjectForKey:kPlayerNameKey];
	cfsScoreData.playDate = [decoder decodeObjectForKey:kPlayDateKey];
	cfsScoreData.playTimeInSec = [[decoder decodeObjectForKey:kPlayTimeInSecKey] intValue];
    cfsScoreData.rank = [[decoder decodeObjectForKey:kRankKey] intValue];
	cfsScoreData.successfulHit = [[decoder decodeObjectForKey:kSuccessfulHitKey] intValue];
	cfsScoreData.failedHit = [[decoder decodeObjectForKey:kFailedHitKey] intValue];
	cfsScoreData.hitPercentage = [[decoder decodeObjectForKey:kHitPercentageKey] floatValue];
    cfsScoreData.gameLevel = [[decoder decodeObjectForKey:kGameLevelKey] intValue];
    return [cfsScoreData autorelease];
}
@end
