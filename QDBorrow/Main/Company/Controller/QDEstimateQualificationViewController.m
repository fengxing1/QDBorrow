//
//  QDEstimateQualificationViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/12.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDEstimateQualificationViewController.h"
#import "QMUIKit.h"
#import "QDPersionViewController.h"
#import "QDCompanyDetailController.m"

@interface QDEstimateQualificationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic, strong) QMUIButton *normalButton;

@end

@implementation QDEstimateQualificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"验资申请成功";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)configUI {
    self.normalButton = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 50))];
    self.normalButton.adjustsButtonWhenHighlighted = YES;
    self.normalButton.titleLabel.font = UIFontBoldMake(14);
    [self.normalButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
    self.normalButton.backgroundColor = UIColorBlue;
    self.normalButton.highlightedBackgroundColor = UIColorMake(0, 168, 225);// 高亮时的背景色
    self.normalButton.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [self.view addSubview:self.normalButton];
    [self.normalButton addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.normalButton setTitle:@"关闭" forState:UIControlStateNormal];
}

- (void)bottomBtnClick {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[QDCompanyDetailController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
