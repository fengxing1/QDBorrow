//
//  UIColor+Hex.h
//  RestApp
//
//  Created by xueyu on 16/4/12.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+(UIColor *)colorWithHeX:(long)hexColor;
+(UIColor *)colorWithHeX:(long)hexColor alpha:(float)alpha;
+ (UIColor *)colorWithHexString: (NSString *)color;
+ (UIColor *)colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;
@end
