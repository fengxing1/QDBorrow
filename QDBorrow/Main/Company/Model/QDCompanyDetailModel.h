//
//  QDCompanyDetailModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/3.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDCompanyDetailModel : NSObject
@property (nonatomic, assign) long id;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *image;
//排序使用
@property (nonatomic, assign) NSString *borrowOrder;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productDetail;
@property (nonatomic, strong) NSString *debitDesc;
@property (nonatomic, strong) NSString *needData;
@property (nonatomic, strong) NSString *qualification;
@property (nonatomic, assign) long peopleNumber;
@property (nonatomic, strong) NSString *fastTime;
@property (nonatomic, strong) NSString *debitMoney;
@property (nonatomic, strong) NSString *debitTime;
@property (nonatomic, assign) double monthyRate;

@end
