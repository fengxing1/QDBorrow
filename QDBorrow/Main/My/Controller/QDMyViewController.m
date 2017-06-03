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

static NSString *const kReusableIdentifierCerditCell  = @"myCell";


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
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)configData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refreshData" object:nil];
    self.user = [AVUser currentUser];
    
}

- (void)configUI {
    self.title = @"个人中心";
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"QDMyListCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCerditCell];
}


#pragma mark - <QMUITableViewDataSource,QMUITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDMyListCell *listCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCerditCell];
    
    return listCell;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.user) {
        return 5;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
