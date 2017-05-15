//
//  QDMultiLabelCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/14.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDMultiLabelCell.h"
#import "QMUIKit.h"

@implementation QDMultiLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMultiStrArray:(NSArray *)multiStrArray {
    _multiStrArray = multiStrArray;
    if (multiStrArray && multiStrArray.count > 0) {
        for (int i = 0; i < multiStrArray.count; i ++) {
            NSString *desc = multiStrArray[i];
            UILabel *label = [self createLabel:desc];
            label.frame = CGRectMake(15, 10 * (i + 1) + 12 * i, SCREEN_WIDTH - 30, 12);
            [self.contentView addSubview:label];
        }
    }
}

- (UILabel *)createLabel:(NSString *)desc {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = TableViewCellDetailLabelColor;
    label.font = [UIFont systemFontOfSize:12];
    label.text = desc;
    label.frame = CGRectMake(15, 10,SCREEN_WIDTH - 30 , 12);
    return label;
    
}

+ (CGFloat)heightOfCell:(NSArray *)multiStrArray {
    if (multiStrArray && multiStrArray.count) {
        return 22 * multiStrArray.count + 10;
    }
    
    return 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
