//
//  QDCompanyDetailModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/3.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QDBorrowModel.h"

@interface QDCompanyDetailModel : QDBorrowModel
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *debitDesc;
@property (nonatomic, strong) NSString *needData;
@property (nonatomic, strong) NSString *qualification;

@property (nonatomic, strong) NSString *fastTime;
@property (nonatomic, strong) NSString *debitMoney;
@property (nonatomic, strong) NSString *debitTime;


@end
