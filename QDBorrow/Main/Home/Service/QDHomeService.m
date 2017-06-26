//
//  QDHomeService.m
//  QDBorrow
//
//  Created by larou on 2017/6/26.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDHomeService.h"
#import <BmobSDK/Bmob.h>
NSString *const kClassNameTabbarStatus = @"TCSwitch";

@implementation QDHomeService

+ (id)sharedInstance
{
    static QDHomeService *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)changeTabbarWithBlock:(BmobObjectResultBlock)block {
    BmobQuery *query = [BmobQuery queryWithClassName:kClassNameTabbarStatus];
    [query getObjectInBackgroundWithId:@"KX3J555B" block:block];
    
}

- (void)saveHomeData {
    
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(1) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/qianzhan.png" forKey:@"imageIcon"];
        [borrow setObject:@"钱站" forKey:@"companyName"];
        [borrow setObject:@"2000-100000随借秒放款" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualificationArray"];
        [borrow setObject:@"身份证号码既可" forKey:@"dataArray"];
        
        borrow[@"companyId"] = @(1);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/qianzhan.png";
        borrow[@"companyName"] = @"钱站";
        borrow[@"companyDetail"] = @"2000-100000随借秒放款";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"24小时内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"18岁到55周岁，中国大陆身份证公民", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @457321;
        [borrow saveInBackground];
    }
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(2);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/xinerfu.png";
        borrow[@"companyName"] = @"信而富";
        borrow[@"companyDetail"] = @"500－6000任性借，快速审核秒到账";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @876531;
        [borrow saveInBackground];
    }
    
    //3
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(3);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/caocaodai.png";
        borrow[@"companyName"] = @"曹操贷";
        borrow[@"companyDetail"] = @"借款找曹操，说到就到，5分钟评估额度，2小时放款，借钱就是快";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"24小时内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @1067631;
        [borrow saveInBackground];
        
    }
    
    //3
    
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(4);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/yongqianbao.png";
        borrow[@"companyName"] = @"用钱宝";
        borrow[@"companyDetail"] = @"30分钟审核，最快2小时快速放款";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"http://www.yongqianbao.com/wr/launch-register";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @1275531;
        [borrow saveInBackground];
    }
    
    
    //5
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(5);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/daishangqian.png";
        borrow[@"companyName"] = @"贷上钱";
        borrow[@"companyDetail"] = @"0门槛，3分钟极速审核，88秒现金到账";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://www.daishangqian.com/vue/";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @779931;
        [borrow saveInBackground];
    }
    
    //6
    {
        {
            BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
            borrow[@"companyId"] = @(6);
            borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/xianjinbus.jpg";
            borrow[@"companyName"] = @"现金巴士";
            borrow[@"companyDetail"] = @"提前月光不用慌,现金巴士帮您忙!";
            borrow[@"maxMoney"] = @29000;
            borrow[@"minMoney"] = @1000;
            borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
            borrow[@"fastestTime"] = @"10分钟内";
            borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
            borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
            borrow[@"bshowAtHome"] = @1;
            borrow[@"redirectUrl"] = @"https://www.cashbus.com/#overview";
            borrow[@"monthyRate"] = @0.76;
            borrow[@"showButton"] = @0;
            borrow[@"peopleNum"] = @1765310;
            [borrow saveInBackground];
        }
    }
    
    //7
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(7);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/rong360.jpg";
        borrow[@"companyName"] = @"融360网贷";
        borrow[@"companyDetail"] = @"用卡及理财在线搜索和申请服务";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://www.rong360.com/";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @928422;
        [borrow saveInBackground];
    }
    
    //8
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(9);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/rong360.jpg";
        borrow[@"companyName"] = @"融360信用卡";
        borrow[@"companyDetail"] = @"专注于金融领域的智能搜索平台,为企业和个人提供专业的贷款、信用卡及理财在线搜索和申请服务";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://www.rong360.com/";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @765332;
        [borrow saveInBackground];
    }
    
    //9
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(10);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/doudouqian.jpg";
        borrow[@"companyName"] = @"豆豆钱";
        borrow[@"companyDetail"] = @"用豆豆钱贷款，借钱省事！";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"http://www.ddcash.cn/register.html";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @984390;
        [borrow saveInBackground];
    }
    //10
    
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(11);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/haodai.png";
        borrow[@"companyName"] = @"好贷信用卡";
        borrow[@"companyDetail"] = @"申请信用卡，用好贷！";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @238640;
        [borrow saveInBackground];
    }
    
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(12);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/yiyiyuan.jpg";
        borrow[@"companyName"] = @"先花一亿元";
        borrow[@"companyDetail"] = @"在线审批，快速贷款！";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @876322;
        [borrow saveInBackground];
    }
    
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(12);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/daxiaodai.jpg";
        borrow[@"companyName"] = @"大小贷";
        borrow[@"companyDetail"] = @"线上操作快速审核到账,最高可借款5000元";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"24小时内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
        borrow[@"monthyRate"] = @0.76;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @1865322;
        [borrow saveInBackground];
    }
    
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        borrow[@"companyId"] = @(13);
        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/jidai.jpg";
        borrow[@"companyName"] = @"及贷";
        borrow[@"companyDetail"] = @"手机贷款,0门槛0抵押0担保,3步完成申请,通过率高,周期灵活,可借1万元!";
        borrow[@"maxMoney"] = @29000;
        borrow[@"minMoney"] = @1000;
        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
        borrow[@"fastestTime"] = @"10分钟内";
        borrow[@"qualificationArray"] = [NSArray arrayWithObjects:@"人人皆可", nil];
        borrow[@"dataArray"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
        borrow[@"bshowAtHome"] = @1;
        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
        borrow[@"monthyRate"] = @0.90;
        borrow[@"showButton"] = @0;
        borrow[@"peopleNum"] = @28873733;
        [borrow saveInBackground];
    }
}


@end
