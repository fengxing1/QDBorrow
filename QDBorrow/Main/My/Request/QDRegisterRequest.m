//
//  QDRegisterRequest.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/2.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDRegisterRequest.h"

@implementation QDRegisterRequest {
    NSString *_username;
    NSString *_password;
    NSString *_validateCode;
}


- (id)initWithUsername:(NSString *)username password:(NSString *)password validate:(NSString *)validate{
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
        _validateCode = validate;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"register.json";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}


- (id)requestArgument {
    return @{
             @"username": _username,
             @"password": _password,
             @"verifyCode": _validateCode,
             @"deviceType": [NSNumber numberWithInt:2]
             };
}


@end
