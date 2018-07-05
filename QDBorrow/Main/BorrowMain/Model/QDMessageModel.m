//
//  QDMessageModel.m
//  QDBorrow
//
//  Created by larou on 2017/9/5.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDMessageModel.h"

@implementation QDMessageModel

- (instancetype)initWithBannerObject:(NSDictionary *)bmobObject {
    self = [super init];
    if (self) {
        self.messageType = [bmobObject objectForKey:@"message_type"];
        self.messageTitle = [bmobObject objectForKey:@"message_title"];
        self.messageTime = [bmobObject objectForKey:@"message_time"];
        self.messageContent = [bmobObject objectForKey:@"message_content"];
    }
    return self;
}

@end
