//
//  QDSettingViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDSettingViewController.h"
#import "QDAboutViewController.h"
#import "QDUIHelper.h"
#import <BmobSDK/Bmob.h>
#import "UIAlertView+Block.h"
#import "QDUserManager.h"


@interface QDSettingViewController ()
@property(nonatomic, strong) QMUIButton *longinBtn;
@property (nonatomic, strong) BmobUser *user;

@end

@implementation QDSettingViewController

- (void)initDataSource {
    self.title = @"设置";
    [super initDataSource];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"关于我们",@"商务合作",@"官方客服群", @"官方邮箱",nil];
    self.dataSource = array;
    self.user = [BmobUser currentUser];
    
}

- (void)didSelectCellWithTitle:(NSString *)title {
    if ([title isEqualToString:@"关于我们"]) {
        QDAboutViewController *about = [[QDAboutViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    } else if ([title isEqualToString:@"商务合作"]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                //拨打电话
                NSMutableString *str3=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"13040791093"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str3]];
            }
        } title:@"商务合作" message:@"电话：130-4079-1093" cancelButtonName:@"取消" otherButtonTitles:@"拨打电话", nil];
        
    } else if ([title isEqualToString:@"官方客服群"]) {
        [UIAlertView alertWithCallBackBlock:nil title:@"QQ群" message:@"QQ群：645445217" cancelButtonName:@"确定" otherButtonTitles:nil];
    } else {
        [UIAlertView alertWithCallBackBlock:nil title:@"官方邮箱" message:@"邮箱：lucann@126.com" cancelButtonName:@"确定" otherButtonTitles:nil];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI {
    if (self.user) {
        [self configFooterView];
    }
}

- (void)configFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.tableView.tableFooterView = view;
    self.longinBtn = [QDUIHelper generateDarkFilledButton];
    [self.longinBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    self.longinBtn.frame = CGRectMake(30,25, SCREEN_WIDTH - 60, 50);
    [self.longinBtn addTarget:self action:@selector(exitLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.longinBtn];
}

- (void)exitLoginClick {
    [[QDUserManager sharedInstance] exitUser];
//    [BmobUser logout];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshData" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
