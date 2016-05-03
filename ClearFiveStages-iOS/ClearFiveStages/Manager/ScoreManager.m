#import "ScoreManager.h"
#import "SettingsManager.h"

@implementation ScoreManager
@synthesize cfsHighScoreDataArray;

static ScoreManager *_sharedManager = nil;
+(ScoreManager *)sharedManager {
	if (!_sharedManager) {
		if( [ [ScoreManager class] isEqual:[self class]] )
			_sharedManager = [[ScoreManager alloc] init];
		else
			_sharedManager = [[self alloc] init];
	}
	return _sharedManager;
}


-(id) init {  
	if( (self=[super init]) ) {
		[self loadLocalScoreData];
	}
	return self;
}

-(void)dealloc {
    [self.cfsHighScoreDataArray release];
	[super dealloc];
}

-(void) loadLocalScoreData {
    [[SettingsManager sharedSettingsManager] loadDataFromFile:@"HighScoreData.plist"];
    self.cfsHighScoreDataArray = [[SettingsManager sharedSettingsManager] getObject:@"cfsHighScoreDataArray"];
    if (!self.cfsHighScoreDataArray) {
        self.cfsHighScoreDataArray = [NSMutableArray array];
    }
}

-(void) saveHighScoreData:(CFSScoreData *)cfsScoreData {
    [self.cfsHighScoreDataArray addObject:cfsScoreData];
    [self sortCFSScoreDataArray:self.cfsHighScoreDataArray];
    if (self.cfsHighScoreDataArray.count > 10) [self.cfsHighScoreDataArray removeLastObject];
    [[SettingsManager sharedSettingsManager] setObject:self.cfsHighScoreDataArray keyString:@"cfsHighScoreDataArray"];
    [[SettingsManager sharedSettingsManager] saveToDataFile:@"HighScoreData.plist"];
    [self loadLocalScoreData];
}

-(int) rankForScore:(CFSScoreData *)cfsScoreData {
	NSMutableArray *currentHighScoreDataArray = [self scoreDataArrayForGameLevel:cfsScoreData.gameLevel];
	if (currentHighScoreDataArray.count < 10) return YES;
	[currentHighScoreDataArray addObject:cfsScoreData];
	[self sortCFSScoreDataArray:currentHighScoreDataArray];
	return [currentHighScoreDataArray indexOfObject:cfsScoreData];
}

-(void) sortCFSScoreDataArray:(NSMutableArray *)arrayToSort {
	NSSortDescriptor *playTimeDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"playTimeInSec" ascending:YES] autorelease];
	NSSortDescriptor *hitPercentageDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"hitPercentage" ascending:YES] autorelease];
	NSArray *descriptors = [NSArray arrayWithObjects:playTimeDescriptor, hitPercentageDescriptor, nil];
	NSArray *sortedArray = [arrayToSort sortedArrayUsingDescriptors:descriptors];
	[arrayToSort setArray:sortedArray];
}

-(NSMutableArray *) scoreDataArrayForGameLevel:(int)gameLevel {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (CFSScoreData *cfsScoreData in self.cfsHighScoreDataArray) {
	    if (cfsScoreData.gameLevel == gameLevel) [resultArray addObject:cfsScoreData];
	}
    return resultArray;
}

@end
