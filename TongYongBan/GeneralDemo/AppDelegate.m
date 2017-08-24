//
//  AppDelegate.m
//  GeneralDemo
//
//  Created by frank on 2017/8/23.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "AppDelegate.h"
#import "ApplyViewController.h"
#import "ApplyMessageViewController.h"
#import "GroupViewController.h"
#import "CallListViewController.h"
#import "MyViewController.h"
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate () <RDVTabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    [self createTabbarVC];
    
    return YES;
}

//初始化tabbar视图
- (void)createTabbarVC
{
    //应用
    ApplyViewController *applyVC = [[ApplyViewController alloc]init];
    //消息
    ApplyMessageViewController *messageVC = [[ApplyMessageViewController alloc]init];
    //关系
    GroupViewController *GroupVC = [[GroupViewController alloc]init];
    //我的
    MyViewController *myVC = [[MyViewController alloc]init];
    
    CallListViewController *callList = [[CallListViewController alloc]init];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[GroupVC, messageVC,callList,applyVC,
                                           myVC]];
    self.viewController = tabBarController;
    
    
    
    [self customizeTabBarForController:tabBarController];
    
    tabBarController.delegate = self;
    
    MyNavigationController *Nav = [[MyNavigationController alloc]initWithRootViewController:tabBarController];
    
    Nav.navigationBarHidden = YES;
    
    self.window.rootViewController = Nav;
    
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSArray *tabBarItemImages;
    tabBarItemImages = @[@{@"title":@"关系",@"img":@"tab_relation0"}, @{@"title":@"消息",@"img":@"tab_iv2"},@{@"title":@"发布",@"img":@""},@{@"title":@"应用",@"img":@"tab_business0"},@{@"title":@"我的",@"img":@"tab_iv4"}];
    NSInteger index = 0;
    [tabBarController.tabBar setHeight:kTabBarHeight];
    tabBarController.tabBar.backgroundView.backgroundColor = [UIColor whiteColor];
    [tabBarController.tabBar addSubview:[[UIView alloc] initLineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)]];
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        NSDictionary *dic = [tabBarItemImages objectAtIndex:index];
        [item setTitle:dic[@"title"]];
        
//        [item setBackgroundSelectedImage:[UIImage clearImage:YES] withUnselectedImage:[UIImage clearImage:NO]];
        
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            item.unselectedTitleAttributes = @{
                                               NSFontAttributeName: [UIFont systemFontOfSize:12],
                                               NSForegroundColorAttributeName: kColorItem,
                                               };
            item.selectedTitleAttributes = @{
                                             NSFontAttributeName: [UIFont systemFontOfSize:12],
                                             NSForegroundColorAttributeName: AppMainColor,
                                             };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            item.unselectedTitleAttributes = @{
                                               UITextAttributeFont: [UIFont systemFontOfSize:12],
                                               UITextAttributeTextColor: kColorItem,
                                               };
            item.selectedTitleAttributes = @{
                                             UITextAttributeFont: [UIFont systemFontOfSize:12],
                                             UITextAttributeTextColor: kColorType,
                                             };
#endif
        }
        [item setBadgeBackgroundColor:RGBCOLOR(255, 0, 0)];
        item.badgePositionAdjustment = UIOffsetMake(-4, 3);
        //        if ([SDVersion deviceSize] == Screen4Dot7inch ||
        //            [SDVersion deviceSize] == Screen5Dot5inch){
        //            [item setBadgeTextFont:[UIFont systemFontOfSize:4.5f]];
        //        }else{
        //            [ictem setBadgeTextFont:[UIFont systemFontOfSize:3.f]];
        //        }
        [item setBadgeTextFont:[UIFont systemFontOfSize:3.f]];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",dic[@"img"]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dic[@"img"]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
        
        [item setBadgeValue:@""];
        [item layoutIfNeeded];
    }
}

- (void)registNotification
{
    
    if (IOS10_OR_LATER) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }else if(IOS8_OR_AFTER){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString* str=[NSString stringWithFormat:@"%@",deviceToken];
    NSCharacterSet* set=[NSCharacterSet characterSetWithCharactersInString:@"<>"];
    str=[str stringByTrimmingCharactersInSet:set];
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"token:%@",str);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
