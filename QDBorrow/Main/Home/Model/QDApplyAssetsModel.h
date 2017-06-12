//
//  QDApplyAssetsModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/12.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDApplyAssetsModel : NSObject
//贷款用途
@property (nonatomic, strong) NSString *loanUse;
//贷款用途
@property (nonatomic, strong) NSString *loanAmount;
//贷款时间
@property (nonatomic, strong) NSString *loanTime;
//职业身份
@property (nonatomic, strong) NSString *workingIdentity;

//信用卡额度
@property (nonatomic, strong) NSString *certAmount;
//名下房产
@property (nonatomic, strong) NSString *housesAmount;
//名下车产
@property (nonatomic, strong) NSString *carAmount;
//信息记录
@property (nonatomic, strong) NSString *infoRecord;
//文化程度
@property (nonatomic, strong) NSString *culture;
//月收入
@property (nonatomic, strong) NSString *monthEarning;
//收入形式
@property (nonatomic, strong) NSString *earningWay;
//本地社保
@property (nonatomic, strong) NSString *socialSecurity;
//公积金
@property (nonatomic, strong) NSString *AccumulationFund;
//个人证件
@property (nonatomic, strong) NSString *certificate;
@end
