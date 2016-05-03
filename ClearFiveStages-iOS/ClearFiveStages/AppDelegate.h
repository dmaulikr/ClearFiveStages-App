#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import <MessageUI/MessageUI.h>

@interface MyNavigationController : UINavigationController <CCDirectorDelegate, MFMailComposeViewControllerDelegate> {}
@end


@interface AppController : NSObject <UIApplicationDelegate> {
	UIWindow *window_;
	MyNavigationController *navController_;
	CCDirectorIOS	*director_;							// weak ref
}
-(void) sendEmail;
@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
