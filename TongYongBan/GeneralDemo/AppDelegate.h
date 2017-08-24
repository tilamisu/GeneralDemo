//
//  AppDelegate.h
//  GeneralDemo
//
//  Created by frank on 2017/8/23.
//  Copyright © 2017年 frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) RDVTabBarController *viewController;

- (void)createTabbarVC;

@end

