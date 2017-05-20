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
#import "QDHomeBannerModel.h"
#import "BorrowDetailModel.h"
#import "QDHomeModel.h"
#import "YYModel.h"
#import "UIAlertView+Block.h"
#import "QDBannerTableViewCell.h"
#import "QDWebViewController.h"
#import "QBBusinessTableViewCell.h"
#import "QDCompanyDetailController.h"

static NSString *const kReusableIdentifierBannerCell  = @"bannerCell";
static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";

@interface HomeViewController () <QMUITableViewDelegate,QMUITableViewDataSource,CellOfBannerDelgate>

@property(nonatomic, strong) QMUIButton *registButton;
@property(nonatomic, strong) QMUIButton *loginButton;
@property(nonatomic, strong) QMUIButton *statusButton;
@property(nonatomic, strong) QDHomeModel *homeModel;


@end



@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self confirmUI];
    [self configData];
    
//    [self confirmData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden=NO;
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        if (style == UITableViewStyleGrouped) {
//            self.tableViewInitialContentInset = UIEdgeInsetsMake(NavigationContentTop - 35, 0, 0, 0);
            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44);
        }
    }
    return self;
}

- (void)configData {
    if (self.homeModel == nil) {
        self.homeModel = [[QDHomeModel alloc] init];
    }
    if (self.homeModel.bannerArray == nil) {
        self.homeModel.bannerArray = [[NSMutableArray alloc] init];
    } else {
        [self.homeModel.bannerArray removeAllObjects];
    }
    if (self.homeModel.borrowDetailArray == nil) {
        self.homeModel.borrowDetailArray = [[NSMutableArray alloc] init];
    } else {
        [self.homeModel.borrowDetailArray removeAllObjects];
    }
    AVQuery *queryBanner = [AVQuery queryWithClassName:@"QDBanner"];
    [queryBanner findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (AVObject *avBanner in objects) {
                QDHomeBannerModel *bannerModel = [[QDHomeBannerModel alloc] initWithAVObject:avBanner];
                [self.homeModel.bannerArray addObject:bannerModel];
                
            }
            AVQuery *queryBorrow = [AVQuery queryWithClassName:@"QDBorrow"];
            [queryBanner whereKey:@"bshowAtHome" equalTo:@(1)];
            [queryBorrow findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                for (AVObject *avBorrow in objects) {
                    BorrowDetailModel *detail = [[BorrowDetailModel alloc] initWithAVObject:avBorrow];
                    [self.homeModel.borrowDetailArray addObject:detail];
                }
                [self.tableView reloadData];
            }];
        } else {
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                if (!buttonIndex) {
                    [self configData];
                }
            } title:@"提示" message:@"网络还没被允许，请确认！" cancelButtonName:@"重新刷新" otherButtonTitles:@"取消", nil];
            
        }
    }];
    
}

