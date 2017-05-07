//
//  QDHomeBannerModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/7.
//  Copyright © 2017年 zks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDHomeBannerModel : NSObject
@property (nonatomic, assign) long bannerId;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) NSInteger bannerType;
@property (nonatomic, strong) NSString *value;

@end
