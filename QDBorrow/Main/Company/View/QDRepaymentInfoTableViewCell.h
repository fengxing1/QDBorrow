//
//  QDRepaymentInfoTableViewCell.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDBorrowDetailModel.h"

@interface QDRepaymentInfoTableViewCell : UITableViewCell

- (void)setMoney:(long)currentMoney time:(long)currentTime rate:(double)monthyRate;

@end
