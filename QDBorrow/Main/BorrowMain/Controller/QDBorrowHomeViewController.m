//
//  QDBorrowHomeViewController.m
//  QDBorrow
//
//  Created by larou on 2017/7/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDBorrowHomeViewController.h"
#import "QDHomeModel.h"
#import "QDHomeService.h"
#import "UIAlertView+Block.h"
#import "QDHomeBannerModel.h"
#import "QDBannerTableViewCell.h"
#import "QDHomeBorrowCell.h"
#import "QMUIKit.h"
#import "QDPersionViewController.h"
#import "QDLoginOrRegisterViewController.h"
#import "QDWebViewController.h"

static NSString *const kReusableIdentifierBannerCell  = @"bannerCell";
static NSString *const kReusableIdentifierBorrowCell  = @"borrowCell";

@interface QDBorrowHomeViewController () <CellOfBannerDelgate>
@property(nonatomic, strong) NSMutableArray *homeBannerArray;
@property (nonatomic, assign) NSInteger borrowType;
@property (nonatomic, assign) NSInteger borrowCount;

@end

@implementation QDBorrowHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    [self confirmUI];
    [self configData];
}


- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        if (style == UITableViewStyleGrouped) {
            self.tableViewInitialContentInset = UIEdgeInsetsMake(28, 0, 30, 0);
            //            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 200);
        }
    }
    return self;
}


- (void)configData {
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    [[QDHomeService sharedInstance] homeBannerDataWithBlock:^(NSArray *array, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        if (!error) {
            for (BmobObject *bmBanner in array) {
                QDHomeBannerModel *bannerModel = [[QDHomeBannerModel alloc] initWithBannerObject:bmBanner];
                [self.homeBannerArray addObject:bannerModel];
            }
            [self.tableView reloadData];
        } else {
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                if (buttonIndex) {
                    [self configData];
                }
            } title:@"提示" message:@"网络出错，请刷新重试！" cancelButtonName:@"取消" otherButtonTitles:@"重新刷新", nil];
        }
    }];

}

- (void)confirmUI {
    self.title = @"首页";
    self.tableView.tableHeaderView = nil;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerClass:[QDBannerTableViewCell class] forCellReuseIdentifier:kReusableIdentifierBannerCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QDHomeBorrowCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierBorrowCell];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}



#pragma mark -- tableview delegate and datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QDBannerTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierBannerCell];
        bannerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        bannerCell.bannerList = self.homeBannerArray;
        bannerCell.delegate = self;
        return bannerCell;
    } else {
        QDHomeBorrowCell *borrowCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierBorrowCell];
        borrowCell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        borrowCell.block = ^(int borrowType, NSInteger borrowCount) {
            //跳转，并回传记录 记录贷款金额，和方式
            [weakSelf bottomBtnClickWithType:borrowType andBorrowCount:borrowCount];
        };
        return borrowCell;
        
    }
}


- (void)bottomBtnClickWithType:(NSInteger)type andBorrowCount:(NSInteger)borrowCount {
    //先进行登录校验
    if ([BmobUser currentUser]) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            QDPersionViewController *persionVC = [[QDPersionViewController alloc] init];
            persionVC.fromBorrow = 1;
            persionVC.persionInfoType = PersionInfoTypePersional;
            __weak typeof(self) weakSelf = self;
            [weakSelf.navigationController pushViewController:persionVC animated:YES];
        } title:@"提示" message:@"为了快速准确获取贷款，请准确填写贷款信息" cancelButtonName:@"确定" otherButtonTitles:nil];
    } else {
        QDLoginOrRegisterViewController *loginVC = [[QDLoginOrRegisterViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }

}

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 10;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200 * SCREEN_WIDTH / 375;
    } else {
        return 470;
    }
}

- (NSMutableArray *)homeBannerArray {
    if (!_homeBannerArray) {
        _homeBannerArray = [NSMutableArray array];
    }
    return _homeBannerArray;
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
