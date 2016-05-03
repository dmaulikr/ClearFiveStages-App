#import "cocos2d.h"
#import "GameData.h"

@interface ScoreManager: NSObject {
	NSMutableArray *cfsHighScoreDataArray;
}

+(ScoreManager *)sharedManager;
-(void) loadLocalScoreData;
-(void) saveHighScoreData:(CFSScoreData *)cfsScoreData;
-(int) rankForScore:(CFSScoreData *)cfsScoreData;
-(NSMutableArray *) scoreDataArrayForGameLevel:(int)gameLevel;

@property(nonatomic, retain) NSMutableArray *cfsHighScoreDataArray;
@end
