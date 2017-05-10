//
//  QBBusinessTableViewCell.m
//  QDBorrow
//
//  Created by larou on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QBBusinessTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "QMUIKit.h"

@interface QBBusinessTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *businessIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;


@end

@implementation QBBusinessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.businessIconImageView.layer.masksToBounds = YES;
    self.businessIconImageView.layer.cornerRadius = self.businessIconImageView.frame.size.height / 2;
    self.businessNameLabel.textColor = TableViewCellTitleLabelColor;
    self.businessDetailLabel.textColor = TableViewCellDetailLabelColor;
    self.peopleCountLabel.textColor = TableViewCellDetailLabelColor;
    self.businessNameLabel.font = [UIFont systemFontOfSize:14];
    self.businessDetailLabel.font = [UIFont systemFontOfSize:12];
    self.peopleCountLabel.font = [UIFont systemFontOfSize:12];
    
    
}

- (void)setBorrowModel:(BorrowDetailModel *)borrowModel {
    _borrowModel = borrowModel;
    [self.businessIconImageView sd_setImageWithURL:[NSURL URLWithString:borrowModel.imageIcon] placeholderImage:nil];
    self.businessNameLabel.text = borrowModel.companyName;
    self.businessDetailLabel.text = borrowModel.companyDetail;
    self.peopleCountLabel.text = [NSString stringWithFormat:@"%ld人已放款",borrowModel.peopleNum];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
