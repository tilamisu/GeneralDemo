//
//  BaseViewController.m
//  CloudInformation
//
//  Created by frank on 2017/3/23.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_interactivePopDisabled = NO;
}

- (void)initNavTitle
{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"image01"] forBarMetrics:UIBarMetricsDefault];
//

}

- (void)createCustomNavBar
{
    CGFloat navHeight = IOS7_OR_LATER?kNavigationHeight + kStatusBarHeight:kNavigationHeight;
    //    self.customNavigationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, navHeight)];
    //    _customNavigationView.userInteractionEnabled = YES;
    //    _customNavigationView.contentMode = UIViewContentModeScaleAspectFill;
    //    _customNavigationView.clipsToBounds = YES;
    //    _customNavigationView.image = [UIImage imageNamed:@"navBar"];
    //    [self.view addSubview:_customNavigationView];
    self.customNavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeight)];
    _customNavigationView.backgroundColor = AppMainColor;
    _customNavigationView.userInteractionEnabled = YES;
    //    _customNavigationView.clipsToBounds = YES;
    [self.view addSubview:_customNavigationView];
    
    CGFloat segmentWidth = 100;
    
    // 左按钮
    _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, _customNavigationView.height_ - kNavigationHeight, segmentWidth, kNavigationHeight)];
//    _btnLeft.showBackArrow = YES;
    _btnLeft.hidden = YES;
    _btnLeft.tag = TopBarButtonLeft;
    _btnLeft.adjustsImageWhenHighlighted = NO;
    _btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnLeft.titleLabel.font = kFontMiddle;
    _btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, kEdgeInsetsLeft - 4, 0, 0);
    _btnLeft.imageEdgeInsets = UIEdgeInsetsMake(0, kEdgeInsetsLeft, 0, 0);
    _btnLeft.exclusiveTouch = YES;
    _btnLeft.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_btnLeft setTitle:@"返回" forState:UIControlStateNormal];
    [_btnLeft setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
    [_btnLeft addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnLeft setTitleColor:kColorNavigationTitleDisable forState:UIControlStateDisabled];
    // 右按钮
    _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(_customNavigationView.width_ - segmentWidth - 10, _customNavigationView.height_ - kNavigationHeight, segmentWidth + 10, kNavigationHeight)];
//    _btnRight.showBackArrow = NO;
    _btnRight.hidden = YES;
    _btnRight.tag = TopBarButtonRight;
    _btnRight.adjustsImageWhenHighlighted = NO;
    _btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _btnRight.titleLabel.font = kFontMiddle;
    _btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kEdgeInsetsLeft);
    _btnRight.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kEdgeInsetsLeft);
    _btnRight.exclusiveTouch = YES;
    [_btnRight addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btnRight setTitleColor:kColorNavigationTitle forState:UIControlStateNormal];
    [_btnRight setTitleColor:kColorNavigationTitleDisable forState:UIControlStateDisabled];
    
    _titleLb = [[UILabel alloc] initClearColorWithFrame:CGRectMake(0, 0, _customNavigationView.width_ - _btnLeft.width_ - _btnRight.width_, kNavigationHeight)];
    _titleLb.frame = CGRectMake(0, 0,_shouldLimitTitleLabelWidth ? _customNavigationView.width_ - _btnLeft.width_ - _btnRight.width_ : _customNavigationView.width_, kNavigationHeight);
    _titleLb.center = CGPointMake(_customNavigationView.center.x, _customNavigationView.height_ - kNavigationHeight / 2);
    _titleLb.font = kFontSuper_b;
    _titleLb.textColor = [UIColor whiteColor];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [_customNavigationView addSubview:_titleLb];
    [_customNavigationView addSubview:_btnLeft];
    [_customNavigationView addSubview:_btnRight];
    //添加分割线
//    self.barLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _customNavigationView.maxY - 0.5, _customNavigationView.width_, 0.5)];
    
//    _barLineView.backgroundColor = RGBCOLOR(0xd8, 0xd8, 0xd8);
//    [_customNavigationView addSubview:_barLineView];
    //设置内容
    _titleLb.text = _titleStr;
}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    _titleLb.text = _titleStr;
//    if (_navigationBarViewType == NavigationBarLoadingViewType) {
//        //设置位置
//        CGFloat width = [UILabel widthForLabelWithText:_titleStr maxHeight:kNavigationHeight font:kFontSuper_b];
//        self.loadingIndicatorView.center = CGPointMake(_customNavigationView.width_ / 2 - width / 2 - 20, _customNavigationView.height_ - kNavigationHeight / 2);
//    }
}

- (void)onClickBtn:(UIButton *)sender
{
    if (sender.tag == TopBarButtonLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
