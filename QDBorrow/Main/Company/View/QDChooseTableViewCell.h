//
//  QDChooseTableViewCell.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDAmountOfCount : NSObject
@property (nonatomic, assign) NSInteger minMoneyCount;
@property (nonatomic, assign) NSInteger maxMoneyCount;
@property (nonatomic, assign) NSInteger moneyCount;
//分期期限
@property (nonatomic, strong) NSArray *amortizationNumArray;
@property (nonatomic, assign) NSInteger mounthCount;

@end

@interface QDChooseTableViewCell : UITableViewCell

@property (nonatomic, strong) QDAmountOfCount *amountCount;
//0表示是借款金额  1表示是分期期限
@property (nonatomic, assign) NSInteger cellType;
@property (weak, nonatomic) IBOutlet UIImageView *chooseIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *chooseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseDetailLabel;

@end
