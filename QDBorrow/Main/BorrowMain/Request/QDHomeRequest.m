//
//  QDHomeRequest.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDHomeRequest.h"

@implementation QDHomeRequest

- (NSString *)requestUrl {
    return @"mainView.json";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"devicesType": [NSNumber numberWithInt:2]
             };
}


@end
