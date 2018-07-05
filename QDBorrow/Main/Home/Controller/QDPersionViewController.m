//
//  QDPersionViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDPersionViewController.h"
#import "QDAssetsModel.h"
#import "YYModel.h"
#import "LZPickViewManager.h"
#import "QDAssetsChoicesTableViewCell.h"
#import "QDApplyAssetsModel.h"
#import "MBProgressHUD+MP.h"
#import "YYModel.h"
#import "MBProgressHUD+MP.h"
#import "QDFinishApplyViewController.h"
//#import "QDEstimateQualificationViewController.h"

static NSString *const kReusableIdentifierIntroduceCell = @"introduceCell";
@interface QDPersionViewController ()

@property (nonatomic, strong) NSMutableArray *persionTitleArray;
@property (nonatomic, strong) QDApplyAssetsModel *assetsModel;

@end

@implementation QDPersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.persionInfoType == PersionInfoTypePersional) {
        self.title = @"个人信息";
    } else {
        self.title= @"资产信息";
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"QDAssetsChoicesTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierIntroduceCell];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self configData];
    [self configUI];
}

- (void)configData {
    
    if (!self.persionInfo) {
        //初始化文件路径。
        NSString* path  = [[NSBundle mainBundle] pathForResource:@"zichan" ofType:@"json"];
        //将文件内容读取到字符串中，注意编码NSUTF8StringEncoding 防止乱码，
        NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        //将字符串写到缓冲区。
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        self.persionInfo = [NSArray yy_modelArrayWithClass:[QDAssetsModel class] json:dic];;
    }
}

- (void)configUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.tableView.tableFooterView = footerView;
    [self createFooterView];
}
- (void)createFooterView {
    QMUIButton *normalButton = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 50))];
    normalButton.adjustsButtonWhenHighlighted = YES;
    normalButton.titleLabel.font = UIFontBoldMake(14);
    [normalButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
    normalButton.backgroundColor = UIColorRed;
//    normalButton.highlightedBackgroundColor = UIColorMake(0, 168, 225);// 高亮时的背景色
    normalButton.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [self.view addSubview:normalButton];
    [normalButton addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if (self.persionInfoType == PersionInfoTypePersional) {
        [normalButton setTitle:@"下一步" forState:UIControlStateNormal];
    } else {
        [normalButton setTitle:@"完成" forState:UIControlStateNormal];
    }
}


#pragma mark -- tableView datasoure and delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDAssetsChoicesTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kReusableIdentifierIntroduceCell];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    QDAssetsModel *assetsModel = [self assetsOfSection:indexPath.section];
    AssetsInfo *assetsInfo = assetsModel.array[indexPath.row];
    NSString *cellTitle = assetsInfo.name;
    NSString *cellDetail = self.recordInfo[cellTitle] ? self.recordInfo[cellTitle] : @"未填写";
    cell.titleNameLabel.textColor = TableViewCellTitleLabelColor;
    cell.detailNameLabel.textColor = TableViewCellDetailLabelColor;
    cell.titleNameLabel.text = cellTitle;
    cell.detailNameLabel.text = cellDetail;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    backView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor whiteColor];
    [backView addSubview:view];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 2, SCREEN_WIDTH - 20, 16);
    QDAssetsModel *assetsModel = [self assetsOfSection:section];
    label.text = assetsModel.titleName;
    label.font = UIFontMake(12);
    label.textColor = TableViewCellDetailLabelColor;
    [view addSubview:label];
    return backView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.persionInfoType == PersionInfoTypePersional) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QDAssetsModel *assetsModel = [self assetsOfSection:section];
    return assetsModel.array.count;
}
- (QDAssetsModel *)assetsOfSection:(NSInteger)section {
    QDAssetsModel *assetsModel = nil;
    if (self.persionInfoType == PersionInfoTypePersional) {
        assetsModel = self.persionInfo[0];
    } else {
        if (section == 0) {
            assetsModel = self.persionInfo[1];
        } else {
            assetsModel = self.persionInfo[2];
        }
    }
    return assetsModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QDAssetsModel *assetsModel = [self assetsOfSection:indexPath.section];
    AssetsInfo *assetsInfo = assetsModel.array[indexPath.row];
    [[LZPickViewManager sharePickViewManager] showPickViewWithSigleArray:assetsInfo.choiceList compltedBlock:^(NSString *compltedString) {
        __weak typeof(self) weakSelf = self;
        weakSelf.recordInfo[assetsInfo.name] = compltedString;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } cancelBlock:nil];
}

- (NSMutableArray *)persionTitleArray {
    if (!_persionTitleArray) {
        _persionTitleArray = [[NSMutableArray alloc] init];
    }
    return _persionTitleArray;
}

- (NSMutableDictionary *)recordInfo {
    if (!_recordInfo) {
        _recordInfo = [[NSMutableDictionary alloc] init];
    }
    return _recordInfo;
}

- (QDApplyAssetsModel *)assetsModel {
    if (!_assetsModel) {
        _assetsModel =   [[QDApplyAssetsModel alloc] init];
    }
    return _assetsModel;
}

- (void)bottomBtnClick {
    if (self.persionInfoType == PersionInfoTypePersional) {
        if ([self validateMessage]) {
            QDPersionViewController *persionVC = [[QDPersionViewController alloc] init];
            persionVC.persionInfoType = PersionInfoTypeAssets;
            persionVC.persionInfo = self.persionInfo;
            persionVC.recordInfo = self.recordInfo;
            [self.navigationController pushViewController:persionVC animated:YES];
        }
    } else {
        if ([self validateMessage]) {
            //完成注册
//            BmobObject *borrow = [BmobObject objectWithClassName:@"QDApplyOrder"];
//            BmobUser *user = [BmobUser currentUser];
//            [borrow setObject:user.username forKey:@"userId"];
//            [borrow setObject:[self.recordInfo yy_modelToJSONString] forKey:@"applyInfo"];
//            [MBProgressHUD showInfo:@"提交信息中..." ToView:self.view];
//            [borrow saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                if (isSuccessful) {
//                    [MBProgressHUD hideHUDForView:self.view];
//                    QDFinishApplyViewController *applyVC = [[QDFinishApplyViewController alloc] init];
//                    [self.navigationController pushViewController:applyVC animated:YES];
//                } else {
//                    [MBProgressHUD hideHUDForView:self.view];
//                     [MBProgressHUD showMessage:error.localizedDescription ToView:self.view RemainTime:2.0];
//                }
//            }];
        }
    }
}

- (BOOL)validateMessage {
    if (self.persionInfoType == PersionInfoTypePersional) {
        if (self.recordInfo.allKeys.count < 4) {
            [MBProgressHUD showMessage:@"还有部分信息尚未填写,请全部填写！" ToView:self.view RemainTime:2.0f];
            return false;
        }
    } else {
        if (self.recordInfo.allKeys.count < 14) {
            [MBProgressHUD showMessage:@"还有部分信息尚未填写,请全部填写！" ToView:self.view RemainTime:2.0f];
            return false;
        }
    }
    
    return true;
    
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
