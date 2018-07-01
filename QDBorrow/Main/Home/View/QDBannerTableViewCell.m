//
//  QDBannerTableViewCell.m
//  QDBorrow
//
//  Created by larou on 2017/5/9.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "QDBannerTableViewCell.h"
#import "QMUIKit.h"
#import "QDBannerModel.h"

@implementation QDBannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _bannerList = [[NSMutableArray alloc] init];
        self.sdCycleView = [[SDCycleScrollView alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:self.sdCycleView];
        
        self.sdCycleView.autoScrollTimeInterval = 4.f;
        self.sdCycleView.infiniteLoop = YES;
        self.sdCycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        self.sdCycleView.delegate = self;
    }
    return self;
}

- (void)setBannerList:(NSArray *)bannerList
{
    _bannerList = bannerList;
    NSMutableArray *imageUrlArr = [[NSMutableArray alloc] init];
    if (_bannerList.count) {
        self.sdCycleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (200 * SCREEN_WIDTH / 375));
        for (QDBannerModel *banner in _bannerList)  {
            if (banner.image) {
                [imageUrlArr addObject:banner.image];
            }
            
        }
    }
    self.sdCycleView.imageURLStringsGroup = imageUrlArr;
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellOfBannerClick:)])
    {
        QDBannerModel *banner = self.bannerList[index];
        [self.delegate cellOfBannerClick:banner];
    }
}


@end
