//
//  QDHomeBorrowCell.h
//  QDBorrow
//
//  Created by larou on 2017/8/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDHomeBorrowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalFeeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *gainCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *poundageCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *fifteenDayBtn;

@property (weak, nonatomic) IBOutlet UIButton *thirtyDayBtn;
@property (weak, nonatomic) IBOutlet UIButton *goBorrowBtn;
@end
