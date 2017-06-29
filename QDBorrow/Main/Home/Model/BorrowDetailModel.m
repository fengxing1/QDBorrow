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
        self.companyId = [[detail objectForKey:@"companyId"] longValue];
        self.imageIcon = [detail objectForKey:@"imageIcon"];
        self.companyName = [detail objectForKey:@"companyName"];
        self.companyDetail = [detail objectForKey:@"companyDetail"];
        self.peopleNum = [[detail objectForKey:@"peopleNum"] longValue];
        self.maxMoney = [[detail objectForKey:@"maxMoney"] longValue];
        self.minMoney = [[detail objectForKey:@"minMoney"] longValue];
        self.amortizationNumArray = [detail objectForKey:@"amortizationNumArray"];
        self.fastestTime = [detail objectForKey:@"fastestTime"];
        self.qualification = [detail objectForKey:@"qualification"];
        self.redirectUrl = [detail objectForKey:@"redirectUrl"];
        self.needdata = [detail objectForKey:@"needdata"];
        self.bshowAtHome = [[detail objectForKey:@"bshowAtHome"] integerValue];
        
        self.monthyRate = [[detail objectForKey:@"monthyRate"] floatValue];
        self.showButton = [[detail objectForKey:@"showButton"] integerValue];
        self.companyIntroduce = [detail objectForKey:@"companyIntroduce"];
    }
    return self;
}

- (instancetype)initWithBmObject:(BmobObject *)detail {
    if (self = [super init]) {
        self.companyId = [[detail objectForKey:@"companyId"] longValue];
        self.imageIcon = [detail objectForKey:@"imageIcon"];
        self.companyName = [detail objectForKey:@"companyName"];
        self.companyDetail = [detail objectForKey:@"companyDetail"];
        self.peopleNum = [[detail objectForKey:@"peopleNum"] longValue];
        self.maxMoney = [[detail objectForKey:@"maxMoney"] longValue];
        self.minMoney = [[detail objectForKey:@"minMoney"] longValue];
        self.amortizationNumArray = [detail objectForKey:@"amortizationNumArray"];
        self.fastestTime = [detail objectForKey:@"fastestTime"];
        self.qualification = [detail objectForKey:@"qualification"];
        self.redirectUrl = [detail objectForKey:@"redirectUrl"];
        self.needdata = [detail objectForKey:@"needdata"];
        self.bshowAtHome = [[detail objectForKey:@"bshowAtHome"] integerValue];
        
        self.monthyRate = [[detail objectForKey:@"monthyRate"] floatValue];
        self.showButton = [[detail objectForKey:@"showButton"] integerValue];
        self.companyIntroduce = [detail objectForKey:@"companyIntroduce"];
    }
    return self;
}

@end
