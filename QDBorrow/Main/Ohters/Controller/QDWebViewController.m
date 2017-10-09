//
//  QDWebViewController.m
//  QDBorrow
//
//  Created by larou on 2017/5/9.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "QDWebViewController.h"
#import "QMUICommonDefines.h"

@implementation QDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.translatesAutoresizingMaskIntoConstraints = YES;
    self.webView.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if (!self.isLuntan) {
        self.webView.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    }
    self.webView.scrollView.bounces = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}



@end
