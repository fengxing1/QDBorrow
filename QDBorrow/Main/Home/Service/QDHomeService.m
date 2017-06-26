//
//  QDHomeService.m
//  QDBorrow
//
//  Created by larou on 2017/6/26.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDHomeService.h"


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

- (void)homeBannerDataWithBlock:(BmobObjectArrayResultBlock)block {
    BmobQuery *query = [BmobQuery queryWithClassName:@"QDBorrow"];
    [query findObjectsInBackgroundWithBlock:block];
    
}

- (void)homeBorrowDataWithBlock:(BmobObjectArrayResultBlock)block {
    BmobQuery *query = [BmobQuery queryWithClassName:@"QDBorrow"];
    [query whereKey:@"bshowAtHome" equalTo:@1];
    [query findObjectsInBackgroundWithBlock:block];
}


- (void)saveHomeData {
    for (int i = 0; i <= 3; i ++) {
        BmobObject *banner = [BmobObject objectWithClassName:@"QDBanner"];
        [banner setObject:[NSNumber numberWithInt:i] forKey:@"bannerId"];
        if (i == 0) {
            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/ee0148764ceb62c3f826316c7e0aa3ce.jpeg" forKey:@"imageUrl"];
        } else if(i == 2) {
            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/d5fe3dc9c61e887b6d10c818a5eaf0b5.jpg" forKey:@"imageUrl"];
        } else {
            [banner setObject:@"http://obvn1tlyd.bkt.clouddn.com/9976dacbb2aad071270d87156820ef68.jpg" forKey:@"imageUrl"];
        }
        [banner setObject:@0 forKey:@"bannerType"];
        [banner setObject:@"www.baidu.com" forKey:@"value"];
        [banner saveInBackground];
    }

    
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
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject:@"https://promotion.crfchina.com/localMarket/index.html" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];
    }
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(2) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/xinerfu.png" forKey:@"imageIcon"];
        [borrow setObject:@"信而富" forKey:@"companyName"];
        [borrow setObject:@"2000-100000随借秒放款" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject:@"https://promotion.crfchina.com/localMarket/index.html" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];
        
    }
    
    //3
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(3) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/caocaodai.png" forKey:@"imageIcon"];
        [borrow setObject:@"曹操贷" forKey:@"companyName"];
        [borrow setObject:@"借款找曹操，说到就到，5分钟评估额度，2小时放款，借钱就是快" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject:@"https://promotion.crfchina.com/localMarket/index.html" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];
        
    }
    
    //4
    
    {
        
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(4) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/yongqianbao.png" forKey:@"imageIcon"];
        [borrow setObject:@"用钱宝" forKey:@"companyName"];
        [borrow setObject:@"30分钟审核，最快2小时快速放款" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject:@"http://www.yongqianbao.com/wr/launch-register" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];

    }
    
    //5
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(5) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/daishangqian.png" forKey:@"imageIcon"];
        [borrow setObject:@"贷上钱" forKey:@"companyName"];
        [borrow setObject:@"0门槛，3分钟极速审核，88秒现金到账" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject: @"https://www.daishangqian.com/vue/" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];
    }
    
    //6
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(6) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/xianjinbus.jpg" forKey:@"imageIcon"];
        [borrow setObject:@"现金巴士" forKey:@"companyName"];
        [borrow setObject:@"提前月光不用慌,现金巴士帮您忙!" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject: @"https://www.cashbus.com/#overview" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];
    }
    
    //7
    {
        
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(7) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/rong360.jpg" forKey:@"imageIcon"];
        [borrow setObject:@"融360网贷" forKey:@"companyName"];
        [borrow setObject:@"用卡及理财在线搜索和申请服务" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject: @"https://www.cashbus.com/#overview" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];

        
    }
    
    //8
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(8) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/rong360.jpg" forKey:@"imageIcon"];
        [borrow setObject:@"融360网贷" forKey:@"companyName"];
        [borrow setObject:@"专注于金融领域的智能搜索平台,为企业和个人提供专业的贷款、信用卡及理财在线搜索和申请服务" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject: @"https://www.rong360.com/" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];
        
    }
    
    //9
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(9) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/doudouqian.jpg" forKey:@"imageIcon"];
        [borrow setObject:@"豆豆钱" forKey:@"companyName"];
        [borrow setObject:@"用豆豆钱贷款，借钱省事！" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject: @"http://www.ddcash.cn/register.html" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];
        
    }
    //10
    {
        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
        [borrow setObject:@(10) forKey:@"companyId"];
        [borrow setObject:@"http://oq97ntj1q.bkt.clouddn.com/haodai.png" forKey:@"imageIcon"];
        [borrow setObject:@"好贷信用卡" forKey:@"companyName"];
        [borrow setObject:@"申请信用卡，用好贷！" forKey:@"companyDetail"];
        [borrow setObject:@29000 forKey:@"maxMoney"];
        [borrow setObject:@1000 forKey:@"minMoney"];
        [borrow setObject:[NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil] forKey:@"amortizationNumArray"];
        [borrow setObject: @"24小时内" forKey:@"fastestTime"];
        [borrow setObject:@"18岁到55周岁，中国大陆身份证公民" forKey:@"qualification"];
        [borrow setObject:@"身份证号码既可" forKey:@"needdata"];
        [borrow setObject:@1 forKey:@"bshowAtHome"];
        [borrow setObject: @"http://www.ddcash.cn/register.html" forKey:@"redirectUrl"];
        [borrow setObject:@0.76 forKey:@"monthyRate"];
        [borrow setObject:@0 forKey:@"showButton"];
        [borrow setObject:@457321 forKey:@"peopleNum"];
        [borrow saveInBackground];

        
//        
//        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(11);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/haodai.png";
//        borrow[@"companyName"] = @"好贷信用卡";
//        borrow[@"companyDetail"] = @"申请信用卡，用好贷！";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualification"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"needdata"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @238640;
//        [borrow saveInBackground];
//    }
//    
//    {
//        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(12);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/yiyiyuan.jpg";
//        borrow[@"companyName"] = @"先花一亿元";
//        borrow[@"companyDetail"] = @"在线审批，快速贷款！";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualification"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"needdata"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @876322;
//        [borrow saveInBackground];
//    }
//    
//    {
//        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(12);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/daxiaodai.jpg";
//        borrow[@"companyName"] = @"大小贷";
//        borrow[@"companyDetail"] = @"线上操作快速审核到账,最高可借款5000元";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"24小时内";
//        borrow[@"qualification"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"needdata"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.76;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @1865322;
//        [borrow saveInBackground];
//    }
//    
//    {
//        BmobObject *borrow = [BmobObject objectWithClassName:@"QDBorrow"];
//        borrow[@"companyId"] = @(13);
//        borrow[@"imageIcon"] = @"http://oq97ntj1q.bkt.clouddn.com/jidai.jpg";
//        borrow[@"companyName"] = @"及贷";
//        borrow[@"companyDetail"] = @"手机贷款,0门槛0抵押0担保,3步完成申请,通过率高,周期灵活,可借1万元!";
//        borrow[@"maxMoney"] = @29000;
//        borrow[@"minMoney"] = @1000;
//        borrow[@"amortizationNumArray"] = [NSArray arrayWithObjects:@"1",@"3",@"5",@"6",@"7",@"8",@"12",@"15",nil];
//        borrow[@"fastestTime"] = @"10分钟内";
//        borrow[@"qualification"] = [NSArray arrayWithObjects:@"人人皆可", nil];
//        borrow[@"needdata"] = [NSArray arrayWithObjects:@"身份证号码既可",nil];
//        borrow[@"bshowAtHome"] = @1;
//        borrow[@"redirectUrl"] = @"https://promotion.crfchina.com/localMarket/index.html";
//        borrow[@"monthyRate"] = @0.90;
//        borrow[@"showButton"] = @0;
//        borrow[@"peopleNum"] = @28873733;
//        [borrow saveInBackground];
    }
}


@end
