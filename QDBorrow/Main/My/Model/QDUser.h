//
//  QDUser.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDUser : NSObject <NSCoding,NSCopying>
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *verifyCode;

@end
