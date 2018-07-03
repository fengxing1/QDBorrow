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
#import "UIColor+Hex.h"
#import "QDRegisterRequest.h"
#import "QDSendMessageRequest.h"
#import "QDUserManager.h"

@interface QDRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *registerBackView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) CALayer *oneLineLayer;
@property (nonatomic, strong) CALayer *twoLineLayer;

@property (nonatomic, strong) __block NSString *phone;
@property (nonatomic, strong) __block NSString *validateNum;
@property (nonatomic, strong) __block NSString *password;
@property(nonatomic, strong) QMUIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageBtn;

@property(nonatomic,strong)dispatch_source_t timer;



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
    
    self.sendMessageBtn.layer.borderWidth = 1;
    self.sendMessageBtn.layer.borderColor = UIColorSeparator.CGColor;
    
    self.registerBtn = [QDUIHelper generateDarkFilledButton];
    self.registerBtn.enabled = NO;
    self.registerBtn.alpha=0.4;
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBtn.frame = CGRectMake(30, CGRectGetMaxY(self.registerBackView.frame) + 40, SCREEN_WIDTH - 60, 50);
    [self.registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
}

// 倒计时
-(void)openCountdown{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭

            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.sendMessageBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.sendMessageBtn setTitleColor:[UIColor colorWithHeX:0xE12B24] forState:UIControlStateNormal];
                self.sendMessageBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.sendMessageBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.sendMessageBtn setTitleColor:[UIColor colorWithHeX:0xE12B24] forState:UIControlStateNormal];
                self.sendMessageBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
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
        self.validateNum = textField.text;
    } else {
        self.password = textField.text;
    }
}

- (IBAction)sendMessageClick:(id)sender {
    
    if (self.phoneTextField.text.length != 11) {
        [MBProgressHUD showMessage:@"手机号格式不正确" ToView:self.view RemainTime:2.0];
        return;
    }
    QDSendMessageRequest *request = [[QDSendMessageRequest alloc] initWithPhoneNum:self.phoneTextField.text];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self openCountdown];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage:request.error.localizedDescription ToView:self.view RemainTime:2.0];
    }];
    
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
    if (!(self.emailTextField.text && self.emailTextField.text.length == 6)) {
        [MBProgressHUD showMessage:@"验证码必须六位" ToView:self.view RemainTime:2.0];
        return;
    }
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    QDRegisterRequest *request = [[QDRegisterRequest alloc] initWithUsername:self.phoneTextField.text password:self.passwordTextField.text validate:self.emailTextField.text];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([[request.responseObject valueForKey:@"code"] integerValue] == 1000) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessage:@"注册成功" ToView:self.view RemainTime:2.0];
            [self performSelector:@selector(hideDelayed) withObject:nil afterDelay:2.0];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessage:[request.responseJSONObject valueForKey:@"desc"] ToView:self.view RemainTime:2.0];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessage:request.error.localizedDescription ToView:self.view RemainTime:2.0];
    }];
//    [[LoginService sharedInstance] registUser:self.phoneTextField.text password:self.passwordTextField.text email:self.emailTextField.text bmobBlock:^(BOOL isSuccessful, NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view];
//        if (!error) {
//            //注册成功
//            [MBProgressHUD showMessage:@"注册成功" ToView:self.view RemainTime:2.0];
//            [self performSelector:@selector(hideDelayed) withObject:nil afterDelay:2.0];
//
//        } else {
//            [MBProgressHUD showMessage:error.localizedDescription ToView:self.view RemainTime:2.0];
//            return;
//        }
//    }];
    
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
