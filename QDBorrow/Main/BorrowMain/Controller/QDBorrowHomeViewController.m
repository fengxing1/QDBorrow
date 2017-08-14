//
//  QDBorrowHomeViewController.m
//  QDBorrow
//
//  Created by larou on 2017/7/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDBorrowHomeViewController.h"
#import "QDHomeModel.h"
#import "QDHomeService.h"
#import "UIAlertView+Block.h"
#import "QDHomeBannerModel.h"

@interface QDBorrowHomeViewController ()
@property(nonatomic, strong) NSMutableArray *homeBannerArray;

@end

@implementation QDBorrowHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    [self confirmUI];
    [self configData];
}

- (void)configData {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    [[QDHomeService sharedInstance] homeBannerDataWithBlock:^(NSArray *array, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        if (!error) {
            for (BmobObject *bmBanner in array) {
                QDHomeBannerModel *bannerModel = [[QDHomeBannerModel alloc] initWithBannerObject:bmBanner];
                [self.homeBannerArray addObject:bannerModel];
            }
        } else {
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                if (buttonIndex) {
                    [self configData];
                }
            } title:@"提示" message:@"网络出错，请刷新重试！" cancelButtonName:@"取消" otherButtonTitles:@"重新刷新", nil];
        }
    }];

}

- (void)confirmUI {
    self.title = @"首页";
    self.
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
