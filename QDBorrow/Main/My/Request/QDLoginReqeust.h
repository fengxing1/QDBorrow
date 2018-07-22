//
//  QDLoginReqeust.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/2.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import "QDBaseRequest.h"

@interface QDLoginReqeust : QDBaseRequest
- (id)initWithUsername:(NSString *)username password:(NSString *)password;
@end
