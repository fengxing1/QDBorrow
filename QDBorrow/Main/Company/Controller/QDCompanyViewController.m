//
//  QDCompanyViewController.m
//  QDBorrow
//
//  Created by larou on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCompanyViewController.h"
#import "QDCompanyTableViewCell.h"
#import "QDCompanyDetailController.h"
#import "MBProgressHUD+MP.h"
#import "MJRefreshNormalHeader.h"
#import "QDHomeRequest.h"
#import "QDHomeList.h"
#import "YYModel.h"
#import "QDBorrowModel.h"
#import "QDUserManager.h"
#import "QDLoginOrRegisterViewController.h"
#import "QDRegisterViewController.h"
#import "UIAlertView+Block.h"
#import "YTKUrlClickRequest.h"
static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";

@interface QDCompanyViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) QDHomeList *homeList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QDCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self configData:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)configUI {
    self.title = @"找借贷";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    [self.tableView registerNib:[UINib nibWithNibName:@"QDCompanyTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCompanyCell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTable)];
}

- (void)refreshTable {
    [self configData:YES];
}

- (void)configData:(BOOL)bRefresh {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    QDHomeRequest *homeRequest = [[QDHomeRequest alloc] init];
    [homeRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        self.homeList = [QDHomeList yy_modelWithJSON:[request.responseJSONObject valueForKey:@"data"]];
        [self.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        [MBProgressHUD showError:request.error.localizedDescription ToView:self.view];
        //        [MBProgressHUD showError:request.error.localizedDescription ToView:self.view];
    }];
}


#pragma mark tableview datasoure and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.homeList && self.homeList.borrowVOList) {
        return  self.homeList.borrowVOList.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCompanyTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCompanyCell];
    companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    companyCell.borrowDtail = self.homeList.borrowVOList[indexPath.section];
    return companyCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 10;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断用户登录没，没有去登录
    if ([[QDUserManager sharedInstance] validateUser]) {
        QDBorrowModel *borrowModel = self.homeList.borrowVOList[indexPath.section];
        QDCompanyDetailController *companyDetailViewController = [[QDCompanyDetailController alloc] init];
        companyDetailViewController.id = borrowModel.id;
        [self sendClickUrl:borrowModel.id];
        [self.navigationController pushViewController:companyDetailViewController animated:YES];
    } else {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                QDLoginOrRegisterViewController *loginVC = [[QDLoginOrRegisterViewController alloc] init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }else if (buttonIndex == 1){
                QDRegisterViewController *loginVC = [[QDRegisterViewController alloc] init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
        } title:@"是否已有账号？" message:@"请选择是注册还是登录" cancelButtonName:@"去登录" otherButtonTitles:@"去注册", nil];
    }
    
}

- (void)sendClickUrl:(long)productId {
    YTKUrlClickRequest *request = [[YTKUrlClickRequest alloc] initWithCompany:productId type:1];
    [request startWithCompletionBlockWithSuccess:nil failure:nil];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        
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
