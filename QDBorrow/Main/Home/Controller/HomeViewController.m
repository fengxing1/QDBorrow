//
//  HomeViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/6.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginService.h"
#import "QMUIKit.h"
#import "QDCommonTableViewController.h"
@interface HomeViewController ()

@property(nonatomic, strong) QMUIButton *registButton;
@property(nonatomic, strong) QMUIButton *loginButton;
@property(nonatomic, strong) QMUIButton *statusButton;

@property (nonatomic, strong) QDCommonTableViewController *tableView;


@end



@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self confirmUI];
    
}

- (void)confirmUI {
    //
//    self.registButton = [[QMUIButton alloc] init];
//    self.registButton.titleLabel.font = UIFontMake(15);
//    self.registButton.adjustsTitleTintColorAutomatically = YES;
//    [self.registButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.registButton setTitle:@"注册" forState:UIControlStateNormal];
//    self.registButton.frame = CGRectMake(0, 100, 200, 60);
//    [self.registButton addTarget:self action:@selector(registerUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.registButton];
//    
//    self.loginButton = [[QMUIButton alloc] init];
//    self.loginButton.titleLabel.font = UIFontMake(15);
//    self.loginButton.adjustsTitleTintColorAutomatically = YES;
//    [self.loginButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.loginButton setTitle:@"登陆" forState:UIControlStateNormal];
//    self.loginButton.frame = CGRectMake(0, 170, 200, 60);
//    [self.loginButton addTarget:self action:@selector(loginUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.loginButton];
//    
//    self.statusButton = [[QMUIButton alloc] init];
//    self.statusButton.titleLabel.font = UIFontMake(15);
//    self.statusButton.adjustsTitleTintColorAutomatically = YES;
//    [self.statusButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.statusButton setTitle:@"状态" forState:UIControlStateNormal];
//    self.statusButton.frame = CGRectMake(0, 230, 200, 60);
//    [self.statusButton addTarget:self action:@selector(loginUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.statusButton];
//    
    
}


//- (void)registerUserClick {
//    LoginService *loginService = [[LoginService alloc] init];
//    [loginService registUser:@"dashuai" password:@"123456" email:@"feng_xing@126.com" block:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            NSLog(@"注册成功");
//        }else {
//            
//        }
//    }];
//}
//
//- (void)loginUserClick {
//    LoginService *loginService = [[LoginService alloc] init];
//    [loginService loginUser:@"dashuai" andPassword:@"123456" block:^(AVUser * _Nullable user, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"登陆失败");
//        }else {
//            //处理登陆成功
//        }
//    }];
//}
//
//- (void)userStatus {
//    AVUser *user = [AVUser currentUser];
//    NSLog(@"user %@",user.username);
//}


@end
