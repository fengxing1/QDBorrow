//
//  QDPersionViewController.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCommonGroupListViewController.h"
typedef  NS_ENUM(NSInteger, PersionInfoType) {
    PersionInfoTypePersional = 0,
    PersionInfoTypeAssets
};


@interface QDPersionViewController : QDCommonGroupListViewController
@property (nonatomic, assign) PersionInfoType persionInfoType;
@property (nonatomic, strong) NSMutableDictionary *recordInfo;
@property (nonatomic, strong) NSArray *persionInfo;

@end
