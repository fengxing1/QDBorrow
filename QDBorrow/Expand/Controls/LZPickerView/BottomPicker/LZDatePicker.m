


//
//  LZDatePicker.m
//  LZPickerView
//
//  Created by goldeneye on 2017/3/2.
//  Copyright © 2017年 goldeneye by smart-small. All rights reserved.
//

#import "LZDatePicker.h"
#import "LZToolbar.h"

@interface LZDatePicker()
{


}



/**  数据源   **/
@property(nonatomic,strong)NSMutableArray * dataArray;
/**  容器 **/
@property(nonatomic,strong)UIView * containerView;
/**  背景蒙版 **/
@property(nonatomic,strong)UIView * maskView;
/**  toolBar **/
@property(nonatomic,strong)LZToolbar * toolBar;
/**  选中的row **/
@property (nonatomic,assign)NSInteger selectRow;

@property(nonatomic,assign)UIDatePickerMode defaultTimeMode;
/**  记录选择的日期 **/
@property(nonatomic,strong)NSDate * choseDate;

@end
@implementation LZDatePicker

- (instancetype)initWithFrame:(CGRect)frame
{
    
    [self initToolBar];
    [self initMaskView];
    self = [super initWithFrame:frame];
    if (self) {
        
        self.defaultTimeMode = UIDatePickerModeTime;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
        
        
        [self initContainerView];
    }
    return self;
}
- (void)initToolBar{
    self.toolBar = [[LZToolbar alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 44)];
    self.toolBar.translucent = NO;
}
- (void)initMaskView{
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kISCREEN_HEIGHT)];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.maskView.userInteractionEnabled = YES;
    [ self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWithAnimation)]];
}

- (void)initContainerView{
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, kISCREEN_HEIGHT - self.frame.size.height - 44, kSCREEN_WIDTH, self.frame.size.height + self.toolBar.frame.size.height)];
}


#pragma mark - Action
- (void)showWithDatePickerMode:(UIDatePickerMode)mode compltedBlock:(void (^)(NSDate *choseDate))compltedBlock cancelBlock:(void (^)())cancelBlock{
    
    self.datePickerMode = mode;
    //默认为0
    self.selectRow = 0;
    
    [self showWithAnimation];
    
    __weak typeof(self) weakSelf = self;
    //点击取消回掉
    [self.toolBar setCancelBlock:^{
        if (cancelBlock) {
            [weakSelf hiddenWithAnimation];
            cancelBlock();
        }
    }];
    //点击确定提交
    [self.toolBar setCommitBlock:^{
        if (compltedBlock) {
            [weakSelf hiddenWithAnimation];
            
            compltedBlock(weakSelf.choseDate);
            
        }
    }];
}
//时间选择器滚动改变
- (void)dateChanged:(id)sender{
    
    NSDate* _date = self.date;
    
    self.choseDate = _date;
    
    NSLog(@"_date====%@",_date);
    
    /*添加你自己响应代码*/
}
- (void)showWithAnimation{
    
    [self addViews];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    CGFloat height = self.containerView.frame.size.height;
    self.containerView.center = CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT + height / 2);
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT - height / 2);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
}
- (void)hiddenWithAnimation
{
    CGFloat height = self.containerView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.center = CGPointMake(kSCREEN_WIDTH / 2, kISCREEN_HEIGHT + height / 2);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self hiddenViews];
    }];
    
}
- (void)addViews{
    [self removeFromSuperview];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.containerView];
    [self.containerView addSubview:self.toolBar];
    [self.containerView addSubview:self];
    self.frame = CGRectMake(0, 44, kSCREEN_WIDTH, 216);
    
}
- (void)hiddenViews {
    [self removeFromSuperview];
    [self.toolBar removeFromSuperview];
    [self.maskView removeFromSuperview];
    [self.containerView removeFromSuperview];
}

#pragma mark lazy

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
