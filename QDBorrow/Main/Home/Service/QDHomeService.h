//
//  QDHomeService.h
//  QDBorrow
//
//  Created by larou on 2017/6/26.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface QDHomeService : NSObject

+ (id)sharedInstance;

- (void)saveHomeData;

- (void)homeBannerDataWithBlock:(BmobObjectArrayResultBlock)block ;

- (void)homeBorrowDataWithBlock:(BmobObjectArrayResultBlock)block ;
- (void)companyBorrowListWithBlock:(BmobObjectArrayResultBlock)block;

//阅读消息
- (void)messageDataWithBlock:(BmobObjectArrayResultBlock)block;

@end
