//
//  QDHomeBorrowCell.h
//  QDBorrow
//
//  Created by larou on 2017/8/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^borrowWay)(int borrowType,NSInteger borrowCount);

@interface QDHomeBorrowCell : UITableViewCell
//总费用
@property (weak, nonatomic) IBOutlet UILabel *totalFeeCountLabel;
//到账金额Ô
@property (weak, nonatomic) IBOutlet UILabel *gainCountLabel;
//手续费用
@property (weak, nonatomic) IBOutlet UILabel *poundageCountLabel;
//借款时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *fifteenDayBtn;

@property (weak, nonatomic) IBOutlet UIButton *thirtyDayBtn;
@property (weak, nonatomic) IBOutlet UIButton *goBorrowBtn;

@property (nonatomic,copy) borrowWay block;
@end
