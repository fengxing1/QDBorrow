//
//  QDHelpModel.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDHelpModel.h"

@implementation QDHelpInfoModel
@end

@implementation QDHelpModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [QDHelpInfoModel class]};
}

@end