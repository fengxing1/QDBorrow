//
//  QDCompanyViewController.m
//  QDBorrow
//
//  Created by larou on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCompanyViewController.h"
#import "BorrowDetailModel.h"
#import "AVQuery.h"
#import "QDCompanyTableViewCell.h"
#import "QDCompanyDetailController.h"

static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";

@interface QDCompanyViewController ()
@property (nonatomic, strong) NSMutableArray *borrowArray;

@end

@implementation QDCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self configData];
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}


- (void)configUI {
    self.title = @"找借贷";
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"QDCompanyTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCompanyCell];
}

- (void)configData {
    if (!self.borrowArray) {
        self.borrowArray = [[NSMutableArray alloc] init];
        AVQuery *queryBorrow = [AVQuery queryWithClassName:@"QDBorrow"];
        [queryBorrow findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            for (AVObject *avBorrow in objects) {
                BorrowDetailModel *detail = [[BorrowDetailModel alloc] initWithAVObject:avBorrow];
                [self.borrowArray addObject:detail];
            }
            [self.tableView reloadData];
        }];
    }
}


#pragma mark tableview datasoure and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.borrowArray) {
        return  self.borrowArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCompanyTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCompanyCell];
    companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    companyCell.borrowDtail = self.borrowArray[indexPath.row];
    return companyCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 10;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BorrowDetailModel *borrowModel = self.borrowArray[indexPath.section];
    QDCompanyDetailController *companyDetailViewController = [[QDCompanyDetailController alloc] init];
    companyDetailViewController.borrowModel = borrowModel;
    [self.navigationController pushViewController:companyDetailViewController animated:YES];
    
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