//- (void)confirmData {
//    for (int i = 0; i <= 10; i ++) {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        [borrow setObject:[NSNumber numberWithInteger:i+1] forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"https://imgsa.baidu.com/baike/w%3D268/sign=a588ca9d06f41bd5da53eff269db81a0/024f78f0f736afc3a1a712d3bb19ebc4b64512d8.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"招商银行1" forKey:@"cerditName"];
//        [borrow setObject:@"购物加油5%，成功办卡享100元刷卡金" forKey:@"cerditDesc"];
//        [borrow setObject:@"http://www.baidu.com" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//
//    }
//    
//}
//    //创建数据
//    NSMutableArray *bannerArray = [[NSMutableArray alloc] init];
//    QDHomeBannerModel *bannerModel = [[QDHomeBannerModel alloc] init];
//    bannerModel.bannerId = 0;
//    bannerModel.imageUrl = @"http://obvn1tlyd.bkt.clouddn.com/d5fe3dc9c61e887b6d10c818a5eaf0b5.jpg";
//    bannerModel.bannerType = 0;
//    bannerModel.value = @"www.baidu.com";
//    
//    QDHomeBannerModel *bannerModel1 = [[QDHomeBannerModel alloc] init];
//    bannerModel1.bannerId = 0;
//    bannerModel1.imageUrl = @"http://obvn1tlyd.bkt.clouddn.com/ee0148764ceb62c3f826316c7e0aa3ce.jpeg";
//    bannerModel1.bannerType = 0;
//    bannerModel1.value = @"www.baidu.com";
//    
//    QDHomeBannerModel *bannerModel2 = [[QDHomeBannerModel alloc] init];
//    bannerModel2.bannerId = 0;
//    bannerModel2.imageUrl = @"http://obvn1tlyd.bkt.clouddn.com/9976dacbb2aad071270d87156820ef68.jpg";
//    bannerModel2.bannerType = 0;
//    bannerModel2.value = @"www.baidu.com";
//    
//    for (int i = 0; i <= 3; i ++) {
//        AVObject *banner = [AVObject objectWithClassName:@"QDBanner"];
//        [banner setObject:[NSNumber numberWithInt:i] forKey:@"bannerId"];
//        if (i == 0) {
//            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/ee0148764ceb62c3f826316c7e0aa3ce.jpeg" forKey:@"imageUrl"];
//        } else if(i == 2) {
//            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/d5fe3dc9c61e887b6d10c818a5eaf0b5.jpg" forKey:@"imageUrl"];
//        } else {
//            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/9976dacbb2aad071270d87156820ef68.jpg" forKey:@"imageUrl"];
//        }
//        [banner setObject:@0 forKey:@"bannerType"];
//        [banner setObject:@"www.baidu.com" forKey:@"value"];
//        [banner saveInBackground];
//    }
//    
//    
//    
//    [bannerArray addObject:[bannerModel yy_modelToJSONObject]];
//    [bannerArray addObject:[bannerModel1 yy_modelToJSONObject]];
//    [bannerArray addObject:[bannerModel2 yy_modelToJSONObject]];
//    
//    for (int i = 0; i <= 10; i ++) {
//        BorrowDetailModel *borrowModel = [[BorrowDetailModel alloc] init];
//        borrowModel.companyId = i;
//        borrowModel.imageIcon = @"https://imgsa.baidu.com/baike/w%3D268/sign=a588ca9d06f41bd5da53eff269db81a0/024f78f0f736afc3a1a712d3bb19ebc4b64512d8.jpg";
//        borrowModel.companyName = [NSString stringWithFormat:@"平安贷%d",i];
//        borrowModel.companyDetail = @"凭身份证2000-30000元 1-20月 最快三分钟放款";
//        borrowModel.peopleNum = 1233422;
//        borrowModel.maxMoney = 2000000;
//        borrowModel.minMoney = 1000;
//        borrowModel.amortizationNumArray = [NSArray arrayWithObjects:@"1",@"3",@"5", nil];
//        borrowModel.fastestTime = @"3分钟";
//        borrowModel.qualificationArray = [NSArray arrayWithObjects:@"18岁到55周岁，中国大陆身份证公民",@"全日制大专以上学历", nil];
//        borrowModel.dataArray = [NSArray arrayWithObjects:@"身份证拍照",@"刷脸识别",@"提供通讯录和联系人", nil];
//        borrowModel.bshowAtHome = 1;
//        
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        [borrow setObject:[NSNumber numberWithInteger:i] forKey:@"companyId"];
//        [borrow setObject:@"https://imgsa.baidu.com/baike/w%3D268/sign=a588ca9d06f41bd5da53eff269db81a0/024f78f0f736afc3a1a712d3bb19ebc4b64512d8.jpg" forKey:@"imageIcon"];
//        [borrow setObject:[NSString stringWithFormat:@"平安贷%d",i] forKey:@"companyName"];
//        [borrow setObject:@"凭身份证2000-30000元 1-20月 最快三分钟放款" forKey:@"companyDetail"];
//        [borrow setObject:@1233422 forKey:@"peopleNum"];
//        [borrow setObject:@2000000 forKey:@"maxMoney"];
//        [borrow setObject:@1000 forKey:@"minMoney"];
//        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5", nil] forKey:@"amortizationNumArray"];
//        [borrow setObject:@"3分钟" forKey:@"fastestTime"];
//        [borrow setObject:[NSArray arrayWithObjects:@"18岁到55周岁，中国大陆身份证公民",@"全日制大专以上学历", nil] forKey:@"qualificationArray"];
//        [borrow setObject:[NSArray arrayWithObjects:@"身份证拍照",@"刷脸识别",@"提供通讯录和联系人", nil] forKey:@"dataArray"];
//        [borrow setObject:@1 forKey:@"bshowAtHome"];
//        [borrow setObject:@"www.baidu.com" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//        
//    }
//}

- (void)confirmUI {
    self.title = @"首页";
    //初始化tableView
    self.tableView.tableHeaderView = nil;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerClass:[QDBannerTableViewCell class] forCellReuseIdentifier:kReusableIdentifierBannerCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QBBusinessTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCompanyCell];
    
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
    if (self.homeModel) {
        if (section == 0) {
            if (self.homeModel.bannerArray && self.homeModel.bannerArray.count) {
                return 1;
            }
            return 0;
        } else {
            if (self.homeModel.borrowDetailArray && self.homeModel.borrowDetailArray.count) {
                return self.homeModel.borrowDetailArray.count;
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
        bannerCell.bannerList = self.homeModel.bannerArray;
        bannerCell.delegate = self;
        return bannerCell;
    } else {
        QBBusinessTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCompanyCell];
        companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.homeModel.borrowDetailArray.count >= indexPath.row) {
            companyCell.borrowModel = self.homeModel.borrowDetailArray[indexPath.row];
        }
        return companyCell;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180 * SCREEN_WIDTH / 375;
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
        BorrowDetailModel *borrowModel = self.homeModel.borrowDetailArray[indexPath.row];
        QDCompanyDetailController *companyDetailViewController = [[QDCompanyDetailController alloc] init];
        companyDetailViewController.borrowModel = borrowModel;
        [self.navigationController pushViewController:companyDetailViewController animated:YES];
    }
    
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

- (void)cellOfBannerClick:(QDHomeBannerModel *)banner {
    if (!banner.showDetail) {
        return;
    }
    //轮播图片点击事件
    NSString *redirectUrl = banner.value;
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
