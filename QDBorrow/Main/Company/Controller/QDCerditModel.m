//
//  QDCerditModel.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/15.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCerditModel.h"

@implementation QDCerditModel

- (instancetype)initWithAVObject:(AVObject *)detail {
    if (self = [super init]) {
        self.cerditId = [[detail valueForKey:@"cerditId"] longValue];
        self.cerditIcon = [detail valueForKey:@"cerditIcon"];
        self.cerditName = [detail valueForKey:@"cerditName"];
        self.cerditDesc = [detail valueForKey:@"cerditDesc"];
        self.redirectUrl = [detail valueForKey:@"redirectUrl"];
    }
    return self;
}

@end
