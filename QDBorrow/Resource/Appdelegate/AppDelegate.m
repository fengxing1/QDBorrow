//
//  AppDelegate.m
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/6.
//  Copyright © 2017年 zks. All rights reserved.
//

#import "AppDelegate.h"
#import "QMUIConfigurationTemplate.h"
#import "QDCommonUI.h"
#import "QDUIHelper.h"
#import "QDTabBarViewController.h"
#import "HomeViewController.h"
#import "QDNavigationController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "QDCompanyViewController.h"
#import "QDCertViewController.h"
#import "QDMyViewController.h"
#import "BaiduMobStat.h"

#import <SobotKit/SobotKit.h>
#import <UserNotifications/UserNotifications.h>
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


#define APP_ID @"QGSs41nGgfDofETOfRgAKdSj-gzGzoHsz"
#define APP_KEY @"fmavP4Ny83CAmboSlDCWpQl3"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#if DEBUG 
    
#else 
    [self initFabric];
    [self startBaiduMobileStat];
    
#endif
    
    [AVOSCloud setApplicationId:APP_ID clientKey:APP_KEY];
    
    // 启动 QMUI 的样式配置模板
    [QMUIConfigurationTemplate setupConfigurationTemplate];
    // QD自定义的全局样式渲染
    [QDCommonUI renderGlobalAppearances];
    
    // 将状态栏设置为希望的样式
    [QMUIHelper renderStatusBarStyleLight];
    
    // 预加载 QQ 表情，避免第一次使用时卡顿
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [QMUIQQEmotionManager emotionsForQQ];
//    });
    // 界面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self createTabBarController];
    
    // 启动动画
    [self startLaunchingAnimation];
    
    //添加智齿
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    if (SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert |UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }else{
        [self registerPush:application];
    }
    [[ZCLibClient getZCLibClient].libInitInfo setAppKey:@"976587bdd707439f8ae1b604103dc7ac"];
    // 设置推送是否是测试环境，测试环境将使用开发证书
#if DEBUG
    [[ZCLibClient getZCLibClient] setIsDebugMode:YES];
#else
   [[ZCLibClient getZCLibClient] setIsDebugMode:NO];
    
#endif
//    [[ZCLibClient getZCLibClient] setIsDebugMode:YES];
    // 错误日志收集
    [ZCLibClient setZCLibUncaughtExceptionHandler];

    return YES;
}

-(void)registerPush:(UIApplication *)application{
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //IOS8
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:notiSettings];
        
    } else{ // ios7
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge                                       |UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken{
    NSLog(@"---Token--%@", pToken);
    // 注册token
    [[ZCLibClient getZCLibClient] setToken:pToken];
}

//点击推送消息后回调
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
}


// 启动百度移动统计
- (void)startBaiduMobileStat{
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.enableDebugOn = YES;
    [statTracker startWithAppId:@"302621a2c7"];
}


- (void)createTabBarController {
    QDTabBarViewController *tabBarViewController = [[QDTabBarViewController alloc] init];
    
    // 首页
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    homeViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *homeViewNavController = [[QDNavigationController alloc] initWithRootViewController:homeViewController];
    homeViewController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页" image:[UIImageMake(@"icon_tabbar_uikit") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_uikit_selected") tag:0];
    
    // 找贷款
    QDCompanyViewController *loanViewController = [[QDCompanyViewController alloc] init];
    loanViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *loanNavController = [[QDNavigationController alloc] initWithRootViewController:loanViewController];
    loanNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"找贷款" image:[UIImageMake(@"icon_tabbar_component") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_component_selected") tag:1];
    
    // 信用卡
//    QDCertViewController *cerditController = [[QDCertViewController alloc] init];
//    QDNavigationController *certNavController = [[QDNavigationController alloc] initWithRootViewController:cerditController];
//    cerditController.hidesBottomBarWhenPushed = NO;
//    certNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"信用卡" image:[UIImageMake(@"icon_tabbar_lab") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_lab_selected") tag:2];
    
    //我的
    QDMyViewController *myViewController = [[QDMyViewController alloc] init];
    myViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *myNavController = [[QDNavigationController alloc] initWithRootViewController:myViewController];
    myNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我的" image:[UIImageMake(@"icon_tabbar_lab") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_component_selected") tag:4];
    
    // window root controller
    tabBarViewController.viewControllers = @[homeViewNavController, loanNavController,myNavController];
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];
}

