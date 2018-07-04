//
//  QDUser.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDUser.h"

#define kUserNameKey @"UserNameeKey"
#define kPasswordKey @"PasswordKey"
#define kVerifyCodeKey @"VerifyCodeKey"
#define kSessionKey @"SessionKey"

@implementation QDUser

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.userName = [aDecoder decodeObjectForKey:kUserNameKey];
        self.password = [aDecoder decodeObjectForKey:kPasswordKey];
        self.verifyCode = [aDecoder decodeObjectForKey:kVerifyCodeKey];
        self.sessionId = [aDecoder decodeObjectForKey:kSessionKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:kUserNameKey];
    [aCoder encodeObject:self.password forKey:kPasswordKey];
    [aCoder encodeObject:self.verifyCode forKey:kVerifyCodeKey];
    [aCoder encodeObject:self.sessionId forKey:kSessionKey];

}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone{
    
    QDUser *model = [[QDUser alloc]init];
    model.userName = [self.userName copy];
    model.password = [self.password copy];
    model.verifyCode = [self.verifyCode copy];
    model.sessionId = [self.sessionId copy];
    return model;
    
}


@end
