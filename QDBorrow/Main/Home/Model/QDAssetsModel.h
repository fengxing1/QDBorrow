//
//  QDAssetsModel.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AssetsInfo : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *choiceList;

@end

@interface QDAssetsModel : NSObject
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSMutableArray *array;

@end
