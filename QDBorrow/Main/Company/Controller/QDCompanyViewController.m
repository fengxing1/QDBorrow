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
#import "QBBusinessTableViewCell.h"

static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";

@interface QDCompanyViewController ()
@property (nonatomic, strong) NSMutableArray *borrowArray;

@end

@implementation QDCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self confirmUI];
    [self configData];
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}


- (void)confirmUI {
    self.title = @"找借贷";
    self.tableView.tableHeaderView = nil;
    [self.tableView registerNib:[UINib nibWithNibName:@"QBBusinessTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCompanyCell];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.borrowArray) {
        return  self.borrowArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QBBusinessTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCompanyCell];
    if (self.borrowArray.count >= indexPath.row) {
        companyCell.borrowModel = self.borrowArray[indexPath.row];
    }
    return companyCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180 * SCREEN_WIDTH / 375;
    } else {
        return 106;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
