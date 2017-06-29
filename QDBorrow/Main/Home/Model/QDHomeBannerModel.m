//
//  QDHomeBannerModel.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/7.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "QDHomeBannerModel.h"

@implementation QDHomeBannerModel
- (instancetype)initWithAVObject:(AVObject *)bannerDict {
    self = [super init];
    if (self) {
        self.bannerId = (long)[bannerDict objectForKey:@"bannerId"];
        self.imageUrl = [bannerDict objectForKey:@"imageUrl"];
        self.bannerType = (NSInteger)[bannerDict objectForKey:@"bannerType"];
        self.value = [bannerDict objectForKey:@"value"];
        self.showDetail = [[bannerDict objectForKey:@"showDetail"] integerValue];
    }
    return self;
}

- (instancetype)initWithBannerObject:(BmobObject *)bmobObject {
    self = [super init];
    if (self) {
        self.bannerId = (long)[bmobObject objectForKey:@"bannerId"];
        self.imageUrl = [bmobObject objectForKey:@"imageUrl"];
        self.bannerType = (NSInteger)[bmobObject objectForKey:@"bannerType"];
        self.value = [bmobObject objectForKey:@"value"];
        self.showDetail = [[bmobObject objectForKey:@"showDetail"] integerValue];
    }
    return self;
}
@end
