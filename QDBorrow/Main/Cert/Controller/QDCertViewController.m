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
            } title:@"提示" message:@"网络出错" cancelButtonName:@"刷新" otherButtonTitles:@"取消", nil];
            
            
        }
    }];
    
    
}
- (void)configUI {
    self.title = @"信用卡";
//    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
//    [self.tableView registerClass:[QMUITableViewCell class] forCellReuseIdentifier:kReusableIdentifierCerditCell];
}


#pragma mark - <QMUITableViewDataSource,QMUITableViewDelegate>


- (UITableViewCell *)qmui_tableView:(UITableView *)tableView cellWithIdentifier:(NSString *)identifier {
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initForTableView:self.tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = [self qmui_tableView:tableView cellWithIdentifier:@"cell"];
    
    // reset
    cell.imageEdgeInsets = UIEdgeInsetsZero;
    cell.textLabelEdgeInsets = UIEdgeInsetsZero;
    cell.detailTextLabelEdgeInsets = UIEdgeInsetsZero;
    cell.accessoryEdgeInsets = UIEdgeInsetsZero;
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.imageView.image = [UIImage qmui_imageWithShape:QMUIImageShapeOval size:CGSizeMake(40, 40) lineWidth:2 tintColor:[QDCommonUI randomThemeColor] ];
    QDCerditModel *cerditModel = self.cerditList[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:cerditModel.cerditIcon] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.imageView.frame = CGRectMake(15,20, 40, 40);
    }];
    cell.textLabel.text = cerditModel.cerditName;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = cerditModel.cerditDesc;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.cerditList) {
        return self.cerditList.count;
    }
    return 0;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCerditCell];
//    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:cerditModel.cerditIcon] placeholderImage:nil];
//    cell.textLabel.text = cerditModel.cerditName;
//    cell.detailTextLabel.text = cerditModel.cerditDesc;
//    cell.selectionStyle = UITableViewCellAccessoryNone;
//    return cell;
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCerditModel *cerditModel = self.cerditList[indexPath.row];
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
