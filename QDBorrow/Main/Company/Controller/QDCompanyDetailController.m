//
//  QDCompanyDetailController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/14.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCompanyDetailController.h"
#import "QDCompanyTableViewCell.h"
#import "QDChooseTableViewCell.h"
#import "QDRepaymentInfoTableViewCell.h"
#import "QDMultiLabelCell.h"
#import "QDUIHelper.h"
#import "QDWebViewController.h"
#import "LZPickViewManager.h"
#import "QDProductIntroduceCell.h"
#import "QDPersionViewController.h"
#import "UIAlertView+Block.h"
#import "QDLoginOrRegisterViewController.h"
#import "QDCompanyDetailRequest.h"
#import "QDCompanyDetailModel.h"
#import "YYModel.h"
#import "BaiduMobStat.h"
#import "Const.h"
#import "YTKUrlClickRequest.h"

static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";
static NSString *const kReusableIdentifierChooseCell = @"chooseCell";
static NSString *const kReusableIdentifierRepaymentCell = @"repaymentCell";
static NSString *const kReusableIdentifierDescribeCell = @"multiLabelCell";
static NSString *const kReusableIdentifierIntroduceCell = @"introduceCell";
@interface QDCompanyDetailController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QDAmountOfCount *amountModel;
@property (nonatomic, strong) UIButton *normalButton;
@property (nonatomic, strong) QDCompanyDetailModel *companyInfoModel;

@property (nonatomic, strong) NSArray *moneyCountArray;
//记录选择的金额
@property (nonatomic, assign) long currentMoney;
//借了选择日期
@property (nonatomic, assign) long currentMonth;

@end

@implementation QDCompanyDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self configData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)configUI {
    self.title = @"找借贷";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"QDCompanyTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCompanyCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QDChooseTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierChooseCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QDRepaymentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierRepaymentCell];
    [self.tableView registerClass:[QDMultiLabelCell class] forCellReuseIdentifier:kReusableIdentifierDescribeCell];
    [self.tableView registerClass:[QDProductIntroduceCell class] forCellReuseIdentifier:kReusableIdentifierIntroduceCell];

}

- (void)configData {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    QDCompanyDetailRequest *request = [[QDCompanyDetailRequest alloc] initWithCompany:self.id];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view];
         if ([[request.responseObject valueForKey:@"code"] integerValue] == 1000) {
             self.companyInfoModel = [QDCompanyDetailModel yy_modelWithJSON:[request.responseJSONObject valueForKey:@"data"]];
             self.title = self.companyInfoModel.productName;
             self.currentMonth = [[self.companyInfoModel.debitMoney componentsSeparatedByString:@","].firstObject longLongValue];
             self.currentMoney = [[self.companyInfoModel.debitMoney componentsSeparatedByString:@","].firstObject longLongValue];
             [self.tableView reloadData];
             [self createBottomView];
         } else {
             [MBProgressHUD showMessage:[request.responseJSONObject valueForKey:@"desc"] ToView:self.view RemainTime:2.0];
         }
       
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:request.error.localizedDescription ToView:self.view];
        //        [MBProgressHUD showError:request.error.localizedDescription ToView:self.view];
    }];
    
}

- (void)createBottomView {
    UIView *view = [[UIView alloc] init];
    if(iPhoneX) {
        view.frame = CGRectMake(0, SCREEN_HEIGHT - 1 - 50 - 22,SCREEN_WIDTH , 50);
    } else {
        view.frame = CGRectMake(0, SCREEN_HEIGHT - 1 - 50,SCREEN_WIDTH , 50);
    }
    
    [view addSubview:self.normalButton];
    [self.view addSubview:view];
}

