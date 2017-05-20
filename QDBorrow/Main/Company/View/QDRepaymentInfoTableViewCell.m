//
//  QDRepaymentInfoTableViewCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDRepaymentInfoTableViewCell.h"
#import "QDUIHelper.h"

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
    self.repayCountLabel.textColor = UIColorBlue;
    self.rateLabel.textColor = UIColorBlue;
    self.timeLabel.textColor = UIColorBlue;
    self.repayMonthNamelabel.textColor = UIColorGray;
    self.rateNameLabel.textColor = UIColorGray;
    self.timeNameLabel.textColor = UIColorGray;
}


//等额本息计算公式：〔贷款本金×月利率×（1＋月利率）＾还款月数〕÷〔（1＋月利率）＾还款月数－1〕
//monthlyRepayment = capitalization * rateOfMonth * pow((1 + rateOfMonth), months) / (pow((1 + rateOfMonth), months) - 1);
- (void)setInstallmentModel:(QDInstallmentModel *)installmentModel {
    _installmentModel = installmentModel;
    CGFloat monthlyRepayment = 0;
    //本金
    CGFloat capitalization = installmentModel.moneyCount;
    //月利率
    CGFloat rateOfMonth = installmentModel.interest / 100.0;
    //月数
    NSInteger months = installmentModel.installCount;
    
    monthlyRepayment = capitalization * rateOfMonth * pow((1 + rateOfMonth), months) / (pow((1 + rateOfMonth), months) - 1);
    self.repayCountLabel.text = [NSString stringWithFormat:@"%.2f",monthlyRepayment];
    NSString *rate = [NSString stringWithFormat:@"%.2f",installmentModel.interest];
    self.rateLabel.text = [rate stringByAppendingString:@"%"];
    self.timeLabel.text = installmentModel.fastTimeStr;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end