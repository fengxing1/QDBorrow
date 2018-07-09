//
//  QDMyViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/16.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDMyViewController.h"
#import "QDAboutViewController.h"
#import "QDMyListCell.h"
#import "QDMyAccountCell.h"
#import "QDLoginOrRegisterViewController.h"
#import <SobotKit/SobotKit.h>
#import "QDMessageViewController.h"
#import "QDHelpViewListViewController.h"
#import "QDSettingViewController.h"
#import "QDUserManager.h"
#import "QDWebViewController.h"


static NSString *const kReusableIdentifierMyListCell  = @"myCell";
static NSString *const kReusableIdentifierAccountCell = @"accountCell";


@interface QDMyViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) QDUser *user;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QDMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configData];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.tabBarController.tabBar setHidden:NO];
}


- (void)configData {
    self.user = [[QDUserManager sharedInstance] getUser];
}

- (void)configUI {
    self.title = @"个人中心";
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableViewInitialContentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
//    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = nil;
    [self.tableView registerNib:[UINib nibWithNibName:@"QDMyListCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierMyListCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QDMyAccountCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierAccountCell];
}


#pragma mark - <QMUITableViewDataSource,QMUITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QDMyAccountCell *accountCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierAccountCell];
        accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return accountCell;
    } else {
        QDMyListCell *listCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierMyListCell];
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.user) {
            if (indexPath.row == 0) {
                listCell.cellType = CellTypeMessage;
            } else if(indexPath.row == 1){
                listCell.cellType = CellTypeHelp;
            } else if (indexPath.row == 2) {
                listCell.cellType = CellTypeService;
            } else {
                listCell.cellType = CellTypeForm;
            }
        } else {
            if (indexPath.row == 0) {
                listCell.cellType = CellTypeHelp;
            } else if(indexPath.row == 1){
                listCell.cellType = CellTypeService;
            } else if (indexPath.row == 2) {
                listCell.cellType = CellTypeForm;
            }
        }
        return listCell;
        
    }
    
//    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCerditCell];
//    if (!cell) {
//        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:kReusableIdentifierCerditCell];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    cell.textLabel.text = @"关于我们";
//
//    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 10.0;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        if (self.user) {
            return 4;
        } else {
            return 3;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.user) {
            return;
        } else {
            QDLoginOrRegisterViewController *loginVC = [[QDLoginOrRegisterViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
        
    } else {
        if (self.user) {
            if (indexPath.row == 0) {
                //消息
                QDMessageViewController *messageVC = [[QDMessageViewController alloc] init];
                [self.navigationController pushViewController:messageVC animated:YES];
            } else if(indexPath.row == 1){
                //帮助
                QDHelpViewListViewController *helpVC = [[QDHelpViewListViewController alloc] init];
                [self.navigationController pushViewController:helpVC animated:YES];
            } else if (indexPath.row == 2) {
                //客服
                [self intoSobot];
            } else {
                //设置
                QDSettingViewController *setttingVC = [[QDSettingViewController alloc] init];
                [self.navigationController pushViewController:setttingVC animated:YES];
            }
        } else {
            if (indexPath.row == 0) {
                //帮助
                QDHelpViewListViewController *helpVC = [[QDHelpViewListViewController alloc] init];
                [self.navigationController pushViewController:helpVC animated:YES];
            } else if(indexPath.row == 1){
                //客服
                [self intoSobot];
            } else if (indexPath.row == 2) {
                //设置
                QDSettingViewController *setttingVC = [[QDSettingViewController alloc] init];
                [self.navigationController pushViewController:setttingVC animated:YES];
            }
        }
        
        
        
    }
    //进入关于我们
//    QDAboutViewController *viewController = [[QDAboutViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)intoSobot {
    QDWebViewController *webViewController = [[QDWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.sobot.com/chat/h5/index.html?sysNum=55b6b689884846ed992acf4925cd639e&source=2"]];
    webViewController.showsToolBar = NO;
    webViewController.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

// 设置UI部分
-(void) customerUI:(ZCKitInfo *) kitInfo{
    kitInfo.isCloseAfterEvaluation = YES;
    
}



- (void)refreshData {
    self.user = [[QDUserManager sharedInstance] getUser];
    [self.tableView reloadData];
    
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
