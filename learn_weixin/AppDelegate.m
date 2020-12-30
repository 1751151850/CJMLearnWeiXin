//
//  AppDelegate.m
//  learn_weixin
//
//  Created by 蔡佳明 on 2020/12/28.
//

#import "AppDelegate.h"
#import "SDAppFrameTabBarController.h"
#import "SDHomeTableViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [SDAppFrameTabBarController new];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setupNavBar];
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}




//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tabVC.selectedViewController;
    UIViewController *childVC = [nav.childViewControllers lastObject];
    if([childVC isKindOfClass:[SDHomeTableViewController class]]) {
        SDHomeTableViewController *homeVC = (SDHomeTableViewController *)childVC;
        [homeVC startTableViewAnimationWithHidden:NO];
    }
}

- (void)setupNavBar {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UINavigationBar *bar = [UINavigationBar appearance];
    CGFloat rgb = 0.1;
    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

@end
