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
    NSInteger _type;
}

- (id)initWithCompany:(long)id type:(NSInteger)type{
    self = [super init];
    if (self) {
        _id = id;
        _type = type;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"auth/postBury.json";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
             @"version":[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"],
             @"productId": [NSNumber numberWithLong:_id],
             @"type":[NSNumber numberWithInteger:_type]
             };
}

@end
