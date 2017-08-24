//
//  MyNavigationController.m
//  CloudInformation
//
//  Created by frank on 2017/3/23.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "MyNavigationController.h"
#import "AppDelegate.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.view endEditing:YES];
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate
{
    //    return NO;
    return [[self.viewControllers lastObject] shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //    return UIInterfaceOrientationMaskPortrait;
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
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
