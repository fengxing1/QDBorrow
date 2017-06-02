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

@interface QDForumViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *urlStr;

@end

@implementation QDForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -40, SCREEN_WIDTH, SCREEN_HEIGHT + 40)];
    self.title = @"论坛";
    [self fetchData];
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
    
//    [self loadURL:[NSURL URLWithString:@"http://114.215.210.61:10080/bbs/portal.php?mobile=2"]];
    
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
