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
#import "UIColor+Hex.h"

typedef void(^borrowWay)(int borrowType,NSString *borrowCount);

typedef NS_ENUM(NSInteger,BorrowTimeType) {
    BorrowTimeTypeFiften = 1,
    BorrowTimeTypeThird
};
@interface QDHomeBorrowCell ()
@property (nonatomic, assign) NSInteger borrowCountIndex;
@property (nonatomic, strong) NSArray *borrowCountArray;
@property (nonatomic, copy) NSString *borrowCount;
@property (nonatomic, assign) BorrowTimeType borrowType;
@property (nonatomic,copy) borrowWay block;
@end

@implementation QDHomeBorrowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *image = [UIImage qmui_imageWithColor:[UIColor colorWithHeX:0xFF523D] size:CGSizeMake(12, 12) cornerRadius:6];
    self.borrowCountArray = @[@"1000元",@"2000元",@"3000元",@"4000元",@"5000元",@"6000元"] ;
    LiuXSlider *slider=[[LiuXSlider alloc] initWithFrame:CGRectMake(20, 225, SCREEN_WIDTH - 40,80 ) titles:self.borrowCountArray firstAndLastTitles:@[@"1000",@"6000"] defaultIndex:2 sliderImage:image];
    [self.contentView addSubview:slider];
    slider.block=^(int index){
        self.borrowCount = self.borrowCountArray[index];
        self.borrowCountIndex = index;
        [self resetBorrowUI];
    };
    self.borrowCountIndex = 2;
    self.fifteenDayBtn.layer.cornerRadius = 5;
    self.fifteenDayBtn.layer.masksToBounds = YES;
    self.thirtyDayBtn.layer.cornerRadius = 5;
    self.thirtyDayBtn.layer.masksToBounds = YES;
    [self selectFiftenBtn:YES];
    self.borrowType = BorrowTimeTypeFiften;
    
    
}

- (void)selectFiftenBtn:(BOOL)bSelect {
    if (bSelect) {
        [self.fifteenDayBtn setBackgroundColor:[UIColor colorWithHeX:0xFFBDB7]];
        [self.thirtyDayBtn setBackgroundColor:[UIColor whiteColor]];
        self.thirtyDayBtn.layer.borderWidth = 1;
        self.thirtyDayBtn.layer.borderColor = [UIColor grayColor].CGColor;
        self.fifteenDayBtn.layer.borderWidth = 0.0;
    }else {
        [self.fifteenDayBtn setBackgroundColor:[UIColor whiteColor]];
        [self.thirtyDayBtn setBackgroundColor:[UIColor colorWithHeX:0xFFBDB7]];
        self.fifteenDayBtn.layer.borderWidth = 1;
        self.fifteenDayBtn.layer.borderColor = [UIColor grayColor].CGColor;
        self.thirtyDayBtn.layer.borderWidth = 0.0;
    }
}
- (IBAction)fifteenDayClick:(id)sender {
    self.borrowType = 1;
    [self selectFiftenBtn:YES];
    [self resetBorrowUI];
}

- (IBAction)thirtyDayClick:(id)sender {
    self.borrowType = 2;
    [self selectFiftenBtn:NO];
    [self resetBorrowUI];
}

- (void)resetBorrowUI {
    
}


- (IBAction)goBorrowClick:(id)sender {
    //发起回调，去controller层发起网络请求
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
