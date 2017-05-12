//
//  QDCompanyTableViewCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCompanyTableViewCell.h"

@interface QDCompanyTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *companyIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *penpleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *successCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyDetailLabel;
@property (nonatomic, strong) CALayer *oneLineLayer;

@end

@implementation QDCompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.oneLineLayer = [CALayer ]
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
