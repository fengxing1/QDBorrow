//
//  HomeViewController.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/6.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginService.h"
#import "QMUIKit.h"
#import "QDCommonTableViewController.h"
#import "QDHomeBannerModel.h"
#import "BorrowDetailModel.h"
#import "QDHomeModel.h"
#import "YYModel.h"
#import "UIAlertView+Block.h"
#import "QDBannerTableViewCell.h"
#import "QDWebViewController.h"
#import "QBBusinessTableViewCell.h"
#import "QDCompanyDetailController.h"
#import "MBProgressHUD+MP.h"
#import "MJRefreshNormalHeader.h"
#import <BmobSDK/Bmob.h>
#import "QDHomeService.h"

static NSString *const kReusableIdentifierBannerCell  = @"bannerCell";
static NSString *const kReusableIdentifierCompanyCell  = @"companyCell";

@interface HomeViewController () <QMUITableViewDelegate,QMUITableViewDataSource,CellOfBannerDelgate>

@property(nonatomic, strong) QMUIButton *registButton;
@property(nonatomic, strong) QMUIButton *loginButton;
@property(nonatomic, strong) QMUIButton *statusButton;
@property(nonatomic, strong) QDHomeModel *homeModel;


@end



@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self confirmUI];
    [self configData];
    
//    [self addBorrorData];
//    [self addCerList];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tabBarController.tabBar setHidden:NO];
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
    //    self.tableViewInitialContentInset = UIEdgeInsetsMake(-40, 0, 25, 0);
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        if (style == UITableViewStyleGrouped) {
            self.tableViewInitialContentInset = UIEdgeInsetsMake(28, 0, 0, 0);
            //            self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 200);
        }
    }
    return self;
}

- (void)configData {
    if (self.homeModel == nil) {
        self.homeModel = [[QDHomeModel alloc] init];
    }
    if (self.homeModel.bannerArray == nil) {
        self.homeModel.bannerArray = [[NSMutableArray alloc] init];
    } else {
        [self.homeModel.bannerArray removeAllObjects];
    }
    if (self.homeModel.borrowDetailArray == nil) {
        self.homeModel.borrowDetailArray = [[NSMutableArray alloc] init];
    } else {
        [self.homeModel.borrowDetailArray removeAllObjects];
    }
    
    [MBProgressHUD showMessage:@"加载中..." ToView:self.view];
    [[QDHomeService sharedInstance] homeBannerDataWithBlock:^(NSArray *array, NSError *error) {
         [self.tableView.mj_header endRefreshing];
        if (!error) {
            [self.homeModel.bannerArray removeAllObjects];
            [self.homeModel.borrowDetailArray removeAllObjects];
            for (BmobObject *bmBanner in array) {
                QDHomeBannerModel *bannerModel = [[QDHomeBannerModel alloc] initWithBannerObject:bmBanner];
                [self.homeModel.bannerArray addObject:bannerModel];
            }
            [[QDHomeService sharedInstance] homeBorrowDataWithBlock:^(NSArray *array, NSError *error) {
                if (!error) {
                    for (BmobObject *bmBorrrow in array) {
                        BorrowDetailModel *detail = [[BorrowDetailModel alloc] initWithBmObject:bmBorrrow];
                        [self.homeModel.borrowDetailArray addObject:detail];
                    }
                     [self.tableView reloadData];
                }
                [MBProgressHUD hideHUDForView:self.view];
                
            }];
        } else {
            [MBProgressHUD hideHUDForView:self.view];
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                if (buttonIndex) {
                    [self configData];
                }
            } title:@"提示" message:@"网络还没被允许，请确认！" cancelButtonName:@"取消" otherButtonTitles:@"重新刷新", nil];
        }
    }];
}

