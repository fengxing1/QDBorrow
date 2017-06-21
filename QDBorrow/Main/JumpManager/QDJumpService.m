//
//  QDJumpService.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/21.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDJumpService.h"

@implementation QDJumpService

+ (id)sharedInstance
{
    static QDJumpService *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

//控制跳转
//- (void)registUser:(NSString *)userName password:(NSString *)pwd email:(NSString *)email block:(AVBooleanResultBlock)block{
//    AVUser *user = [AVUser user];
//    user.username = userName;
//    user.password = pwd;
//    user.email = email;
//    [user signUpInBackgroundWithBlock:block];
//}

@end
