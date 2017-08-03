//
//  QDJumpViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/21.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDJumpViewController.h"
#import "Macros.h"
#import "AppDelegate.h"
#import "QDJumpService.h"
#import "UIAlertView+Block.h"
#import "introductoryPagesHelper.h"

@interface QDJumpViewController ()

@end

@implementation QDJumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //引导页面加载
    [self setupIntroductoryPage];
}

#pragma mark 引导页
-(void)setupIntroductoryPage
{
    if (BBUserDefault.isNoFirstLaunch)
    {
        [self configRealHomeViewController];
        return;
    }
    BBUserDefault.isNoFirstLaunch=YES;
    NSArray *images=@[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3"];
    [introductoryPagesHelper showIntroductoryPageView:images];
    [introductoryPagesHelper shareInstance].clickLastImageAction = ^{
        [self configRealHomeViewController];
    };
}

- (void)configRealHomeViewController {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    [[QDJumpService sharedInstance] changeTabbarWithBlock:^(BmobObject *object, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        if (!error) {
            if (object && [object objectForKey:@"showNeedTabbar"]) {
                [self showOtherLoanView];
            } else {
                [self showMyLoanView];
            }
        } else {
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                if (buttonIndex) {
                    [self configRealHomeViewController];
                }
            } title:@"提示" message:@"网络还没被允许，请确认！" cancelButtonName:@"取消" otherButtonTitles:@"重新刷新", nil];
        }
    }];
}


- (void)showMyLoanView {
    [((AppDelegate*) AppDelegateInstance) createTabBarController];
}

- (void)showOtherLoanView {
    [((AppDelegate*) AppDelegateInstance) createMyLoanTabBarController];
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