- (void)addBorrorData {
    [[QDHomeService sharedInstance] saveHomeData];
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(1);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/qianzhan.png";
//        borrow[@"companyName"] = @"钱站";
//        borrow[@"companyDetail"] = @"2000-100000随借秒放款";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"24小时内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"18岁到55周岁，中国大陆身份证公民", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @457321;
//        [borrow saveInBackground];
//    }
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(2);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/xinerfu.png";
//        borrow[@"companyName"] = @"信而富";
//        borrow[@"companyDetail"] = @"500－6000任性借，快速审核秒到账";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @876531;
//        [borrow saveInBackground];
//    }
//    
//    //3
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(3);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/caocaodai.png";
//        borrow[@"companyName"] = @"曹操贷";
//        borrow[@"companyDetail"] = @"借款找曹操，说到就到，5分钟评估额度，2小时放款，借钱就是快";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"24小时内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @1067631;
//        [borrow saveInBackground];
//        
//    }
//    
//    //3
//    
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(4);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/yongqianbao.png";
//        borrow[@"companyName"] = @"用钱宝";
//        borrow[@"companyDetail"] = @"30分钟审核，最快2小时快速放款";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"http://www.yongqianbao.com/wr/launch-register";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @1275531;
//        [borrow saveInBackground];
//    }
//    
//    
//    //5
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(5);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/daishangqian.png";
//        borrow[@"companyName"] = @"贷上钱";
//        borrow[@"companyDetail"] = @"0门槛，3分钟极速审核，88秒现金到账";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://www.daishangqian.com/vue/";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @779931;
//        [borrow saveInBackground];
//    }
//    
//    //6
//    {
//        {
//            AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//            borrow[@"companyId"] = @(6);
//            borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/xianjinbus.jpg";
//            borrow[@"companyName"] = @"现金巴士";
//            borrow[@"companyDetail"] = @"提前月光不用慌,现金巴士帮您忙!";
//            borrow[@"maxMoney"] = @29000;
//            borrow[@"minMoney"] = @1000;
//            borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//            borrow[@"fastestTime"] = @"10分钟内";
//            borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//            borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//            borrow[@"bshowAtHome"] = @1;
//            borrow[@"redirectUrl"] = @"https://www.cashbus.com/#overview";
//            borrow[@"monthyRate"] = @0.76;
//            borrow[@"showButton"] = @0;
//            borrow[@"peopleNum"] = @1765310;
//            [borrow saveInBackground];
//        }
//    }
//    
//    //7
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(7);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/rong360.jpg";
//        borrow[@"companyName"] = @"融360网贷";
//        borrow[@"companyDetail"] = @"用卡及理财在线搜索和申请服务";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://www.rong360.com/";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @928422;
//        [borrow saveInBackground];
//    }
//    
//    //8
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(9);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/rong360.jpg";
//        borrow[@"companyName"] = @"融360信用卡";
//        borrow[@"companyDetail"] = @"专注于金融领域的智能搜索平台,为企业和个人提供专业的贷款、信用卡及理财在线搜索和申请服务";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://www.rong360.com/";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @765332;
//        [borrow saveInBackground];
//    }
//    
//    //9
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(10);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/doudouqian.jpg";
//        borrow[@"companyName"] = @"豆豆钱";
//        borrow[@"companyDetail"] = @"用豆豆钱贷款，借钱省事！";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"http://www.ddcash.cn/register.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @984390;
//        [borrow saveInBackground];
//    }
//    //10
//    
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(11);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/haodai.png";
//        borrow[@"companyName"] = @"好贷信用卡";
//        borrow[@"companyDetail"] = @"申请信用卡，用好贷！";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @238640;
//        [borrow saveInBackground];
//    }
//    
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(12);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/yiyiyuan.jpg";
//        borrow[@"companyName"] = @"先花一亿元";
//        borrow[@"companyDetail"] = @"在线审批，快速贷款！";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @876322;
//        [borrow saveInBackground];
//    }
//    
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(12);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/daxiaodai.jpg";
//        borrow[@"companyName"] = @"大小贷";
//        borrow[@"companyDetail"] = @"线上操作快速审核到账,最高可借款5000元";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"24小时内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @1865322;
//        [borrow saveInBackground];
//    }
//    
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(13);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/jidai.jpg";
//        borrow[@"companyName"] = @"及贷";
//        borrow[@"companyDetail"] = @"手机贷款,0门槛0抵押0担保,3步完成申请,通过率高,周期灵活,可借1万元!";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.90;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @28873733;
//        [borrow saveInBackground];
//    }
//}
//
//- (void)addCerList {
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
////        [borrow setObject:@1 forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"http://oq97ntj1q.bkt.clouddn.com/pingan.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"平安银行" forKey:@"cerditName"];
//        [borrow setObject:@"周三吃喝玩乐统统半价" forKey:@"cerditDesc"];
//        [borrow setObject:@"https://c.pingan.com/apply/newpublic/new_apply/index.html#mainPage" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//    }
//    
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        //        [borrow setObject:@1 forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"http://oq97ntj1q.bkt.clouddn.com/guangda.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"光大银行" forKey:@"cerditName"];
//        [borrow setObject:@"首刷送10万积分，丰富卡种任你选金" forKey:@"cerditDesc"];
//        [borrow setObject:@"https://xyk.cebbank.com/home/ps/ps-req-newindex.htm?req_card_id=8348" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//    }
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        //        [borrow setObject:@1 forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"http://oq97ntj1q.bkt.clouddn.com/xingye.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"兴业银行" forKey:@"cerditName"];
//        [borrow setObject:@"6000积分可兑换星巴克咖啡" forKey:@"cerditDesc"];
//        [borrow setObject:@"https://e.cib.com.cn/app/quickApplyCard/quickApplyCard!custIdentityPage.do" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//    }
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        //        [borrow setObject:@1 forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"http://oq97ntj1q.bkt.clouddn.com/zhongxing.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"中信银行" forKey:@"cerditName"];
//        [borrow setObject:@"9元享看海量视频，周三周六消费折" forKey:@"cerditDesc"];
//        [borrow setObject:@"https://creditcard.ecitic.com/citiccard/cardshop-web/apply/toPageIndex.do?pid=CS0083&sid=WHSQK" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//    }
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        //        [borrow setObject:@1 forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"http://oq97ntj1q.bkt.clouddn.com/pufa.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"浦发银行" forKey:@"cerditName"];
//        [borrow setObject:@"享1-5折随机食惠，新户刷卡送刷卡金" forKey:@"cerditDesc"];
//        [borrow setObject:@"https://onlineapp.spdbccc.com.cn/ccoa/newccoapage/addr.jsp;jsessionid=jrTjZhpV6SX3R3wQ02HdpV6TwGjTg82kn5SQDmbSDf4FpXwvGJ5w!-1434990573?productCode=SPDB100052&customerType=1" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//    }
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        //        [borrow setObject:@1 forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"http://oq97ntj1q.bkt.clouddn.com/zheshang.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"浙商银行" forKey:@"cerditName"];
//        [borrow setObject:@"最长免息56天，5元看好莱坞大片" forKey:@"cerditDesc"];
//        [borrow setObject:@"https://e.czbank.com/APPINSPECT/WebBank" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//    }
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        //        [borrow setObject:@1 forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"http://oq97ntj1q.bkt.clouddn.com/zhaoshang.png"] forKey:@"cerditIcon"];
//        [borrow setObject:@"招商银行" forKey:@"cerditName"];
//        [borrow setObject:@"新户办卡成功就送1500积分" forKey:@"cerditDesc"];
//        [borrow setObject:@"https://ccclub.cmbchina.com/CrdCardApply/LoginChannelSelect.aspx?cardsel=8745" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//    }
//    {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        //        [borrow setObject:@1 forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"http://oq97ntj1q.bkt.clouddn.com/minsheng.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"民生银行" forKey:@"cerditName"];
//        [borrow setObject:@"外币交易，取现0手续费，多重优惠" forKey:@"cerditDesc"];
//        [borrow setObject:@"https://creditcard.cmbc.com.cn/onlinepc/logon/logon.jhtml?id=51&time=1495342901601" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//    }
    
}
//- (void)confirmData {
//    for (int i = 0; i <= 10; i ++) {
//        AVObject *borrow = [AVObject objectWithClassName:@"QDCerdit"];
//        [borrow setObject:[NSNumber numberWithInteger:i+1] forKey:@"cerditId"];
//        [borrow setObject:[NSString stringWithFormat:@"https://imgsa.baidu.com/baike/w%3D268/sign=a588ca9d06f41bd5da53eff269db81a0/024f78f0f736afc3a1a712d3bb19ebc4b64512d8.jpg"] forKey:@"cerditIcon"];
//        [borrow setObject:@"招商银行1" forKey:@"cerditName"];
//        [borrow setObject:@"购物加油5%，成功办卡享100元刷卡金" forKey:@"cerditDesc"];
//        [borrow setObject:@"http://www.baidu.com" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//
//    }
//    
//}
//    //创建数据
//    NSMutableArray *bannerArray = [[NSMutableArray alloc] init];
//    QDHomeBannerModel *bannerModel = [[QDHomeBannerModel alloc] init];
//    bannerModel.bannerId = 0;
//    bannerModel.imageUrl = @"http://obvn1tlyd.bkt.clouddn.com/d5fe3dc9c61e887b6d10c818a5eaf0b5.jpg";
//    bannerModel.bannerType = 0;
//    bannerModel.value = @"www.baidu.com";
//    
//    QDHomeBannerModel *bannerModel1 = [[QDHomeBannerModel alloc] init];
//    bannerModel1.bannerId = 0;
//    bannerModel1.imageUrl = @"http://obvn1tlyd.bkt.clouddn.com/ee0148764ceb62c3f826316c7e0aa3ce.jpeg";
//    bannerModel1.bannerType = 0;
//    bannerModel1.value = @"www.baidu.com";
//    
//    QDHomeBannerModel *bannerModel2 = [[QDHomeBannerModel alloc] init];
//    bannerModel2.bannerId = 0;
//    bannerModel2.imageUrl = @"http://obvn1tlyd.bkt.clouddn.com/9976dacbb2aad071270d87156820ef68.jpg";
//    bannerModel2.bannerType = 0;
//    bannerModel2.value = @"www.baidu.com";
//    
//    for (int i = 0; i <= 3; i ++) {
//        AVObject *banner = [AVObject objectWithClassName:@"QDBanner"];
//        [banner setObject:[NSNumber numberWithInt:i] forKey:@"bannerId"];
//        if (i == 0) {
//            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/ee0148764ceb62c3f826316c7e0aa3ce.jpeg" forKey:@"imageUrl"];
//        } else if(i == 2) {
//            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/d5fe3dc9c61e887b6d10c818a5eaf0b5.jpg" forKey:@"imageUrl"];
//        } else {
//            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/9976dacbb2aad071270d87156820ef68.jpg" forKey:@"imageUrl"];
//        }
//        [banner setObject:@0 forKey:@"bannerType"];
//        [banner setObject:@"www.baidu.com" forKey:@"value"];
//        [banner saveInBackground];
//    }
//    
//    
//    
//    [bannerArray addObject:[bannerModel yy_modelToJSONObject]];
//    [bannerArray addObject:[bannerModel1 yy_modelToJSONObject]];
//    [bannerArray addObject:[bannerModel2 yy_modelToJSONObject]];
//    
//    for (int i = 0; i <= 10; i ++) {
//        BorrowDetailModel *borrowModel = [[BorrowDetailModel alloc] init];
//        borrowModel.companyId = i;
//        borrowModel.imageIcon = @"https://imgsa.baidu.com/baike/w%3D268/sign=a588ca9d06f41bd5da53eff269db81a0/024f78f0f736afc3a1a712d3bb19ebc4b64512d8.jpg";
//        borrowModel.companyName = [NSString stringWithFormat:@"平安贷%d",i];
//        borrowModel.companyDetail = @"凭身份证2000-30000元 1-20月 最快三分钟放款";
//        borrowModel.peopleNum = 1233422;
//        borrowModel.maxMoney = 2000000;
//        borrowModel.minMoney = 1000;
//        borrowModel.amortizationNumArray = [NSArray arrayWithObjects:@"1",@"3",@"5", nil];
//        borrowModel.fastestTime = @"3分钟";
//        borrowModel.qualificationArray = [NSArray arrayWithObjects:@"18岁到55周岁，中国大陆身份证公民",@"全日制大专以上学历", nil];
//        borrowModel.dataArray = [NSArray arrayWithObjects:@"身份证拍照",@"刷脸识别",@"提供通讯录和联系人", nil];
//        borrowModel.bshowAtHome = 1;
//        
//        AVObject *borrow = [AVObject objectWithClassName:@"QDBorrow"];
//        [borrow setObject:[NSNumber numberWithInteger:i] forKey:@"companyId"];
//        [borrow setObject:@"https://imgsa.baidu.com/baike/w%3D268/sign=a588ca9d06f41bd5da53eff269db81a0/024f78f0f736afc3a1a712d3bb19ebc4b64512d8.jpg" forKey:@"imageIcon"];
//        [borrow setObject:[NSString stringWithFormat:@"平安贷%d",i] forKey:@"companyName"];
//        [borrow setObject:@"凭身份证2000-30000元 1-20月 最快三分钟放款" forKey:@"companyDetail"];
//        [borrow setObject:@1233422 forKey:@"peopleNum"];
//        [borrow setObject:@2000000 forKey:@"maxMoney"];
//        [borrow setObject:@1000 forKey:@"minMoney"];
//        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5", nil] forKey:@"amortizationNumArray"];
//        [borrow setObject:@"3分钟" forKey:@"fastestTime"];
//        [borrow setObject:[NSArray arrayWithObjects:@"18岁到55周岁，中国大陆身份证公民",@"全日制大专以上学历", nil] forKey:@"qualificationArray"];
//        [borrow setObject:[NSArray arrayWithObjects:@"身份证拍照",@"刷脸识别",@"提供通讯录和联系人", nil] forKey:@"dataArray"];
//        [borrow setObject:@1 forKey:@"bshowAtHome"];
//        [borrow setObject:@"www.baidu.com" forKey:@"redirectUrl"];
//        [borrow saveInBackground];
//        
//        
//    }
//}

