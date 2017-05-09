//
//  QDBannerTableViewCell.m
//  QDBorrow
//
//  Created by larou on 2017/5/9.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "QDBannerTableViewCell.h"
#import "QMUIKit.h"

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

- (void)setBannerList:(NSMutableArray *)bannerList
{
    _bannerList = bannerList;
    NSMutableArray *imageUrlArr = [[NSMutableArray alloc] init];
    if (_bannerList.count) {
        self.sdCycleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (180 * SCREEN_WIDTH / 375));
        for (QDHomeBannerModel *banner in _bannerList)  {
            if (banner.imageUrl) {
                [imageUrlArr addObject:banner.imageUrl];
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
        QDHomeBannerModel *banner = self.bannerList[index];
        [self.delegate cellOfBannerClick:banner];
    }
}


@end
