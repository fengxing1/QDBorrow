//
//  QDCompanyTableViewCell.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCompanyTableViewCell.h"
#import "QDUIHelper.h"
#import "UIImageView+WebCache.h"

@interface QDCompanyTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
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
    self.companyIconImageView.layer.cornerRadius = self.companyIconImageView.frame.size.width/2;
    self.companyIconImageView.layer.masksToBounds = YES;
    self.companyNameLabel.textColor = TableViewCellTitleLabelColor;
    self.companyDetailLabel.textColor = TableViewCellTitleLabelColor;
    self.successCountLabel.textColor = TableViewCellTitleLabelColor;
    self.penpleCountLabel.textColor = TableViewCellDetailLabelColor;
    self.oneLineLayer = [CALayer qmui_separatorLayer];
    [self.contentView.layer addSublayer:self.oneLineLayer];
    self.oneLineLayer.frame = CGRectMake(0, 80, SCREEN_WIDTH, PixelOne);
}

- (void)setBorrowDtail:(QDCompanyDetailModel *)borrowDtail {
    _borrowDtail = borrowDtail;
    [self.companyIconImageView sd_setImageWithURL:[NSURL URLWithString:borrowDtail.image] placeholderImage:nil];
    self.companyNameLabel.text = borrowDtail.productName;
    self.penpleCountLabel.text = [NSString stringWithFormat:@"%ld人已放款",borrowDtail.peopleNumber];
    
    self.companyDetailLabel.text = borrowDtail.productDetail;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}



@end
