//
//  NSString+Validate.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)
+ (BOOL) IsEmailAdress:(NSString *)Email;
+ (BOOL) IsBankCard:(NSString *)cardNumber;
@end
