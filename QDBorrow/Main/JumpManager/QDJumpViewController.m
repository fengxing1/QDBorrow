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
#import "UIAlertView+Block.h"
#import "introductoryPagesHelper.h"
#import "QDJumpRequest.h"
#import "Masonry.h"

@interface QDJumpViewController ()
@property (nonatomic, strong) UILabel *warningLabel;

@end

@implementation QDJumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configRealHomeViewController];
}

- (void)setupUI {
    [self.view addSubview:self.warningLabel];
    self.warningLabel.hidden = YES;
    [self.warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [button addTarget:self action:@selector(tapEvent:) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)tapEvent:(id *)sender {
    [self configRealHomeViewController];
}




#pragma mark 引导页
-(void)setupIntroductoryPage
{
    if (BBUserDefault.isNoFirstLaunch)
    {
        [self showMyLoanView];
        return;
    }
    BBUserDefault.isNoFirstLaunch=YES;
    NSArray *images=@[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3"];
    [introductoryPagesHelper showIntroductoryPageView:images];
    [introductoryPagesHelper shareInstance].clickLastImageAction = ^{
        [self showMyLoanView];;
    };
}

- (void)configRealHomeViewController {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    QDJumpRequest *jumpRequest = [[QDJumpRequest alloc] init];
    [jumpRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([[request.responseObject valueForKey:@"code"] integerValue] == 1000) {
            BOOL bJumpBorrow = [[request.responseObject valueForKey:@"data"] boolValue];
            if (bJumpBorrow) {
                //引导页面加载
                [self setupIntroductoryPage];
            }  else {
                [self setupIntroductoryPage];
//                [self showOtherLoanView];
            }
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            self.warningLabel.hidden = NO;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view];
        self.warningLabel.hidden = NO;
    }];
}


- (void)showMyLoanView {
    [((AppDelegate*) AppDelegateInstance) createMyLoanTabBarController];
}

- (void)showOtherLoanView {
    [((AppDelegate*) AppDelegateInstance) createTabBarController];
}

- (UILabel *)warningLabel {
    if (!_warningLabel) {
        _warningLabel = [[UILabel alloc] init];
        _warningLabel.text = @"网络还没有被允许，请去网络里重新设置。然后点击该页面刷新！";
        _warningLabel.font = [UIFont systemFontOfSize:15];
        _warningLabel.numberOfLines = 0;
        _warningLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _warningLabel;
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
