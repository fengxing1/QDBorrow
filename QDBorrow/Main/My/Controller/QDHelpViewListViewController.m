//
//  QDHelpViewListViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/6/4.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDHelpViewListViewController.h"
#import "QDHelpModel.h"
#import "YYModel.h"
#import "QMUIKit.h"

@interface QDHelpViewListViewController ()
@property (nonatomic, strong) QDHelpModel *helpModel;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation QDHelpViewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"帮助中心";
}

- (void)initDataSource {
    [super initDataSource];
    //初始化文件路径。
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"helpJson" ofType:@"txt"];
    //将文件内容读取到字符串中，注意编码NSUTF8StringEncoding 防止乱码，
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //将字符串写到缓冲区。
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    self.helpModel = [QDHelpModel yy_modelWithDictionary:dic[@"data"]];
    
    for (QDHelpInfoModel *infoModel in self.helpModel.list) {
        [self.titleArray addObject:infoModel.name];

    }

    self.dataSource = self.titleArray;
}


- (void)didSelectCellWithTitle:(NSString *)title {
    NSUInteger index =  [self.titleArray indexOfObject:title];
    QDHelpInfoModel *infoModel = self.helpModel.list[index];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    contentView.backgroundColor = UIColorWhite;
    contentView.layer.cornerRadius = 6;
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = TableViewCellTitleLabelColor;

    
    NSString *answers = [[NSString alloc] init];
    for (NSString *answer in infoModel.answer) {
        answers = [NSString stringWithFormat:@"%@\n%@",answers,answer];
    }
    label.text = answers;
    [contentView addSubview:label];
    
    UIEdgeInsets contentViewPadding = UIEdgeInsetsMake(20, 20, 20, 20);
    CGFloat contentLimitWidth = CGRectGetWidth(contentView.bounds) - UIEdgeInsetsGetHorizontalValue(contentViewPadding);
    CGSize labelSize = [label sizeThatFits:CGSizeMake(contentLimitWidth, CGFLOAT_MAX)];
    label.frame = CGRectMake(contentViewPadding.left, contentViewPadding.top, contentLimitWidth, labelSize.height);
    
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.contentView = contentView;
    [modalViewController showWithAnimated:YES completion:nil];
    
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
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
