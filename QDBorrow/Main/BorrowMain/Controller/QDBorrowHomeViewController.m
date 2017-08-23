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

static NSString *const kReusableIdentifierBannerCell  = @"bannerCell";
static NSString *const kReusableIdentifierBorrowCell  = @"borrowCell";

@interface QDBorrowHomeViewController () <CellOfBannerDelgate>
@property(nonatomic, strong) NSMutableArray *homeBannerArray;

@end

@implementation QDBorrowHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    [self confirmUI];
    [self configData];
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
}



#pragma mark -- tableview delegate and datesource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.homeBannerArray && self.homeBannerArray.count) {
        return 2;
    }
    return 0;
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
//        QDBannerTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierBannerCell];
//        bannerCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        bannerCell.bannerList = self.homeBannerArray;
//        bannerCell.delegate = self;
//        return bannerCell;
        QDHomeBorrowCell *borrowCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierBorrowCell];
        borrowCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return borrowCell;
        
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
