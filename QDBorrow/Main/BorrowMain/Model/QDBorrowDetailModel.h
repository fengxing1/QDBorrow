//
//  QDBorrowDetailModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDBorrowDetailModel : NSObject
@property (nonatomic, assign) long id;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *borrowOrder;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productDetail;
@property (nonatomic, copy) NSString *debitDesc;
@property (nonatomic, copy) NSString *needData;
@property (nonatomic, copy) NSString *qualification;
@property (nonatomic, assign) long peopleNumber;
@property (nonatomic, copy) NSString *fastTime;
@property (nonatomic, copy) NSString *debitMoney;
@property (nonatomic, copy) NSString *debitTime;
@property (nonatomic, assign) double monthyRate;


@end
