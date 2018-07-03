//
//  QDUserManager.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDUserManager.h"


@implementation QDUserManager

+(id)allocWithZone:(NSZone *)zone{
    return [QDUserManager sharedInstance];
}

- (NSString *)getUserName {
    return [self getUser].userName;
}

+ (instancetype)sharedInstance {
    static QDUserManager * userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[super allocWithZone:nil] init];
    });
    return userManager;
}

-(id)copyWithZone:(NSZone *)zone{
    return [QDUserManager sharedInstance];
}

- (void)exitUser {
    self.user = nil;
    [NSKeyedArchiver archiveRootObject:[NSNull null] toFile:[self userFilePath]];
}

- (QDUser *)getUser {
    if (self.user) {
        return self.user;
    } else {
       QDUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:[self userFilePath]];
        if ([user isKindOfClass:[NSNull class]]) {
            return nil;
        }
        return user;
    }
}

-(NSString *)userFilePath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject];
    NSString *accountPath = [documentPath stringByAppendingPathComponent:@"Account.data"];
    return accountPath;
}

- (void)saveUser:(QDUser *)user {
    self.user = user;
    //存储用户信息
    [NSKeyedArchiver archiveRootObject:user toFile:[self userFilePath]];
}

- (BOOL)validateUser {
    if ([self getUser]) {
        return YES;
    }
    return NO;
}

- (NSString *)getSessionId {
    return  [self getUser].sessionId;
}

@end
