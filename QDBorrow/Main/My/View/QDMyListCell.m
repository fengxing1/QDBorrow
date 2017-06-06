//
//  QDMyListCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/31.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDMyListCell.h"
#import "QMUIKit.h"

@implementation QDMyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.listTitleLabel.textColor = TableViewCellTitleLabelColor;
}

- (void)setCellType:(CellType)cellType {
    _cellType = cellType;
    if (cellType == CellTypeMessage) {
        [self imageViewWithImageName:@"my_icon_notice"];
        self.listTitleLabel.text = @"我的消息";
    } else if(cellType == CellTypeHelp){
        [self imageViewWithImageName:@"my_icon_help"];
        self.listTitleLabel.text = @"帮助中心";
    } else if(cellType == CellTypeService){
        [self imageViewWithImageName:@"my_icon_myinfo-1"];
        self.listTitleLabel.text = @"在线客服";
    } else {
        [self imageViewWithImageName:@"my_icon_set"];
        self.listTitleLabel.text = @"设置";
    }
}

- (void)imageViewWithImageName:(NSString *)imageName {
    self.iconImageView.image = [UIImage imageNamed:imageName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
