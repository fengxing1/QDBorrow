//
//  QDBaseRequest.m
//  QDBorrow
//
//  Created by 黄启山 on 2018/7/19.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDBaseRequest.h"
#import "QDUserManager.h"
@implementation QDBaseRequest

-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"2" forKey:@"devicesType"];
    [dict setObject:@"1" forKey:@"packageType"];
    if([QDUserManager sharedInstance].getUser.sessionId && [QDUserManager sharedInstance].getUser.sessionId.length) {
        [dict setObject:[QDUserManager sharedInstance].getUser.sessionId forKey:@"sessionId"];
    }

    return dict;
}

@end
