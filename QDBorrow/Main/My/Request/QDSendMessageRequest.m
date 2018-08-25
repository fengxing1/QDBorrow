//
//  QDSendMessageRequest.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/2.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDSendMessageRequest.h"

@implementation QDSendMessageRequest {
     NSString *_phoneNum;
}

- (id)initWithPhoneNum:(NSString *)phoneNum {
    self = [super init];
    if (self) {
        _phoneNum = phoneNum;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"getSmsCode.json";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"phone": [NSNumber numberWithLong:[_phoneNum longLongValue]],
             @"version":[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"],
             };
}

@end
