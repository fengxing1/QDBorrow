//
//  QDHomeList.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDHomeList.h"
#import "QDBannerModel.h"
#import "QDBorrowModel.h"

@implementation QDHomeList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"bannerVOList" : [QDBannerModel class],
             @"borrowVOList" : [QDBorrowModel class],
             };
}

@end
