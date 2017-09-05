//
//  QDMessageModel.h
//  QDBorrow
//
//  Created by larou on 2017/9/5.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface QDMessageModel : NSObject
@property (nonatomic, strong) NSString *messageType;
@property (nonatomic, strong) NSString *messageTitle;
@property (nonatomic, strong) NSString *messageContent;
@property (nonatomic, strong) NSString *messageTime;

- (instancetype)initWithBannerObject:(BmobObject *)bmobObject;
@end
