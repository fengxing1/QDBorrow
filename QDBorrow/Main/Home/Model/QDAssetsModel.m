//
//  QDAssetsModel.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDAssetsModel.h"
@implementation AssetsInfo

@end

@implementation QDAssetsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"array" : [AssetsInfo class]};
}

@end
