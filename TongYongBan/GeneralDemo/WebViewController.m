//
//  WebViewController.m
//  GeneralDemo
//
//  Created by frank on 2017/8/23.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface WebViewController ()

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) UIButton *closeBtn;//关闭按钮

@property (nonatomic,strong) NJKWebViewProgressView *progressView;
@property (nonatomic,strong) NJKWebViewProgress *progressProxy;

@end

@implementation WebViewController


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LLCreatJSContex" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectedRElationToWeb" object:nil];
}
-(void)creatJSContex:(NSNotification*)noti
{
    NSLog(@"%@",noti);
    //注意以下代码如果不在主线程调用会发生闪退。 webview所有的UI操作都要在主线程
    dispatch_async( dispatch_get_main_queue(), ^{
        
        JSContext *jsContext = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        jsContext[@"CallClient"] = self;
        jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
            context.exception = exceptionValue;
            NSLog(@"异常信息：%@", exceptionValue);
        };
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(creatJSContex:) name:@"LLCreatJSContex" object:nil];
    
    self.view.backgroundColor = kColorBackground;
    [self createCustomNavBar];
    //添加关闭按钮
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, self.customNavigationView.height_ - kNavigationHeight, 40, kNavigationHeight)];
    _closeBtn.adjustsImageWhenHighlighted = NO;
    _closeBtn.titleLabel.font = kFontMiddle;
    _closeBtn.exclusiveTouch = YES;
    [_closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(onCloseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationView addSubview:_closeBtn];
    //调整frame
    self.titleLb.frame = CGRectMake(0, 0,self.view.width_ - 200, kNavigationHeight);
    self.titleLb.center = CGPointMake(self.customNavigationView.center.x, self.customNavigationView.height_ - kNavigationHeight / 2);
    
    if (!self.webView) {
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.customNavigationView.maxY, SCREEN_WIDTH, SCREEN_HEIGHT-self.customNavigationView.maxY)];
    }
    self.webView.backgroundColor = [UIColor whiteColor];
//    [self.webView loadRequest:self.urlStr];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    //添加进度条
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    CGFloat progressBarHeight = 4.f;
    CGRect barFrame = CGRectMake(0, self.customNavigationView.maxY, CGRectGetWidth(self.view.frame), progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.progress = 0.f;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.view addSubview:_progressView];
    });
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_progressView removeFromSuperview];
    });
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
