//
//  QDRegisterViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/31.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDRegisterViewController.h"
#import "QMUIKit.h"
#import "QDUIHelper.h"
#import "NSString+Validate.h"
#import "MBProgressHUD+MP.h"
#import "LoginService.h"

@interface QDRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *registerBackView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) CALayer *oneLineLayer;
@property (nonatomic, strong) CALayer *twoLineLayer;

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property(nonatomic, strong) QMUIButton *registerBtn;

@end

@implementation QDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}

- (void)configUI {
    self.title = @"注册";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tap];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.tag = 101;
    self.emailTextField.tag = 102;
    self.passwordTextField.tag = 103;
    self.phoneTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.oneLineLayer = [CALayer qmui_separatorLayer];
    [self.registerBackView.layer addSublayer:self.oneLineLayer];
    self.oneLineLayer.frame = CGRectMake(0,51, SCREEN_WIDTH, PixelOne);
    self.twoLineLayer = [CALayer qmui_separatorLayer];
    [self.registerBackView.layer addSublayer:self.twoLineLayer];
    self.twoLineLayer.frame = CGRectMake(0,101, SCREEN_WIDTH, PixelOne);
    
    self.registerBtn = [QDUIHelper generateDarkFilledButton];
    self.registerBtn.enabled = NO;
    self.registerBtn.alpha=0.4;
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBtn.frame = CGRectMake(30, CGRectGetMaxY(self.registerBackView.frame) + 40, SCREEN_WIDTH - 60, 50);
    [self.registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 101) {
        NSInteger strLength = textField.text.length - range.length + string.length;
        
        return (strLength <= 11);
    }
    
    if (self.phoneTextField.text.length == 11 && self.emailTextField.text.length > 0
        && self.passwordTextField.text.length > 0) {
        self.registerBtn.enabled = YES;
        self.registerBtn.alpha = 1.0;
    } else {
        self.registerBtn.enabled = NO;
        self.registerBtn.alpha = 0.4;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 101) {
        self.phone = textField.text;
    } else if (textField.tag == 102){
        self.email = textField.text;
    } else {
        self.password = textField.text;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerClick:(id)sender {
    [self hiddenKeyBoard];
    if (self.phoneTextField.text.length != 11) {
        [MBProgressHUD showMessage:@"手机号格式不正确" ToView:self.view RemainTime:2.0];
        return;
    }
    if (![NSString IsEmailAdress:self.emailTextField.text ]) {
        [MBProgressHUD showMessage:@"邮箱格式不正确" ToView:self.view RemainTime:2.0];
        return;
    }
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    [[LoginService sharedInstance] registUser:self.phoneTextField.text password:self.passwordTextField.text email:self.emailTextField.text bmobBlock:^(BOOL isSuccessful, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        if (!error) {
            //注册成功
            [MBProgressHUD showMessage:@"注册成功" ToView:self.view RemainTime:2.0];
            [self performSelector:@selector(hideDelayed) withObject:nil afterDelay:2.0];
            
        } else {
            [MBProgressHUD showMessage:error.localizedDescription ToView:self.view RemainTime:2.0];
            return;
        }
    }];
    
}


- (void)hideDelayed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hiddenKeyBoard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
