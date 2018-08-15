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

-(void)setCountArray:(NSArray *)countArray {
    _countArray = countArray;
    if (!self.cellType) {
        self.chooseTitleLabel.text = [NSString stringWithFormat:@"借款金额(%@-%@)元",countArray.firstObject,countArray.lastObject];
        self.chooseDetailLabel.text = [NSString stringWithFormat:@"%@",countArray.firstObject];
    } else {
        self.chooseTitleLabel.text = [NSString stringWithFormat:@"分期期限(%@-%@天)",countArray.firstObject,countArray.lastObject];
        self.chooseDetailLabel.text = [NSString stringWithFormat:@"%@",countArray.firstObject];
    }
//    self.chooseDetailLabel.hidden = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
