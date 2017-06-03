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
#import "AVUser.h"
#import "QDMyAccountCell.h"

static NSString *const kReusableIdentifierMyListCell  = @"myCell";
static NSString *const kReusableIdentifierAccountCell = @"accountCell";


@interface QDMyViewController ()
@property (nonatomic, strong) AVUser *user;

@end

@implementation QDMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configData];
    [self configUI];
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)configData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refreshData" object:nil];
    self.user = [AVUser currentUser];
    
}

- (void)configUI {
    self.title = @"个人中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.tableViewInitialContentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

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
    //进入关于我们
    QDAboutViewController *viewController = [[QDAboutViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)refreshData {
    [self.tableView reloadData];
    
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
