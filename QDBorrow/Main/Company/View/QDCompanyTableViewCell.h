//
//  QDCompanyTableViewCell.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BorrowDetailModel.h"

@interface QDCompanyTableViewCell : UITableViewCell
@property (nonatomic, strong) BorrowDetailModel *borrowDtail;
@property (nonatomic, assign) Boolean bShowInDetail;

@end
