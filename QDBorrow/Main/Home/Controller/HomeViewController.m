//
//  HomeViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/6.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginService.h"
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
#import <BmobSDK/Bmob.h>
#import "QDHomeService.h"
#import "QDHomeRequest.h"
#import "QDHomeList.h"
#import "YYModel.h"

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
    [self.tabBarController.tabBar setHidden:NO];
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
    
//    if (self.homeModel == nil) {
//        self.homeModel = [[QDHomeModel alloc] init];
//    }
//    if (self.homeModel.bannerArray == nil) {
//        self.homeModel.bannerArray = [[NSMutableArray alloc] init];
//    } else {
//        [self.homeModel.bannerArray removeAllObjects];
//    }
//    if (self.homeModel.borrowDetailArray == nil) {
//        self.homeModel.borrowDetailArray = [[NSMutableArray alloc] init];
//    } else {
//        [self.homeModel.borrowDetailArray removeAllObjects];
//    }
//    [[QDHomeService sharedInstance] homeBannerDataWithBlock:^(NSArray *array, NSError *error) {
//        if ([self.tableView.mj_header isRefreshing]) {
//            [self.tableView.mj_header endRefreshing];
//        }
//
//        if (!error) {
//            [self.homeModel.bannerArray removeAllObjects];
//            [self.homeModel.borrowDetailArray removeAllObjects];
//            for (BmobObject *bmBanner in array) {
//                QDHomeBannerModel *bannerModel = [[QDHomeBannerModel alloc] initWithBannerObject:bmBanner];
//                [self.homeModel.bannerArray addObject:bannerModel];
//            }
//            [[QDHomeService sharedInstance] homeBorrowDataWithBlock:^(NSArray *array, NSError *error) {
//                if (!error) {
//                    for (BmobObject *bmBorrrow in array) {
//                        BorrowDetailModel *detail = [[BorrowDetailModel alloc] initWithBmObject:bmBorrrow];
//                        [self.homeModel.borrowDetailArray addObject:detail];
//                    }
//                     [self.tableView reloadData];
//                }
//                [MBProgressHUD hideHUDForView:self.view];
//
//            }];
//        } else {
//            [MBProgressHUD hideHUDForView:self.view];
//            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//                if (buttonIndex) {
//                    [self configData];
//                }
//            } title:@"提示" message:@"网络还/Users/shuai/WorkSpace/iOS/QDBorrow/QDBorrow/Main/Home/Controller/HomeViewController.m没被允许，请确认！" cancelButtonName:@"取消" otherButtonTitles:@"重新刷新", nil];
//        }
//    }];
}

- (void)addBorrorData {
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
//    self.registButton = [[QMUIButton alloc] init];
//    self.registButton.titleLabel.font = UIFontMake(15);
//    self.registButton.adjustsTitleTintColorAutomatically = YES;
//    [self.registButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.registButton setTitle:@"注册" forState:UIControlStateNormal];
//    self.registButton.frame = CGRectMake(0, 100, 200, 60);
//    [self.registButton addTarget:self action:@selector(registerUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.registButton];
//    
//    self.loginButton = [[QMUIButton alloc] init];
//    self.loginButton.titleLabel.font = UIFontMake(15);
//    self.loginButton.adjustsTitleTintColorAutomatically = YES;
//    [self.loginButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.loginButton setTitle:@"登陆" forState:UIControlStateNormal];
//    self.loginButton.frame = CGRectMake(0, 170, 200, 60);
//    [self.loginButton addTarget:self action:@selector(loginUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.loginButton];
//    
//    self.statusButton = [[QMUIButton alloc] init];
//    self.statusButton.titleLabel.font = UIFontMake(15);
//    self.statusButton.adjustsTitleTintColorAutomatically = YES;
//    [self.statusButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.statusButton setTitle:@"状态" forState:UIControlStateNormal];
//    self.statusButton.frame = CGRectMake(0, 230, 200, 60);
//    [self.statusButton addTarget:self action:@selector(loginUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.statusButton];
//    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        BorrowDetailModel *borrowModel = self.homeList.borrowVOList[indexPath.row];
        QDCompanyDetailController *companyDetailViewController = [[QDCompanyDetailController alloc] init];
//        companyDetailViewController.borrowModel = borrowModel;
        [self.navigationController pushViewController:companyDetailViewController animated:YES];
    }
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    return _tableView;
}


//- (void)registerUserClick {
//    LoginService *loginService = [[LoginService alloc] init];
//    [loginService registUser:@"dashuai" password:@"123456" email:@"feng_xing@126.com" block:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            NSLog(@"注册成功");
//        }else {
//            
//        }
//    }];
//}
//
//- (void)loginUserClick {
//    LoginService *loginService = [[LoginService alloc] init];
//    [loginService loginUser:@"dashuai" andPassword:@"123456" block:^(AVUser * _Nullable user, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"登陆失败");
//        }else {
//            //处理登陆成功
//        }
//    }];
//}
//
//- (void)userStatus {
//    AVUser *user = [AVUser currentUser];
//    NSLog(@"user %@",user.username);
//}

- (void)cellOfBannerClick:(QDBannerModel *)banner {
    //轮播图片点击事件
    NSString *redirectUrl = banner.url;
    if (!([redirectUrl containsString:@"http"] || [redirectUrl containsString:@"https"])) {
        redirectUrl = [@"http://" stringByAppendingString:redirectUrl];
    }
    QDWebViewController *webViewController = [[QDWebViewController alloc] initWithURL:[NSURL URLWithString:redirectUrl]];
    webViewController.showsToolBar = NO;
    webViewController.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

@end
