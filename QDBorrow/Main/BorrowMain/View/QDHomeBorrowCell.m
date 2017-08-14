//
//  QDHomeBorrowCell.m
//  QDBorrow
//
//  Created by larou on 2017/8/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDHomeBorrowCell.h"
#import "LiuXSlider.h"
#import "QMUICommonDefines.h"
#import "UIImage+QMUI.h"

@implementation QDHomeBorrowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    LiuXSlider *slider=[[LiuXSlider alloc] initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH - 40,80 ) titles:@[@"1000元",@"2000元",@"3000元",@"4000元",@"5000元",@"6000元"] firstAndLastTitles:@[@"1000",@"6000"] defaultIndex:1 sliderImage:[UIImage qmui_imageWithColor:UIColorMake(250, 58, 58)]];
    [self.contentView addSubview:slider];
    slider.block=^(int index){
        NSLog(@"当前index==%d",index);
    };
    
}
- (IBAction)fifteenDayClick:(id)sender {
}

- (IBAction)thirtyDayClick:(id)sender {
}

- (IBAction)goBorrowClick:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
