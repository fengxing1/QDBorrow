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
    return @{
             @"sessionId": [QDUserManager sharedInstance].getUser.sessionId.length?[QDUserManager sharedInstance].getUser.sessionId:@"AF48E7EC31323F9BEE3B015BA472704C",
             @"devicesType": [NSNumber numberWithInt:2]
             };
}

@end
