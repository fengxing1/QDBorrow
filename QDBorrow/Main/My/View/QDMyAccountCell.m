//
//  QDMyAccountCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/31.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDMyAccountCell.h"
#import "QDUserManager.h"
#import "QMUIKit.h"

@implementation QDMyAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.textColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    NSString *userName = [[QDUserManager sharedInstance] getUserName];
    if (userName) {
        self.nameLabel.text = userName;
    } else {
        self.nameLabel.text = @"未登录";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
