//
//  QDCompanyDetailRequest.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/3.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDCompanyDetailRequest.h"
#import "QDUserManager.h"

@implementation QDCompanyDetailRequest {
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
    return @"auth/borrowDetail.json";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


- (id)requestArgument {
    return @{
             @"id": [NSNumber numberWithLong:_id],
             @"sessionId":[QDUserManager sharedInstance].getUser.sessionId
             };
}


@end
