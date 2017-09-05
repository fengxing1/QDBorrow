//
//  QDMessageCell.m
//  QDBorrow
//
//  Created by larou on 2017/9/1.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDMessageCell.h"
@interface QDMessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *messageTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroudView;

@end

@implementation QDMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor clearColor];
}




- (void)setMessageModel:(QDMessageModel *)messageModel {
    self.backgroudView.layer.cornerRadius = 5;
    self.backgroudView.layer.masksToBounds = YES;
    _messageModel = messageModel;
    self.messageTypeLabel.text = messageModel.messageType;
    self.timeLabel.text = messageModel.messageTime;
    self.titleLabel.text = messageModel.messageTitle;
    self.contentLabel.text = messageModel.messageContent;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
