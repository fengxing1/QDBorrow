//
//  QDJumpService.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/21.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDJumpService.h"
NSString *const kClassNameTabbarStatus = @"TCSwitch";


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

- (void)changeTabbarWithBlock:(BmobObjectResultBlock)block {
    BmobQuery *query = [BmobQuery queryWithClassName:kClassNameTabbarStatus];
    [query getObjectInBackgroundWithId:@"KX3J555B" block:block];
}



@end
