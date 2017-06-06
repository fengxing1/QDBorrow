//
//  QDMessageViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDMessageViewController.h"
#import "UIView+EaseBlankPage.h"
#import "MBProgressHUD+MP.h"

@interface QDMessageViewController ()

@end

@implementation QDMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的消息";
    [self configUI];
}

- (void)configUI {
    [self refreshView];
}

- (void)refreshView {
    [MBProgressHUD showInfo:@"加载中..." ToView:self.view];
    [self performSelector:@selector(showBlackView) withObject:nil afterDelay:2.0];
}

- (void)showBlackView {
    [MBProgressHUD hideHUD];
    __weak typeof(self)weakSelf = self;
    [self.view configBlankPage:EaseBlankPageTypeView hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
        [weakSelf refreshView];
        
    }];
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
