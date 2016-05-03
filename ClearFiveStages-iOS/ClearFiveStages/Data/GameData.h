
@interface CFSScoreData : NSObject<NSCoding> {
    NSString *playerName;
	NSDate *playDate;
	int playTimeInSec;
    int rank;
	int successfulHit;
	int failedHit;
	float hitPercentage;
	int gameLevel;
}
@property (nonatomic, retain) NSString *playerName;
@property (nonatomic, retain) NSDate *playDate;
@property (nonatomic) int playTimeInSec;
@property (nonatomic) int rank;
@property (nonatomic) int successfulHit;
@property (nonatomic) int failedHit;
@property (nonatomic) float hitPercentage;
@property (nonatomic) int gameLevel;
@end