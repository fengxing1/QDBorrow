//
//  QDHelpModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface QDHelpInfoModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<NSString *> *answer;

@end
@interface QDHelpModel : NSObject
@property (nonatomic, strong) NSArray<QDHelpInfoModel *> *list;
@property (nonatomic, copy) NSString *total_page;


@end
