//
//  QDRegisterViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/31.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDRegisterViewController.h"

@interface QDRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

@end

@implementation QDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}

- (void)configUI {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tap];
    self.registerBtn.hidden = YES;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.tag = 101;
    self.emailTextField.tag = 102;
    self.passwordTextField.tag = 103;
    self.phoneTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 101) {
        NSInteger strLength = textField.text.length - range.length + string.length;
        
        return (strLength <= 11);
    }
    
    if (self.phoneTextField.text.length == 0 || self.phoneTextField.text.length == 0) {
        self.phoneTextField.hidden = YES;
    } else {
        self.registerBtn.hidden = NO;
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
