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
#import "QDInstallmentModel.h"
#import "QDUIHelper.h"
#import "QDWebViewController.h"
#import "LZPickViewManager.h"
#import "QDProductIntroduceCell.h"
#import "QDPersionViewController.h"
#import "UIAlertView+Block.h"

static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";
static NSString *const kReusableIdentifierChooseCell = @"chooseCell";
static NSString *const kReusableIdentifierRepaymentCell = @"repaymentCell";
static NSString *const kReusableIdentifierDescribeCell = @"multiLabelCell";
static NSString *const kReusableIdentifierIntroduceCell = @"introduceCell";
@interface QDCompanyDetailController ()
@property (nonatomic, strong) QDAmountOfCount *amountModel;
@property (nonatomic, strong) QDInstallmentModel *installModel;
@property(nonatomic, strong) QMUIButton *normalButton;

@property (nonnull, strong)NSMutableArray *moneyCountArray;

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
    self.amountModel = [[QDAmountOfCount alloc] init];
    self.amountModel.maxMoneyCount = self.borrowModel.maxMoney;
    self.amountModel.minMoneyCount = self.borrowModel.minMoney;
    self.amountModel.moneyCount = self.borrowModel.minMoney;
    self.amountModel.amortizationNumArray = self.borrowModel.amortizationNumArray;
    self.amountModel.mounthCount = [self.borrowModel.amortizationNumArray[0] integerValue];
    
    self.installModel = [[QDInstallmentModel alloc] init];
    self.installModel.moneyCount = self.borrowModel.minMoney;
    self.installModel.installCount = [self.borrowModel.amortizationNumArray[0] integerValue];
    self.installModel.interest = self.borrowModel.monthyRate;
    self.installModel.fastTimeStr = self.borrowModel.fastestTime;
    
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
    if (self.borrowModel.showButton) {
        [self.normalButton setTitle:@"申请贷款" forState:UIControlStateNormal];
    } else {
        [self.normalButton setTitle:@"评估贷款资格" forState:UIControlStateNormal];
    }
}

#pragma mark tableview datasoure and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
            companyCell.borrowDtail = self.borrowModel;
            companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            companyCell.bShowInDetail = YES;
            return companyCell;
        }
        else if (indexPath.row == 1) {
            QDChooseTableViewCell *chooseCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierChooseCell];
            chooseCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            chooseCell.cellType = 0;
            chooseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            chooseCell.amountCount = self.amountModel;
            return chooseCell;
        } else if (indexPath.row == 2) {
            QDChooseTableViewCell *chooseCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierChooseCell];
            chooseCell.cellType = 1;
            chooseCell.amountCount = self.amountModel;
            chooseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            chooseCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return chooseCell;
        } else {
            QDRepaymentInfoTableViewCell *repaymentCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierRepaymentCell];
            repaymentCell.installmentModel = self.installModel;
            repaymentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return repaymentCell;
        }
    }
    else if (indexPath.section == 1){
        QDProductIntroduceCell *introductCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierIntroduceCell];
        introductCell.productIntroduce = self.borrowModel.qualification;
        introductCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return introductCell;
    } else if (indexPath.section == 2){
        QDProductIntroduceCell *introductCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierIntroduceCell];
        introductCell.productIntroduce = self.borrowModel.needdata;
        introductCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return introductCell;
    } else if (indexPath.section == 3) {
        QDProductIntroduceCell *introductCell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierIntroduceCell];
        introductCell.productIntroduce = self.borrowModel.companyIntroduce;
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
        CGFloat height = [QDProductIntroduceCell heightOfCellWithIntroduce:self.borrowModel.qualification];
        return height;
        return height;
    } else if (indexPath.section == 2) {
        CGFloat height = [QDProductIntroduceCell heightOfCellWithIntroduce:self.borrowModel.needdata];
        return height;
        return height;
    } else if (indexPath.section == 3) {
        CGFloat height = [QDProductIntroduceCell heightOfCellWithIntroduce:self.borrowModel.companyIntroduce];
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
    if (self.borrowModel.showButton && self.borrowModel.redirectUrl) {
        [self toProductDetail];
    } else {
        [self toEstimateQualification];
    }
}

//评估页面
- (void)toEstimateQualification {
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        <#code#>
    } title:@"提示" message:@"" cancelButtonName:<#(NSString *)#> otherButtonTitles:<#(NSString *), ...#>, nil]
    QDPersionViewController *persionVC = [[QDPersionViewController alloc] init];
    persionVC.persionInfoType = PersionInfoTypePersional;
    [self.navigationController pushViewController:persionVC animated:YES];
}

//产品页面
- (void)toProductDetail {
    NSString *redirectUrl = self.borrowModel.redirectUrl;
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
            if (!self.moneyCountArray) {
                self.moneyCountArray = [[NSMutableArray alloc] init];
                for (int i = (int)self.borrowModel.minMoney/1000 ; i <= self.borrowModel.maxMoney/1000; i ++) {
                    [self.moneyCountArray addObject:[NSString stringWithFormat:@"%d",i*1000]];
                }
            }
            [[LZPickViewManager sharePickViewManager] showPickViewWithSigleArray:self.moneyCountArray compltedBlock:^(NSString *compltedString) {
                NSInteger amount = [compltedString integerValue];
                self.amountModel.moneyCount = amount;
                self.installModel.moneyCount = amount;
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
            } cancelBlock:nil];
        } else if (indexPath.row == 2) {
            [[LZPickViewManager sharePickViewManager] showPickViewWithSigleArray:self.borrowModel.amortizationNumArray compltedBlock:^(NSString *compltedString) {
                NSInteger amount = [compltedString integerValue];
                self.amountModel.mounthCount = amount;
                self.installModel.installCount = amount;
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
