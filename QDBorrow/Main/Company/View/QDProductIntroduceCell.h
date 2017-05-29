//
//  QDProductIntroduceCell.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/29.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDProductIntroduceCell : UITableViewCell

@property (nonatomic, strong) UILabel *instroduceLabel;
@property (nonatomic, copy) NSString *productIntroduce;

+ (CGFloat)heightOfCellWithIntroduce:(NSString *)introduce;

@end
