//
//  QDBannerModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDBannerModel : NSObject
@property (nonatomic, assign) long id;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) NSInteger bannerOrder;
@end