- (void)confirmUI {
    self.title = @"首页";
    //初始化tableView
    self.tableView.tableHeaderView = nil;
//    self.tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerClass:[QDBannerTableViewCell class] forCellReuseIdentifier:kReusableIdentifierBannerCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"QBBusinessTableViewCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCompanyCell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(configData)];
//    self.registButton = [[QMUIButton alloc] init];
//    self.registButton.titleLabel.font = UIFontMake(15);
//    self.registButton.adjustsTitleTintColorAutomatically = YES;
//    [self.registButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.registButton setTitle:@"注册" forState:UIControlStateNormal];
//    self.registButton.frame = CGRectMake(0, 100, 200, 60);
//    [self.registButton addTarget:self action:@selector(registerUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.registButton];
//    
//    self.loginButton = [[QMUIButton alloc] init];
//    self.loginButton.titleLabel.font = UIFontMake(15);
//    self.loginButton.adjustsTitleTintColorAutomatically = YES;
//    [self.loginButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.loginButton setTitle:@"登陆" forState:UIControlStateNormal];
//    self.loginButton.frame = CGRectMake(0, 170, 200, 60);
//    [self.loginButton addTarget:self action:@selector(loginUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.loginButton];
//    
//    self.statusButton = [[QMUIButton alloc] init];
//    self.statusButton.titleLabel.font = UIFontMake(15);
//    self.statusButton.adjustsTitleTintColorAutomatically = YES;
//    [self.statusButton setTitleColor:UIColorMake(124, 124, 124) forState:UIControlStateNormal];
//    [self.statusButton setTitle:@"状态" forState:UIControlStateNormal];
//    self.statusButton.frame = CGRectMake(0, 230, 200, 60);
//    [self.statusButton addTarget:self action:@selector(loginUserClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.statusButton];
//    
    
}

