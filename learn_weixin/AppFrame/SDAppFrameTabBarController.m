//
//  SDAppFrameTabBarController.m
//  learn_weixin
//
//  Created by 蔡佳明 on 2020/12/28.
//

#import "SDAppFrameTabBarController.h"

#import "SDBaseNavigationController.h"

#import "SDHomeTableViewController.h"

#import "GlobalDefines.h"

#define KClassKey @"rootVCClassString"
#define KTitleKey @"title"
#define KImgKey @"imageName"
#define KSelImgKey @"selectedImageName"

@interface SDAppFrameTabBarController ()

@end

@implementation SDAppFrameTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *childItemsArray = @[
        @{KClassKey  : @"SDHomeTableViewController",
          KTitleKey  : @"微信",
          KImgKey    : @"tabbar_mainframe",
          KSelImgKey : @"tabbar_mainframeHL"},

        @{KClassKey  : @"SDContactsTableViewController",
          KTitleKey  : @"通讯录",
          KImgKey    : @"tabbar_contacts",
          KSelImgKey : @"tabbar_contactsHL"},

        @{KClassKey  : @"SDDiscoverTableViewController",
          KTitleKey  : @"发现",
          KImgKey    : @"tabbar_discover",
          KSelImgKey : @"tabbar_discoverHL"},

        @{KClassKey  : @"SDMeTableViewController",
          KTitleKey  : @"我",
          KImgKey    : @"tabbar_me",
          KSelImgKey : @"tabbar_meHL"} ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[KClassKey]) new];
        vc.title = dict[KTitleKey];
        SDBaseNavigationController *nav = [[SDBaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[KTitleKey];
        item.image = [UIImage imageNamed:dict[KImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[KSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: Global_tintColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
