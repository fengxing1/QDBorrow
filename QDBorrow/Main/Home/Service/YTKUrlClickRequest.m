//
//  YTKUrlClickRequest.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/9.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "YTKUrlClickRequest.h"
#import "QDUserManager.h"

@implementation YTKUrlClickRequest {
    long _id;
}

- (id)initWithCompany:(long)id {
    self = [super init];
    if (self) {
        _id = id;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"postBury.json";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"productId": [NSNumber numberWithLong:_id],
             @"sessionId":[QDUserManager sharedInstance].getUser.sessionId,
             @"deviceType": [NSNumber numberWithInt:2]
             };
}

@end
