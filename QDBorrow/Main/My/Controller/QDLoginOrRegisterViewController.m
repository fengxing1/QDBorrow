//
//  QDLoginOrRegisterViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/31.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDLoginOrRegisterViewController.h"
#import "MBProgressHUD+MP.h"
#import "LoginService.h"
#import "QDRegisterViewController.h"
#import "QMUIKit.h"
#import "QDUIHelper.h"

@interface QDLoginOrRegisterViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginBackView;
@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
//@property (weak, nonatomic) IBOutlet UIButton *longinBtn;
@property (nonatomic, strong) NSString *phoneStr;
@property (nonatomic, strong) NSString *passwordStr;
@property(nonatomic, strong) QMUIButton *longinBtn;
@property (nonatomic, strong) CALayer *oneLineLayer;

@end

@implementation QDLoginOrRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    
}

- (void)configUI {
    self.title = @"登陆";
    self.passwordLabel.secureTextEntry = YES;
    self.phoneLabel.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneLabel.tag = 101;
    self.passwordLabel.tag = 102;
    self.phoneLabel.delegate = self;
    self.passwordLabel.delegate = self;
    self.longinBtn = [QDUIHelper generateDarkFilledButton];
    self.longinBtn.enabled = NO;
    self.longinBtn.alpha=0.4;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tap];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerClick)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    // 边框按钮
    [self.longinBtn setTitle:@"登陆" forState:UIControlStateNormal];
    self.longinBtn.frame = CGRectMake(30, CGRectGetMaxY(self.loginBackView.frame) + 40, SCREEN_WIDTH - 60, 50);
    [self.longinBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.longinBtn];
    self.oneLineLayer = [CALayer qmui_separatorLayer];
    [self.loginBackView.layer addSublayer:self.oneLineLayer];
    self.oneLineLayer.frame = CGRectMake(0,51, SCREEN_WIDTH, PixelOne);
}


- (void)registerClick {
    QDRegisterViewController *registerVC = [[QDRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 101) {
        NSInteger strLength = textField.text.length - range.length + string.length;
        
        return (strLength <= 11);
    }
    
    if (self.phoneLabel.text.length > 0 || self.passwordLabel.text.length > 0) {
        self.longinBtn.enabled = YES;
        self.longinBtn.alpha = 1.0;
    } else {
        self.longinBtn.enabled = NO;
        self.longinBtn.alpha = 0.4;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 101) {
        self.phoneStr = textField.text;
    } else {
        self.passwordStr = textField.text;
    }
}

- (IBAction)loginClick:(id)sender {
    [self hiddenKeyBoard];
    if (self.phoneLabel.text.length == 0) {
        [MBProgressHUD showMessage:@"手机号不能为空" ToView:self.view RemainTime:2.0];
        return;
    }
    if (self.passwordLabel.text.length == 0) {
        [MBProgressHUD showMessage:@"密码不能为空" ToView:self.view RemainTime:2.0];
        return;
    }
    if (self.phoneLabel.text.length != 11) {
        [MBProgressHUD showMessage:@"手机号格式不正确" ToView:self.view RemainTime:2.0];
        return;
    }
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    [[LoginService sharedInstance] loginUser:self.phoneStr andPassword:self.passwordStr bmobBlock:^(BmobUser *user, NSError *error) {
        if (!error) {
            //登陆成功
            [MBProgressHUD showMessage:@"登陆成功" ToView:self.view RemainTime:2.0];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshData" object:nil];
            [self performSelector:@selector(hideDelayed) withObject:nil afterDelay:2.0];
        } else {
            [MBProgressHUD showMessage:error.localizedDescription ToView:self.view RemainTime:2.0];
        }
    }];
    
}

- (void)hideDelayed {
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)hiddenKeyBoard {
      [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
