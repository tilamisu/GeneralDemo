//
//  CallListViewController.m
//  GeneralDemo
//
//  Created by frank on 2017/8/23.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "CallListViewController.h"

@interface CallListViewController ()

@end

@implementation CallListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorBackground;
    [self createCustomNavBar];
    self.titleStr = @"发布";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
