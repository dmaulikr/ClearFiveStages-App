#import "cocos2d.h"
#import "AppDelegate.h"
#import "SplashScreenLayer.h"
#import "MultiLanguageUtil.h"
#import "GCCache.h"

@implementation MyNavigationController
-(NSUInteger)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if (interfaceOrientation == UIInterfaceOrientationPortrait) return YES;
    return NO;
}

-(void) directorDidReshapeProjection:(CCDirector*)director {
	if(director.runningScene == nil) {
		[director runWithScene: [SplashScreenLayer node]];
	}
}
#pragma mark Compose Mail
- (void)setUpMailAccount {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[MultiLanguageUtil getLocalizatedStringForKey:STRING_EMAIL_ALERT_TITLE]
									   	   	   	    message:[MultiLanguageUtil getLocalizatedStringForKey:STRING_EMAIL_ALERT_MESSAGE]
									   	   	   	   delegate:self
									   	  cancelButtonTitle:[MultiLanguageUtil getLocalizatedStringForKey:STRING_EMAIL_ALERT_CONFIRM]
									   	  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void)displayComposerSheet {
	if(![MFMailComposeViewController canSendMail]) {
		[self setUpMailAccount];
		return;
	}
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	[picker setSubject:[MultiLanguageUtil getLocalizatedStringForKey:STRING_EMAIL_TITLE]];
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:[MultiLanguageUtil getLocalizatedStringForKey:STRING_EMAIL_RECIPIENT]];
	[picker setToRecipients:toRecipients];
	// Attach an image to the email
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"];
	NSData *myData = [NSData dataWithContentsOfFile:path];
	[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"Icon.png"];
	// Fill out the email body text
	NSString *emailBody = [MultiLanguageUtil getLocalizatedStringForKey:STRING_EMAIL_CONTENT];
	[picker setMessageBody:emailBody isHTML:NO];
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}

@end

@implementation AppController
@synthesize window=window_, navController=navController_, director=director_;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	
								   depthFormat:0	
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];	
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	director_.wantsFullScreenLayout = YES;
	[director_ setDisplayStats:NO];
	[director_ setAnimationInterval:1.0/60];
	[director_ setView:glView];
	[director_ setProjection:kCCDirectorProjection2D];
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	navController_ = [[MyNavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	[director_ setDelegate:navController_];
	[window_ setRootViewController:navController_];
	[window_ makeKeyAndVisible];
    
    NSDictionary *cacheDefaults = [NSDictionary dictionaryWithContentsOfFile:
                                   [[NSBundle mainBundle] pathForResource:@"CacheDefaults" ofType:@"plist"]];
    [GCCache registerLeaderboards:[cacheDefaults objectForKey:@"Leaderboards"]];
    [GCCache registerAchievements:[cacheDefaults objectForKey:@"Achievements"]];
	return YES;
}

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];	
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

-(void) sendEmail {
    [self.navController displayComposerSheet];
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];
	
	[super dealloc];
}
@end