#pragma mark - <QMUITableViewDataSource,QMUITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.homeModel) {
        if (section == 0) {
            if (self.homeModel.bannerArray && self.homeModel.bannerArray.count) {
                return 1;
            }
            return 0;
        } else {
            if (self.homeModel.borrowDetailArray && self.homeModel.borrowDetailArray.count) {
                return self.homeModel.borrowDetailArray.count;
            }
            return 0;
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QDBannerTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierBannerCell];
        bannerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        bannerCell.bannerList = self.homeModel.bannerArray;
        bannerCell.delegate = self;
        return bannerCell;
    } else {
        QBBusinessTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCompanyCell];
        companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.homeModel.borrowDetailArray.count >= indexPath.row) {
            companyCell.borrowModel = self.homeModel.borrowDetailArray[indexPath.row];
        }
        return companyCell;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200 * SCREEN_WIDTH / 375;
    } else {
        return 76;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"热门借贷";
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 30;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        BorrowDetailModel *borrowModel = self.homeModel.borrowDetailArray[indexPath.row];
        QDCompanyDetailController *companyDetailViewController = [[QDCompanyDetailController alloc] init];
        companyDetailViewController.borrowModel = borrowModel;
        [self.navigationController pushViewController:companyDetailViewController animated:YES];
    }
    
}


//- (void)registerUserClick {
//    LoginService *loginService = [[LoginService alloc] init];
//    [loginService registUser:@"dashuai" password:@"123456" email:@"feng_xing@126.com" block:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            NSLog(@"注册成功");
//        }else {
//            
//        }
//    }];
//}
//
//- (void)loginUserClick {
//    LoginService *loginService = [[LoginService alloc] init];
//    [loginService loginUser:@"dashuai" andPassword:@"123456" block:^(AVUser * _Nullable user, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"登陆失败");
//        }else {
//            //处理登陆成功
//        }
//    }];
//}
//
//- (void)userStatus {
//    AVUser *user = [AVUser currentUser];
//    NSLog(@"user %@",user.username);
//}

- (void)cellOfBannerClick:(QDHomeBannerModel *)banner {
    if (!banner.showDetail) {
        return;
    }
    //轮播图片点击事件
    NSString *redirectUrl = banner.value;
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

@end
