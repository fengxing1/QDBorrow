//
//  QDRegisterRequest.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2018/7/2.
//  Copyright © 2018年 jinrong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface QDRegisterRequest : YTKBaseRequest
- (id)initWithUsername:(NSString *)username password:(NSString *)password validate:(NSString *)validate;
@end
