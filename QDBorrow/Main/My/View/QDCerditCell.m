//
//  QDCerditCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/16.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCerditCell.h"
#import "QMUIKit.h"
#import "UIImageView+WebCache.h"

@interface QDCerditCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cerditIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *cerditNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cerditDetailLabel;



@end

@implementation QDCerditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cerditNameLabel.textColor = TableViewCellTitleLabelColor;
    self.cerditDetailLabel.textColor = TableViewCellDetailLabelColor;
}


- (void)setCerditModel:(QDCerditModel *)cerditModel {
    _cerditModel = cerditModel;
    [self.cerditIconImageView sd_setImageWithURL:[NSURL URLWithString:cerditModel.cerditIcon]];
    self.cerditNameLabel.text = cerditModel.cerditName;
    self.cerditDetailLabel.text = cerditModel.cerditDesc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
