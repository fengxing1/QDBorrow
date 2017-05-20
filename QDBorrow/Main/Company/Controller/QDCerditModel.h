//
//  QDCerditModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/15.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVObject.h"

@interface QDCerditModel : NSObject
@property (nonatomic, assign) long cerditId;
@property (nonatomic, copy) NSString *cerditIcon;
@property (nonatomic, copy) NSString *cerditName;
@property (nonatomic, copy) NSString *cerditDesc;
@property (nonatomic, copy) NSString *redirectUrl;
//是否显示在详情页
@property (nonatomic, assign) NSInteger showDetail;

- (instancetype)initWithAVObject:(AVObject *)detail;

@end
