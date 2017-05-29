//
//  QDProductIntroduceCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/29.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDProductIntroduceCell.h"
#import "QMUIKit.h"
#import "NSString+Size.h"

@implementation QDProductIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.instroduceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.instroduceLabel];
        self.instroduceLabel.numberOfLines = 0;
        self.instroduceLabel.textColor = TableViewCellDetailLabelColor;
        self.instroduceLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setProductIntroduce:(NSString *)productIntroduce {
    _productIntroduce = productIntroduce;
    self.instroduceLabel.text = productIntroduce;
    self.instroduceLabel.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30,[productIntroduce heightWithFont:[UIFont systemFontOfSize:12] constrainedToWidth:SCREEN_WIDTH - 30 ]) ;
    
}


+ (CGFloat)heightOfCellWithIntroduce:(NSString *)introduce {
    CGFloat height = [introduce heightWithFont:[UIFont systemFontOfSize:12] constrainedToWidth:SCREEN_WIDTH - 30];
    return height + 20;
}


@end
