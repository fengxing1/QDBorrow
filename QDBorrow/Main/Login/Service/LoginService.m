//
//  LoginService.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/6.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "LoginService.h"
#import <AVOSCloud/AVOSCloud.h>
#import "NSString+Trims.h"


@implementation LoginService

//通过用户名和密码注册
- (void)registUser:(NSString *)userName password:(NSString *)pwd email:(NSString *)email block:(AVBooleanResultBlock)block{
    AVUser *user = [AVUser user];
    user.username = userName;
    user.password = pwd;
    user.email = email;
    [user signUpInBackgroundWithBlock:block];
}

//通过用户名和密码登录
- (void)loginUser:(NSString *)userName andPassword:(NSString *)pwd block:(AVUserResultBlock)block{
    if ([userName trimmingWhitespace] && [pwd trimmingWhitespace]) {
        [AVUser logInWithUsernameInBackground:userName password:pwd block:block];
    }
}

//发送验证码
- (void)sendSmsCode:(NSString *)mobile block:(AVBooleanResultBlock)block{
    if ([mobile trimmingWhitespace] && mobile.length == 11) {
        [AVUser requestLoginSmsCode:mobile withBlock:block];
    }
}


//通过验证码登录
- (void)userLoginMobile:(NSString *)mobile andCode:(NSString *)code block:(AVUserResultBlock)block {
    if ([mobile trimmingWhitespace] && [code trimmingWhitespace]) {
        [AVUser logInWithMobilePhoneNumberInBackground:mobile smsCode:code block:block];
    }
}



@end
