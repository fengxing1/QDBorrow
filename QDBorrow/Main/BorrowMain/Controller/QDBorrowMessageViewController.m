//
//  QDBorrowMessageViewController.m
//  QDBorrow
//
//  Created by larou on 2017/7/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDBorrowMessageViewController.h"
#import "QDMessageCell.h"
#import "QDMessageModel.h"
#import "UIView+EaseBlankPage.h"
#import "MJRefreshNormalHeader.h"
#import "UIColor+Hex.h"

static NSString *const kReusableIdentifierMessageCell  = @"messageCell";
@interface QDBorrowMessageViewController ()
@property (nonatomic, strong) NSMutableArray *messageList;

@end

@implementation QDBorrowMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
    [self configUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self refreshView];
}

- (void)configUI {
    self.tableView.tableHeaderView = nil;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHeX:0xE6E6E6];
    [self.tableView registerNib:[UINib nibWithNibName:@"QDMessageCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierMessageCell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshView)];
}


- (void)refreshView {
    //刷新消息
//    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
//    [[QDHomeService sharedInstance] messageDataWithBlock:^(NSArray *array, NSError *error) {
//        [MBProgressHUD hideHUDForView:self.view];
//        [self.tableView.mj_header endRefreshing];
//        if (!error) {
//            [self.messageList removeAllObjects];
//            for (BmobObject *message in array) {
//                QDMessageModel *messageModel = [[QDMessageModel alloc] initWithBannerObject:message];
//                [self.messageList addObject:messageModel];
//            }
//            if (self.messageList.count) {
//                [self.tableView reloadData];
//            }
//            __weak typeof(self)weakSelf = self;
//            [self.view configBlankPage:EaseBlankPageTypeView hasData:self.messageList.count hasError:NO reloadButtonBlock:^(id sender) {
//                [weakSelf refreshView];
//                
//            }];
//        } else {
//            [MBProgressHUD showAutoMessage:error.localizedDescription ToView:self.view];
//        }
//    }];
}

#pragma mark -- tableview delegate and datesource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 154;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierMessageCell];
    messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    messageCell.messageModel = self.messageList[indexPath.row];
    return messageCell;
}


- (NSMutableArray *)messageList {
    if (!_messageList) {
        _messageList = [[NSMutableArray alloc] init];
    }
    return _messageList;
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
