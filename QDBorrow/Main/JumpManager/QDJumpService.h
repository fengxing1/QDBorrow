//
//  QDJumpService.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/21.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>
@interface QDJumpService : NSObject
+ (id)sharedInstance;
- (void)changeTabbarWithBlock:(BmobObjectResultBlock)block;
@end
