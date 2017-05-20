//
//  BorrowDetailModel.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/7.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "BorrowDetailModel.h"

@implementation BorrowDetailModel

- (instancetype)initWithAVObject:(AVObject *)detail {
    if (self = [super init]) {
        self.companyId = [[detail valueForKey:@"companyId"] longValue];
        self.imageIcon = [detail valueForKey:@"imageIcon"];
        self.companyName = [detail valueForKey:@"companyName"];
        self.companyDetail = [detail valueForKey:@"companyDetail"];
        self.peopleNum = [[detail valueForKey:@"peopleNum"] longValue];
        self.maxMoney = [[detail valueForKey:@"maxMoney"] longValue];
        self.minMoney = [[detail valueForKey:@"minMoney"] longValue];
        self.amortizationNumArray = [detail objectForKey:@"amortizationNumArray"];
        self.fastestTime = [detail valueForKey:@"fastestTime"];
        self.qualificationArray = [detail objectForKey:@"qualificationArray"];
        self.redirectUrl = [detail valueForKey:@"redirectUrl"];
        self.dataArray = [detail valueForKey:@"dataArray"];
        self.bshowAtHome = [[detail valueForKey:@"bshowAtHome"] integerValue];
        
        self.monthyRate = [[detail valueForKey:@"monthyRate"] floatValue];
        self.showButton = [[detail valueForKey:@"showButton"] integerValue];
    }
    return self;
}

@end
