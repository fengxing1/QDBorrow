//
//  LoginService.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/6.
//  Copyright © 2017年 zks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface LoginService : NSObject
+ (id)sharedInstance;
- (void)registUser:(NSString *)userName password:(NSString *)pwd email:(NSString *)email block:(AVBooleanResultBlock)block;
- (void)loginUser:(NSString *)userName andPassword:(NSString *)pwd block:(AVUserResultBlock)block;

@end
