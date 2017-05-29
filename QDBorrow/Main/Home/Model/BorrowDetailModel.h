//
//  BorrowDetailModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/7.
//  Copyright © 2017年 zks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVObject.h"

@interface BorrowDetailModel : NSObject
@property (nonatomic, assign) long companyId;
@property (nonatomic, strong) NSString *imageIcon;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companyDetail;
@property (nonatomic, assign) long peopleNum;
@property (nonatomic, assign) long maxMoney;
@property (nonatomic, assign) long minMoney;
@property (nonatomic, strong) NSArray *amortizationNumArray;
@property (nonatomic, strong) NSString *fastestTime;
@property (nonatomic, strong) NSArray *qualificationArray;
@property (nonatomic, strong) NSString *redirectUrl;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger bshowAtHome;
//是否显示底部button按钮
@property (nonatomic, assign) NSInteger showButton;

//添加月利率
@property (nonatomic, assign) CGFloat monthyRate;

//产品介绍
@property (nonatomic, strong) NSString *companyIntroduce;

- (instancetype)initWithAVObject:(AVObject *)detail;
@end
