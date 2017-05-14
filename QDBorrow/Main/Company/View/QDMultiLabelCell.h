//
//  QDMultiLabelCell.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/14.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDMultiLabelCell : UITableViewCell
@property (nonatomic, strong) NSArray *multiStrArray;

+ (CGFloat)heightOfCell:(NSArray *)multiStrArray;

@end
