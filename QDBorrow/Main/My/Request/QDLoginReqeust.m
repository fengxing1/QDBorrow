//
//  QDLoginReqeust.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/2.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDLoginReqeust.h"

@implementation QDLoginReqeust {
    NSString *_username;
    NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"login.json";
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"username": _username,
             @"password": _password
             };
}

@end