#pragma mark tableview datasoure and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.companyInfoModel) {
        return 4;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            QDCompanyTableViewCell *companyCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCompanyCell];
            companyCell.borrowDtail = self.companyInfoModel;
            companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return companyCell;
        }
        else if (indexPath.row == 1) {
            QDChooseTableViewCell *chooseCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierChooseCell];
            chooseCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            chooseCell.cellType = 0;
            chooseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            chooseCell.countArray = [self.companyInfoModel.debitMoney componentsSeparatedByString:@","];
            return chooseCell;
        } else if (indexPath.row == 2) {
            QDChooseTableViewCell *chooseCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierChooseCell];
            chooseCell.cellType = 1;
            chooseCell.countArray = [self.companyInfoModel.debitTime componentsSeparatedByString:@","];
            chooseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            chooseCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return chooseCell;
        } else {
            QDRepaymentInfoTableViewCell *repaymentCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierRepaymentCell];
            [repaymentCell setMoney:self.currentMoney time:self.currentMonth rate:self.companyInfoModel.monthyRate];
            repaymentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return repaymentCell;
        }
    }
    else if (indexPath.section == 1){
        QDProductIntroduceCell *introductCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierIntroduceCell];
        introductCell.productIntroduce = self.companyInfoModel.qualification;
        introductCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return introductCell;
    } else if (indexPath.section == 2){
        QDProductIntroduceCell *introductCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierIntroduceCell];
        introductCell.productIntroduce = self.companyInfoModel.needData;
        introductCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return introductCell;
    } else if (indexPath.section == 3) {
        QDProductIntroduceCell *introductCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierIntroduceCell];
        introductCell.productIntroduce = self.companyInfoModel.debitDesc;
        introductCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return introductCell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 110;
        } else if (indexPath.row == 1 || indexPath.row == 2){
            return 52;
        } else {
            return 70;
        }
    } else if (indexPath.section == 1){
        CGFloat height = [QDProductIntroduceCell heightOfCellWithIntroduce:self.companyInfoModel.qualification];
        return height;
        return height;
    } else if (indexPath.section == 2) {
        CGFloat height = [QDProductIntroduceCell heightOfCellWithIntroduce:self.companyInfoModel.needData];
        return height;
        return height;
    } else if (indexPath.section == 3) {
        CGFloat height = [QDProductIntroduceCell heightOfCellWithIntroduce:self.companyInfoModel.debitDesc];
        return height;
    }
    return  0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 40;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *titleView = [self createHeaderView:@"申请资格"];
        return titleView;
    } else if (section == 2) {
        UIView *titleView = [self createHeaderView:@"所需材料"];
        return titleView;
    } else if (section == 3) {
        UIView *titleView = [self createHeaderView:@"产品介绍"];
        return titleView;
    }
    return nil;
}

- (UIView *)createHeaderView:(NSString *)title {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [view addSubview:whiteView];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 10, SCREEN_WIDTH - 20, 15);
    label.textColor = TableViewCellTitleLabelColor;
    label.font = [UIFont systemFontOfSize:12];
    label.text = title;
    [whiteView addSubview:label];
    return view;
    
}


- (void)bottomBtnClick {
    [self toProductDetail];
}


//产品页面
- (void)toProductDetail {
    [[BaiduMobStat defaultStat] logEvent:[NSString stringWithFormat:@"%ld",self.id] eventLabel:self.companyInfoModel.productName];
    [self sendUrlClick];
    NSString *redirectUrl = self.companyInfoModel.url;
    if (!([redirectUrl containsString:@"http"] || [redirectUrl containsString:@"https"])) {
        redirectUrl = [@"http://" stringByAppendingString:redirectUrl];
    }
    QDWebViewController *webViewController = [[QDWebViewController alloc] initWithURL:[NSURL URLWithString:redirectUrl]];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)sendUrlClick {
    YTKUrlClickRequest *request  = [[YTKUrlClickRequest alloc] initWithCompany:self.id];
    [request startWithCompletionBlockWithSuccess:nil failure:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //弹出选择器，然后刷新页面数据
        if (indexPath.row == 1) {
            //初始化数组
            self.moneyCountArray = [self.companyInfoModel.debitMoney componentsSeparatedByString:@","];
            [[LZPickViewManager sharePickViewManager] showPickViewWithSigleArray:self.moneyCountArray compltedBlock:^(NSString *compltedString) {
                NSInteger amount = [compltedString integerValue];
                self.amountModel.moneyCount = amount;
                self.currentMoney = amount;
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
            } cancelBlock:nil];
        } else if (indexPath.row == 2) {
            [[LZPickViewManager sharePickViewManager] showPickViewWithSigleArray:[self.companyInfoModel.debitTime componentsSeparatedByString:@","] compltedBlock:^(NSString *compltedString) {
                NSInteger amount = [compltedString integerValue];
                self.amountModel.mounthCount = amount;
                self.currentMonth = amount;
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
            } cancelBlock:nil];
            
        }
        
    }
}

- (UIButton *)normalButton {
    if (!_normalButton) {
        _normalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _normalButton.titleLabel.font = UIFontBoldMake(14);
        [_normalButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
        _normalButton.backgroundColor = UIColorRed;
        //    self.normalButton.highlightedBackgroundColor = UIColorMake(0, 168, 225);// 高亮时的背景色
        _normalButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        [_normalButton addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_normalButton setTitle:@"申请贷款" forState:UIControlStateNormal];
    }
    return _normalButton;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    }
    return _tableView;
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
