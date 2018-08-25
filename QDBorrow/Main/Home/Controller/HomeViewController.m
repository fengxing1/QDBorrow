//
//  HomeViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/6.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "HomeViewController.h"
#import "QMUIKit.h"
#import "QDCommonTableViewController.h"
#import "QDHomeModel.h"
#import "YYModel.h"
#import "UIAlertView+Block.h"
#import "QDBannerTableViewCell.h"
#import "QDWebViewController.h"
#import "QBBusinessTableViewCell.h"
#import "QDCompanyDetailController.h"
#import "MBProgressHUD+MP.h"
#import "MJRefreshNormalHeader.h"
#import "QDHomeRequest.h"
#import "QDHomeList.h"
#import "YYModel.h"
#import "QDUserManager.h"
#import "QDLoginOrRegisterViewController.h"
#import "QDRegisterViewController.h"
#import "YTKUrlClickRequest.h"

static NSString *const kReusableIdentifierBannerCell  = @"bannerCell";
static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource,CellOfBannerDelgate>

@property(nonatomic, strong) QMUIButton *registButton;
@property(nonatomic, strong) QMUIButton *loginButton;
@property(nonatomic, strong) QMUIButton *statusButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) QDHomeList *homeList;

@end



@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self confirmUI];
    [self configData];
    
//    [self addBorrorData];
//    [self addCerList];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)configData {
    
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


- (void)confirmUI {
    self.title = @"首页";
    //初始化tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[QDBannerTableViewCell class] forCellReuseIdentifier:kReusableIdentifierBannerCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QBBusinessTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCompanyCell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
}

#pragma mark - <QMUITableViewDataSource,QMUITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.homeList) {
        if (section == 0) {
            if (self.homeList.bannerVOList && self.homeList.bannerVOList.count) {
                return 1;
            }
            return 0;
        } else {
            if (self.homeList.borrowVOList && self.homeList.borrowVOList.count) {
                return self.homeList.borrowVOList.count;
            }
            return 0;
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QDBannerTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierBannerCell];
        bannerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        bannerCell.bannerList = self.homeList.bannerVOList;
        bannerCell.delegate = self;
        return bannerCell;
    } else {
        QBBusinessTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCompanyCell];
        companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.homeList.borrowVOList.count >= indexPath.row) {
            companyCell.borrowModel = self.homeList.borrowVOList[indexPath.row];
        }
        return companyCell;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200 * SCREEN_WIDTH / 375;
    } else {
        return 76;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"热门借贷";
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        //判断用户登录没，没有去登录
        if ([[QDUserManager sharedInstance] validateUser]) {
            QDBorrowModel *borrowModel = self.homeList.borrowVOList[indexPath.row];
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
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _tableView;
}



- (void)cellOfBannerClick:(QDBannerModel *)banner {
    //先对登录进行判断，有登录了才可以点击进去
    if ([[QDUserManager sharedInstance] validateUser]) {
        //异步发送点击请求
        [self sendClickUrl:banner.id];
        //轮播图片点击事件
        NSString *redirectUrl = banner.url;
        if (!([redirectUrl containsString:@"http"] || [redirectUrl containsString:@"https"])) {
            redirectUrl = [@"http://" stringByAppendingString:redirectUrl];
        }
        QDWebViewController *webViewController = [[QDWebViewController alloc] initWithURL:[NSURL URLWithString:redirectUrl]];
        webViewController.showsToolBar = NO;
        webViewController.navigationController.navigationBar.translucent = NO;
        [self.navigationController pushViewController:webViewController animated:YES];
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

@end
