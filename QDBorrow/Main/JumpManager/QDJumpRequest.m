//
//  QDJumpRequest.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDJumpRequest.h"

@implementation QDJumpRequest
- (NSString *)requestUrl {
    // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"versionStatus.json";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"id": [NSNumber numberWithInt:1],
             };
}
@end
