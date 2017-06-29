//
//  QDHomeBannerModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/7.
//  Copyright © 2017年 zks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVObject.h"
#import <BmobSDK/Bmob.h>

@interface QDHomeBannerModel : NSObject
@property (nonatomic, assign) long bannerId;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) NSInteger bannerType;
@property (nonatomic, strong) NSString *value;
//是否能跳转到详情页
@property (nonatomic, assign) NSInteger showDetail;

- (instancetype)initWithAVObject:(AVObject *)bannerDict;

- (instancetype)initWithBannerObject:(BmobObject *)bmobObject;

@end
