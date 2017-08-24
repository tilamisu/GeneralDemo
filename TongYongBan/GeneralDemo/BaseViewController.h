//
//  BaseViewController.h
//  CloudInformation
//
//  Created by frank on 2017/3/23.
//  Copyright © 2017年 frank. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TopBarButtonLeft = 1,
    TopBarButtonRight = 2,
} NavBarButton;

typedef NS_ENUM(NSInteger, NavigationBarViewType) {
    NavigationBarTitleViewType,          //文字类型
    NavigationBarLoadingViewType,        //菊花转动类型
};

@interface BaseViewController : UIViewController

@property (nonatomic, assign) NavigationBarViewType navigationBarViewType;

@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, assign) BOOL shouldLimitTitleLabelWidth;
@property (nonatomic, strong) UIView *barLineView;
@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) UIView *customNavigationView;

- (void)createCustomNavBar;

- (void)onClickBtn:(UIButton *)sender;

- (void)initNavTitle;//设置导航栏

@end
