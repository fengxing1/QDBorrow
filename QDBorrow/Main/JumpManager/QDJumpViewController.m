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

@interface QDJumpViewController ()

@end

@implementation QDJumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configRealHomeViewController];
    
}


- (void)configRealHomeViewController {
    [[QDJumpService sharedInstance] changeTabbarWithBlock:^(BmobObject *object, NSError *error) {
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
