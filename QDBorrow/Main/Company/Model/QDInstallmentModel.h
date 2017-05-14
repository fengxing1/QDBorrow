//
//  QDInstallmentModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/13.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDInstallmentModel : NSObject
//借款金额
@property (nonatomic, assign) NSInteger moneyCount;
//分期数
@property (nonatomic, assign) NSInteger installCount;
//月利率
@property (nonatomic, assign) float interest;

//最快多久放款
@property (nonatomic, strong) NSString *fastTimeStr;

@end
