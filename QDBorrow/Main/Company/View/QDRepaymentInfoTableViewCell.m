//
//  QDRepaymentInfoTableViewCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDRepaymentInfoTableViewCell.h"
@interface QDRepaymentInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *repayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayMonthNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeNameLabel;

@end

@implementation QDRepaymentInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