- (UIViewController *)sobotViewController {
    //  初始化配置信息
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    
    [self setZCLibInitInfoParam:initInfo];
    
    //自定义用户参数
    [self customUserInformationWith:initInfo];
    
    ZCKitInfo *uiInfo=[ZCKitInfo new];
    
    
    // 自定义UI(设置背景颜色相关)
    [self customerUI:uiInfo];
    
    
    // 之定义商品和留言页面的相关UI
    [self customerGoodAndLeavePageWithParameter:uiInfo];
    
    // 未读消息
//    [self customUnReadNumber:uiInfo];
    
    // 测试模式
    [ZCSobot setShowDebug:NO];
    
    [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
    ZCUIChatController *chatController = [[ZCUIChatController alloc] initWithInitInfo:initInfo];
    return chatController;
}



// 自定义参数 商品信息相关
- (void)customerGoodAndLeavePageWithParameter:(ZCKitInfo *)uiInfo{
    
    // 商品信息自定义
//    if (_isShowGoodsSwitch.on) {
//        ZCProductInfo *productInfo = [ZCProductInfo new];
//        productInfo.thumbUrl = _goodsImgTF.text;
//        productInfo.title = _goodsTitleTF.text;
//        productInfo.desc = _goodsSummaryTF.text;
//        productInfo.label = _goodTagTF.text;
//        productInfo.link = _goodsSendTF.text;
//        
//        [[NSUserDefaults standardUserDefaults] setObject:productInfo.thumbUrl forKey:@"goods_IMG"];
//        [[NSUserDefaults standardUserDefaults] setObject:productInfo.title forKey:@"goods_Title"];
//        [[NSUserDefaults standardUserDefaults] setObject:productInfo.desc forKey:@"goods_SENDMGS"];
//        [[NSUserDefaults standardUserDefaults] setObject:productInfo.label forKey:@"glabel_Text"];
//        [[NSUserDefaults standardUserDefaults] setObject:productInfo.link forKey:@"gPageUrl_Text"];
//        uiInfo.productInfo = productInfo;
//    }
#warning // 测试环境接口，上线demo去掉不在使用
    
    uiInfo.apiHost = @"http://test.sobot.com";
    
    // 设置电话号和昵称（留言界面的显示）
//    uiInfo.isAddNickName = 1;
//    uiInfo.isShowNickName = 1;
//    if(_hostTF.text!=nil){
//        uiInfo.apiHost = _hostTF.text;
//    }
    //    uiInfo.apiHost = @"http://test.sobot.com";
    
}

- (void)setZCLibInitInfoParam:(ZCLibInitInfo *)initInfo{
    // 获取AppKey
    initInfo.appKey = @"1ff3e4ff91314f5ca308e19570ba24bb";
    initInfo.skillSetId = @"";
    initInfo.skillSetName = @"";
    initInfo.receptionistId = @"";
    initInfo.robotId = @"";
    initInfo.tranReceptionistFlag = 0;
//    initInfo.scopeTime = 0;
    initInfo.titleType = 0;
    initInfo.customTitle = @"1221";
    
}

// 设置UI部分
-(void) customerUI:(ZCKitInfo *) kitInfo{
    kitInfo.isCloseAfterEvaluation = YES;
    
    /**
     *  自定义信息
     */
    // 顶部导航条标题文字 评价标题文字 系统相册标题文字 评价客服（立即结束 取消）按钮文字
    //    kitInfo.titleFont = [UIFont systemFontOfSize:30];
    
    // 返回按钮      输入框文字   评价客服是否有以下情况 label 文字  提价评价按钮
    //    kitInfo.listTitleFont = [UIFont systemFontOfSize:22];
    
    //没有网络提醒的button 没有更多记录label的文字    语音tipLabel的文字   评价不满意（4个button）文字  占位图片的lablel文字   语音输入时间label文字   语音输入的按钮文字
    //    kitInfo.listDetailFont = [UIFont systemFontOfSize:25];
    
    // 录音按钮的文字
    //    kitInfo.voiceButtonFont = [UIFont systemFontOfSize:25];
    // 消息提醒 （转人工、客服接待等）
    //    kitInfo.listTimeFont = [UIFont systemFontOfSize:22];
    
    // 聊天气泡中的文字
    //    kitInfo.chatFont  = [UIFont systemFontOfSize:22];
    
    // 聊天的背景颜色
    //    kitInfo.backgroundColor = [UIColor redColor];
    
    // 导航、客服气泡、线条的颜色
    //        kitInfo.customBannerColor  = [UIColor redColor];
    
    // 左边气泡的颜色
    //        kitInfo.leftChatColor = [UIColor redColor];
    
    // 右边气泡的颜色
    //        kitInfo.rightChatColor = [UIColor redColor];
    
    // 底部bottom的背景颜色
    //    kitInfo.backgroundBottomColor = [UIColor redColor];
    
    // 底部bottom的输入框线条背景颜色
    //    kitInfo.bottomLineColor = [UIColor redColor];
    
    // 提示气泡的背景颜色
    //    kitInfo.BgTipAirBubblesColor = [UIColor redColor];
    
    // 顶部文字的颜色
    //    kitInfo.topViewTextColor  =  [UIColor redColor];
    
    // 提示气泡文字颜色
    //        kitInfo.tipLayerTextColor = [UIColor redColor];
    
    // 评价普通按钮选中背景颜色和边框(默认跟随主题色customBannerColor)
    //        kitInfo.commentOtherButtonBgColor=[UIColor redColor];
    
    // 评价(立即结束、取消)按钮文字颜色(默认跟随主题色customBannerColor)
    //    kitInfo.commentCommitButtonColor = [UIColor redColor];
    
    //评价提交按钮背景颜色和边框(默认跟随主题色customBannerColor)
    //    kitInfo.commentCommitButtonBgColor = [UIColor redColor];
    
    //    评价提交按钮点击后背景色，默认0x089899, 0.95
    //    kitInfo.commentCommitButtonBgHighColor = [UIColor yellowColor];
    
    // 左边气泡文字的颜色
    //    kitInfo.leftChatTextColor = [UIColor redColor];
    
    // 右边气泡文字的颜色[注意：语音动画图片，需要单独替换]
    //    kitInfo.rightChatTextColor  = [UIColor redColor];
    
    // 时间文字的颜色
    //    kitInfo.timeTextColor = [UIColor redColor];
    
    // 客服昵称颜色
    //        kitInfo.serviceNameTextColor = [UIColor redColor];
    
    
    // 提交评价按钮的文字颜色
    //    kitInfo.submitEvaluationColor = [UIColor redColor];
    
    // 相册的导航栏背景颜色
    
    //    kitInfo.imagePickerColor = _selectedColor;
    // 相册的导航栏标题的文字颜色
    //    kitInfo.imagePickerTitleColor = [UIColor redColor];
    
    // 左边超链的颜色
    //        kitInfo.chatLeftLinkColor = [UIColor blueColor];
    
    // 右边超链的颜色
    //        kitInfo.chatRightLinkColor =[UIColor redColor];
    
    // 提示客服昵称的文字颜色
    //    kitInfo.nickNameTextColor = [UIColor redColor];
    // 相册的导航栏是否设置背景图片(图片来自SobotKit.bundle中ZCIcon_navcBgImage)
    //    kitInfo.isSetPhotoLibraryBgImage = YES;
    
    // 富媒体cell中线条的背景色
    //    kitInfo.LineRichColor = [UIColor redColor];
    
    //    // 语音cell选中的背景颜色
    //    kitInfo.videoCellBgSelColor = [UIColor redColor];
    //
    //    // 商品cell中标题的文字颜色
    //    kitInfo.goodsTitleTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中摘要的文字颜色
    //    kitInfo.goodsDetTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中标签的文字颜色
    //    kitInfo.goodsTipTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中发送的文字颜色
    //    kitInfo.goodsSendTextColor = [UIColor redColor];
    
    // 发送按钮的背景色
    //        kitInfo.goodSendBtnColor = [UIColor yellowColor];
    
    // “连接中。。。”  button 的背景色和文字的颜色
    //    kitInfo.socketStatusButtonBgColor  = [UIColor yellowColor];
    //    kitInfo.socketStatusButtonTitleColor = [UIColor redColor];
}

// 自定义用户信息参数
- (void)customUserInformationWith:(ZCLibInitInfo*)initInfo{
    initInfo.userId         = @"123";
    //    initInfo.customInfo = @{@"标题1":@"自定义1",@"内容1":@"我是一个自定义字段。",@"标题2":@"自定义字段2",@"内容2":@"我是一个自定义字段，我是一个自定义字段，我是一个自定义字段，我是一个自定义字段。",@"标题3":@"自定义字段字段3",@"内容3":@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",@"标题4":@"自定义4",@"内容4":@"我是一个自定义字段 https://www.sobot.com/chat/pc/index.html?sysNum=9379837c87d2475dadd953940f0c3bc8&partnerId=112"};
    
    NSUserDefaults *user  = [NSUserDefaults standardUserDefaults];
    initInfo.email        = [user valueForKey:@"email"];
    initInfo.avatarUrl    = [user valueForKey:@"avatarUrl"];
    initInfo.sourceURL    = [user valueForKey:@"sourceURL"];
    initInfo.sourceTitle  = [user valueForKey:@"sourceTitle"];
    initInfo.serviceMode  = 0;
    
    // 以下字段为方便测试使用，上线打包时注掉
    initInfo.phone       = [user valueForKey:@"phone"];
    initInfo.nickName    = [user valueForKey:@"nickName"];
    // 微信，微博，用户的真实昵称，生日，备注性别 QQ号
    // 生日字段用户传入的格式，例：20170323，如果不是这个格式，初始化接口会给过滤掉
    
    initInfo.qqNumber = [user valueForKey:@"qqNumber"];
    initInfo.userSex = [user valueForKey:@"userSex"];
    initInfo.realName = [user valueForKey:@"useName"];
    initInfo.weiBo = [user valueForKey:@"weiBo"];
    initInfo.weChat = [user valueForKey:@"weChat"];
    initInfo.userBirthday = [user valueForKey:@"userBirthday"];
    initInfo.userRemark = [user valueForKey:@"userRemark"];
    
    
    //    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:initInfo.phone,@"tel",useName,@"realname",initInfo.email,@"email",initInfo.nickName,@"uname" ,weChat,@"weixin",weibo,@"weibo",sex,@"sex",userBirthday,@"birthday",userRemark,@"remark",initInfo.avatarUrl,@"face",qq,@"qq",initInfo.sourceURL,@"visitUrl",initInfo.sourceTitle,@"visitTitle",@"自定义1",@"标题1",@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",@"内容3",nil];
    //    initInfo.customInfo = dict;
    initInfo.customInfo = @{
                            
                            @"标题1":@"自定义1",
                            @"内容1":@"我是一个自定义字段。",
                            @"标题2":@"自定义字段2",
                            @"内容2":@"我是一个自定义字段，我是一个自定义字段，我是一个自定义字段，我是一个自定义字段。",
                            @"标题3":@"自定义字段字段3",
                            @"内容3":@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",
                            @"标题4":@"自定义4",
                            @"内容4":@"我是一个自定义字段 https://www.sobot.com/chat/pc/index.html?sysNum=9379837c87d2475dadd953940f0c3bc8&partnerId=112"
                            };
    
}


- (void)startLaunchingAnimation {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIView *launchScreenView = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil].firstObject;
    launchScreenView.frame = window.bounds;
    [window addSubview:launchScreenView];
    
    UIImageView *backgroundImageView = launchScreenView.subviews[0];
    backgroundImageView.clipsToBounds = YES;
    
    UIImageView *logoImageView = launchScreenView.subviews[1];
    UILabel *copyrightLabel = launchScreenView.subviews.lastObject;
    
    UIView *maskView = [[UIView alloc] initWithFrame:launchScreenView.bounds];
    maskView.backgroundColor = UIColorWhite;
    [launchScreenView insertSubview:maskView belowSubview:backgroundImageView];
    
    [launchScreenView layoutIfNeeded];
    
    
    [launchScreenView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:@"bottomAlign"]) {
            obj.active = NO;
            [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:launchScreenView attribute:NSLayoutAttributeTop multiplier:1 constant:NavigationContentTop].active = YES;
            *stop = YES;
        }
    }];
    
    [UIView animateWithDuration:.15 delay:0.9 options:QMUIViewAnimationOptionsCurveOut animations:^{
        [launchScreenView layoutIfNeeded];
        logoImageView.alpha = 0.0;
        copyrightLabel.alpha = 0;
    } completion:nil];
    [UIView animateWithDuration:1.2 delay:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
        maskView.alpha = 0;
        backgroundImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [launchScreenView removeFromSuperview];
    }];
}

- (void)initFabric {
    //Fabric设置
    [Fabric with:@[[Crashlytics class]]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
