//
//  introductoryPagesHelper.h
//  MobileProject
//
//  Created by wujunyang on 16/7/14.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "introductoryPagesView.h"

@interface introductoryPagesHelper : NSObject
//最后一个页面的回调
@property (nonatomic, strong) void (^clickLastImageAction)();

+ (instancetype)shareInstance;

+(void)showIntroductoryPageView:(NSArray *)imageArray;

@end
