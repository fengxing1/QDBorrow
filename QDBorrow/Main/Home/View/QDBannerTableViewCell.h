//
//  QDBannerTableViewCell.h
//  QDBorrow
//
//  Created by larou on 2017/5/9.
//  Copyright © 2017年 zks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDBannerModel.h"
#import "SDCycleScrollView.h"

@protocol CellOfBannerDelgate <NSObject>
- (void)cellOfBannerClick:(QDBannerModel *)banner;
@end

@interface QDBannerTableViewCell : UITableViewCell <SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) SDCycleScrollView *sdCycleView;
@property (nonatomic, weak) id<CellOfBannerDelgate> delegate;



@end
