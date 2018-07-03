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

static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";
static NSString *const kReusableIdentifierChooseCell = @"chooseCell";
static NSString *const kReusableIdentifierRepaymentCell = @"repaymentCell";
static NSString *const kReusableIdentifierDescribeCell = @"multiLabelCell";
static NSString *const kReusableIdentifierIntroduceCell = @"introduceCell";
@interface QDCompanyDetailController ()
@property (nonatomic, strong) QDAmountOfCount *amountModel;
@property (nonatomic, strong) QMUIButton *normalButton;
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
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}


- (void)configUI {
    self.title = @"找借贷";
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"QDCompanyTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCompanyCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QDChooseTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierChooseCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QDRepaymentInfoTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierRepaymentCell];
    [self.tableView registerClass:[QDMultiLabelCell class] forCellReuseIdentifier:kReusableIdentifierDescribeCell];
    [self.tableView registerClass:[QDProductIntroduceCell class] forCellReuseIdentifier:kReusableIdentifierIntroduceCell];
    [self createBottomButton];
   
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.tableView.tableFooterView = footerView;
}

- (void)configData {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    QDCompanyDetailRequest *request = [[QDCompanyDetailRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view];
         if ([[request.responseObject valueForKey:@"code"] integerValue] == 1000) {
             self.companyInfoModel = [QDCompanyDetailModel yy_modelWithJSON:[request.responseJSONObject valueForKey:@"data"]];
             self.title = self.companyInfoModel.productName;
             self.currentMonth = [[self.companyInfoModel.debitMoney componentsSeparatedByString:@","].firstObject longLongValue];
             self.currentMoney = [[self.companyInfoModel.debitMoney componentsSeparatedByString:@","].firstObject longLongValue];
             [self.tableView reloadData];
         } else {
             [MBProgressHUD showMessage:[request.responseJSONObject valueForKey:@"desc"] ToView:self.view RemainTime:2.0];
         }
       
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showError:request.error.localizedDescription ToView:self.view];
        //        [MBProgressHUD showError:request.error.localizedDescription ToView:self.view];
    }];
//    self.amountModel = [[QDAmountOfCount alloc] init];
//    self.amountModel.maxMoneyCount = self.borrowModel.maxMoney;
//    self.amountModel.minMoneyCount = self.borrowModel.minMoney;
//    self.amountModel.moneyCount = self.borrowModel.minMoney;
//    self.amountModel.amortizationNumArray = self.borrowModel.amortizationNumArray;
//    self.amountModel.mounthCount = [self.borrowModel.amortizationNumArray[0] integerValue];
//
//    self.installModel = [[QDInstallmentModel alloc] init];
//    self.installModel.moneyCount = self.borrowModel.minMoney;
//    self.installModel.installCount = [self.borrowModel.amortizationNumArray[0] integerValue];
//    self.installModel.interest = self.borrowModel.monthyRate;
//    self.installModel.fastTimeStr = self.borrowModel.fastestTime;
    
}


- (void)createBottomButton {
    
    self.normalButton = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 50))];
    self.normalButton.adjustsButtonWhenHighlighted = YES;
    self.normalButton.titleLabel.font = UIFontBoldMake(14);
    [self.normalButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
    self.normalButton.backgroundColor = UIColorBlue;
    self.normalButton.highlightedBackgroundColor = UIColorMake(0, 168, 225);// 高亮时的背景色
    self.normalButton.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [self.view addSubview:self.normalButton];
    [self.normalButton addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.normalButton setTitle:@"申请贷款" forState:UIControlStateNormal];
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

//评估页面
- (void)toEstimateQualification {
    //先进行登录校验
    if ([BmobUser currentUser]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            QDPersionViewController *persionVC = [[QDPersionViewController alloc] init];
            persionVC.persionInfoType = PersionInfoTypePersional;
            __weak typeof(self) weakSelf = self;
            [weakSelf.navigationController pushViewController:persionVC animated:YES];
        } title:@"提示" message:@"为了准确为你评估贷款资格和额度，请准确如实填写相应资料！" cancelButtonName:@"确定" otherButtonTitles:nil];
    } else {
        QDLoginOrRegisterViewController *loginVC = [[QDLoginOrRegisterViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
}

//产品页面
- (void)toProductDetail {
    NSString *redirectUrl = self.companyInfoModel.url;
    if (!([redirectUrl containsString:@"http"] || [redirectUrl containsString:@"https"])) {
        redirectUrl = [@"http://" stringByAppendingString:redirectUrl];
    }
    QDWebViewController *webViewController = [[QDWebViewController alloc] initWithURL:[NSURL URLWithString:redirectUrl]];
    [self.navigationController pushViewController:webViewController animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
