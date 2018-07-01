//
//  QDBorrowModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/1.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDBorrowModel : NSObject
@property (nonatomic, assign) long id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSInteger borrowOrder;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productDetail;
@property (nonatomic, assign) long peopleNumber;
@property (nonatomic, assign) double monthyRate;

@end
