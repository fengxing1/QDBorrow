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

@interface QDLoginOrRegisterViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UIButton *longinBtn;
@property (nonatomic, strong) NSString *phoneStr;
@property (nonatomic, strong) NSString *passwordStr;
@end

@implementation QDLoginOrRegisterViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    
}

- (void)configUI {
    self.passwordLabel.secureTextEntry = YES;
    self.phoneLabel.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneLabel.tag = 101;
    self.passwordLabel.tag = 102;
    self.phoneLabel.delegate = self;
    self.passwordLabel.delegate = self;
    self.longinBtn.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 101) {
        NSInteger strLength = textField.text.length - range.length + string.length;
        
        return (strLength <= 11);
    }
    
    if (self.phoneLabel.text.length == 0 || self.passwordLabel.text.length == 0) {
        self.longinBtn.hidden = YES;
    } else {
        self.longinBtn.hidden = NO;
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
    [[LoginService sharedInstance] loginUser:self.phoneStr andPassword:self.passwordStr block:^(AVUser * _Nullable user, NSError * _Nullable error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            //登陆成功
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshData" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showMessage:error.localizedDescription ToView:self.view RemainTime:2.0];
        }
    }];
    
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
