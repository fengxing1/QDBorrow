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
#import "QDLoginReqeust.h"
#import "QDUserManager.h"


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
    __weak typeof(self) weakSelf = self;
    [introductoryPagesHelper shareInstance].clickLastImageAction = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        //如果用户已经登陆了，再做一次静默登陆
        [strongSelf showMyLoanView];;
    };
}

- (void)configRealHomeViewController {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    QDJumpRequest *jumpRequest = [[QDJumpRequest alloc] init];
    [jumpRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([[request.responseObject valueForKey:@"code"] integerValue] == 1000) {
            BOOL bJumpBorrow = [[request.responseObject valueForKey:@"data"] boolValue];
            NSString *languageStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
            BOOL bLanguage = [languageStr containsString:@"zh-"];
            if (bJumpBorrow && bLanguage) {
                //引导页面加载
                    [self showOtherLoanView];
                //                [self setupIntroductoryPage];
            }  else {
                [self showOtherLoanView];
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
    QDUser *user = [QDUserManager sharedInstance].getUser;
    if(user.userName && user.userName.length) {
        QDLoginReqeust *loginRequest = [[QDLoginReqeust alloc] initWithUsername:user.userName password:user.password];
        [loginRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            if ([[request.responseObject valueForKey:@"code"] integerValue] == 1000) {
                //保存用户信息
                NSString *sessionId = [request.responseJSONObject valueForKey:@"data"];
                QDUser *user = [QDUserManager sharedInstance].getUser;
                user.sessionId = sessionId;
                [[QDUserManager sharedInstance] saveUser:user];
                [((AppDelegate*) AppDelegateInstance) createMyLoanTabBarController];
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [[QDUserManager sharedInstance] exitUser];
            [((AppDelegate*) AppDelegateInstance) createMyLoanTabBarController];
        }];
    } else {
        [((AppDelegate*) AppDelegateInstance) createMyLoanTabBarController];
    }
    
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
