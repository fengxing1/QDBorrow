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



typedef NS_ENUM(NSInteger,BorrowTimeType) {
    BorrowTimeTypeFiften = 1,
    BorrowTimeTypeThird
};
@interface QDHomeBorrowCell ()
@property (nonatomic, assign) NSInteger borrowCountIndex;
@property (nonatomic, strong) NSArray *borrowCountArray;
@property (nonatomic, strong) NSArray *borrowStringArray;
@property (nonatomic, strong) NSArray *processArray;
@property (nonatomic, copy) NSString *borrowCount;
@property (nonatomic, assign) BorrowTimeType borrowType;
@end

@implementation QDHomeBorrowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.goBorrowBtn.layer.cornerRadius = 5;
    self.goBorrowBtn.layer.masksToBounds = YES;
//    self.goBorrowBtn.backgroundColor = [UIColor colorWithHeX:0xFF523D];
    UIImage *image = [UIImage qmui_imageWithColor:[UIColor colorWithHeX:0xFF523D] size:CGSizeMake(12, 12) cornerRadius:6];
    
    self.borrowStringArray = @[@"1000元",@"2000元",@"3000元",@"4000元",@"5000元",@"6000元"] ;
    self.borrowCountArray = @[@1000,@2000,@3000,@4000,@5000,@6000] ;
    self.processArray = @[@100,@150,@200,@250,@300,@350];
    LiuXSlider *slider=[[LiuXSlider alloc] initWithFrame:CGRectMake(20, 225, SCREEN_WIDTH - 40,80 ) titles:self.borrowStringArray firstAndLastTitles:@[@"1000元",@"6000元"] defaultIndex:2 sliderImage:image];
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
    [self resetBorrowUI];
    
    
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
    NSInteger processCount = [self.processArray[self.borrowCountIndex] integerValue];
    NSInteger borrowCount = [self.borrowCountArray[self.borrowCountIndex] integerValue];
    if (self.borrowType == 2) {
        processCount = processCount * 2;
        self.timeLabel.text = @"30";
    } else {
        self.timeLabel.text = @"15";
    }
    self.totalFeeCountLabel.text = [NSString stringWithFormat:@"%ld",(processCount + borrowCount)];
    self.gainCountLabel.text = [NSString stringWithFormat:@"%ld",borrowCount];
    self.poundageCountLabel.text = [NSString stringWithFormat:@"%ld",processCount];
}


- (IBAction)goBorrowClick:(id)sender {
    //发起回调，去controller层发起网络请求
    NSInteger borrowCount = [self.borrowCountArray[self.borrowCountIndex] integerValue];
    self.block(self.borrowType, borrowCount);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
