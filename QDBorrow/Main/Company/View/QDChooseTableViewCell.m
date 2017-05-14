//
//  QDChooseTableViewCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDChooseTableViewCell.h"
#import "QMUIKit.h"

@implementation QDAmountOfCount

@end

@implementation QDChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.chooseTitleLabel.textColor = TableViewCellDetailLabelColor;
    self.chooseDetailLabel.textColor= TableViewCellTitleLabelColor;
}

- (void)setAmountCount:(QDAmountOfCount *)amountCount {
    _amountCount = amountCount;
    if (!self.cellType) {
        self.chooseTitleLabel.text = [NSString stringWithFormat:@"借款金额(%0.1f-%0.1f万)",amountCount.minMoneyCount/10000.0,amountCount.maxMoneyCount/1000.0];
        self.chooseDetailLabel.text = [NSString stringWithFormat:@"%ld",(long)amountCount.moneyCount];
    } else {
        self.chooseTitleLabel.text = [NSString stringWithFormat:@"分期期限(%@-%@月)",amountCount.amortizationNumArray[0],self.amountCount.amortizationNumArray[amountCount.amortizationNumArray.count-1]];
        self.chooseDetailLabel.text = [NSString stringWithFormat:@"%ld",(long)amountCount.mounthCount];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
