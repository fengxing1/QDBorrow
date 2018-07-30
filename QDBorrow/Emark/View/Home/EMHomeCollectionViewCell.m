//
//  EMHomeCollectionViewCell.m
//  emark
//
//  Created by neebel on 2017/5/26.
//  Copyright © 2017年 neebel. All rights reserved.
//

#import "EMHomeCollectionViewCell.h"

@interface EMHomeCollectionViewCell()

@property (nonatomic, strong) UILabel *menuLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation EMHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.menuLabel];
        [self.contentView addSubview:self.imageView];
        __weak typeof(self) weakSelf = self;
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.centerY.equalTo(weakSelf.contentView).offset(-20);
            make.width.equalTo(33);
            make.height.equalTo(39);
        }];
        [self.menuLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.imageView.bottom).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(20);
        }];
//        [self.menuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(weakSelf.contentView);
//        }];
    }

    return self;
}


- (UILabel *)menuLabel
{
    if (!_menuLabel) {
        _menuLabel = [[UILabel alloc] init];
        _menuLabel.textAlignment = NSTextAlignmentCenter;
        _menuLabel.textColor = [UIColor whiteColor];
        _menuLabel.font = [UIFont systemFontOfSize:18.0];
    }
    
    return _menuLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)updateCellWithTitle:(NSString *)title
{
    self.menuLabel.text = title;
    UIColor *bgColor;
    if ([title isEqualToString:NSLocalizedString(@"日记", nil)]) {
        bgColor = UIColorFromHexRGB(0xc6ac8f);
        [self.imageView setImage:[UIImage imageNamed:@"mark1"]];
    } else if ([title isEqualToString:NSLocalizedString(@"账单", nil)]) {
        bgColor = UIColorFromHexRGB(0x60d4b7);
        [self.imageView setImage:[UIImage imageNamed:@"mark2"]];
    } else if ([title isEqualToString:NSLocalizedString(@"节日", nil)]) {
        bgColor = UIColorFromHexRGB(0xf27d56);
        [self.imageView setImage:[UIImage imageNamed:@"mark3"]];
    } else if ([title isEqualToString:NSLocalizedString(@"收纳", nil)]) {
        bgColor = UIColorFromHexRGB(0xf6b142);
        [self.imageView setImage:[UIImage imageNamed:@"mark4"]];
    } else if ([title isEqualToString:NSLocalizedString(@"提醒", nil)]) {
        bgColor = UIColorFromHexRGB(0xa3cea7);
        [self.imageView setImage:[UIImage imageNamed:@"mark5"]];
    } else if ([title isEqualToString:NSLocalizedString(@"设置", nil)]) {
        bgColor = UIColorFromHexRGB(0x849d9a);
        [self.imageView setImage:[UIImage imageNamed:@"mark6"]];
    }
    
    self.contentView.backgroundColor = bgColor;
}

@end
