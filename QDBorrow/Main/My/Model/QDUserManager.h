//
//  QDUserManager.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QDUser.h"

@interface QDUserManager : NSObject
@property (nonatomic, strong) QDUser *user;

+ (instancetype)sharedInstance;
- (QDUser *)getUser;
- (void)saveUser:(QDUser *)user;
- (BOOL)validateUser;
- (void)exitUser;
- (NSString *)getUserName;

- (NSString *)sessionId;

@end
