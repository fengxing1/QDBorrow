//
//  QDForumViewController.m
//  QDBorrow
//
//  Created by larou on 2017/6/2.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDForumViewController.h"
#import "QMUIKit.h"
#import "UIColor+QMUI.h"
#import "MBProgressHUD+MP.h"
#import "AVQuery.h"
#import "UIColor+Hex.h"
#import "QMUIKit.h"

@interface QDForumViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *urlStr;

@end

@implementation QDForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.title = @"论坛";
    [self fetchData];
}

- (void)viewDidAppear:(BOOL)animated {
    [self setStatusBarBackgroundColor:UIColorMake(36, 121, 232)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


- (void)fetchData {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    AVQuery *queryBanner = [AVQuery queryWithClassName:@"QDForum"];
    [queryBanner getFirstObjectInBackgroundWithBlock:^(AVObject * _Nullable object, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view];
        self.urlStr = [object objectForKey:@"forumurl"];
        [self loadWebView];
    }];
    
}

- (void)loadWebView {
    NSURL* url = [NSURL URLWithString:self.urlStr];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载

}



- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view];
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
