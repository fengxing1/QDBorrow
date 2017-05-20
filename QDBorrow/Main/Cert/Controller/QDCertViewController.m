//
//  QDCertViewController.m
//  QDBorrow
//
//  Created by larou on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCertViewController.h"
#import "AVQuery.h"
#import "UIAlertView+Block.h"
#import "QDCerditModel.h"
#import "QMUITableViewCell.h"
#import "UIImageView+WebCache.h"
#import "QDWebViewController.h"
#import "QDCommonUI.h"
#import "QDCerditCell.h"

static NSString *const kReusableIdentifierCerditCell  = @"cerditCell";

@interface QDCertViewController ()
@property (nonatomic, strong) NSMutableArray *cerditList;

@end

@implementation QDCertViewController

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
    self.cerditList = [[NSMutableArray alloc] init];
    AVQuery *query = [AVQuery queryWithClassName:@"QDCerdit"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            for (AVObject *avCerditDetail in objects) {
                QDCerditModel *cerditModel = [[QDCerditModel alloc] initWithAVObject:avCerditDetail];
                [self.cerditList addObject:cerditModel];
            }
            [self.tableView reloadData];
        } else {
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                if (!buttonIndex) {
                    [self configData];
                }
            } title:@"提示" message:@"好像没有网络，刷新一下" cancelButtonName:@"刷新" otherButtonTitles:@"取消", nil];
            
            
        }
    }];
    
    
}
- (void)configUI {
    self.title = @"信用卡";
//    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"QDCerditCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCerditCell];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - <QMUITableViewDataSource,QMUITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCerditCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCerditCell];
    QDCerditModel *cerditModel = self.cerditList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.cerditModel = cerditModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.cerditList) {
        return self.cerditList.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCerditModel *cerditModel = self.cerditList[indexPath.row];
    if (!cerditModel.showDetail) {
        return;
    }
    NSString *redirectUrl = cerditModel.redirectUrl;
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
