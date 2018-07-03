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
#import "QDForumViewController.h"
#import "QDJumpViewController.h"
#import "GVUserDefaults.h"
#import "AdvertiseHelper.h"
#import "introductoryPagesHelper.h"
#import <BmobSDK/Bmob.h>
#import "QDBorrowMessageViewController.h"
#import <SobotKit/SobotKit.h>
#import <UserNotifications/UserNotifications.h>
#import "QDBorrowHomeViewController.h"
#import "QDBorrowMessageViewController.h"
#import "TMControlManagerViewController.h"
#import "TMSideViewController.h"
#import "MMDrawerController.h"
#import "YTKNetworkConfig.h"

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


#define APP_ID @"QGSs41nGgfDofETOfRgAKdSj-gzGzoHsz"
#define APP_KEY @"fmavP4Ny83CAmboSlDCWpQl3"
#define BMOB_APP_ID @"5972c80f22b4adf964317188a0e6675c"

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
    [self didChangeStatusFrameNotification];
//    [Bmob registerWithAppKey:BMOB_APP_ID];
    
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
    [self setupLoginViewController];
    
    // 启动动画
    [self startLaunchingAnimation];
    
    
    
//    //启动广告（记得放最后，才可以盖在页面上面）
//    [self setupAdveriseView];
    
    //添加智齿
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    if (SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert |UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                dispatch_async(dispatch_get_main_queue(),^{
                     [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
                
               
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

    [self setNetworkBaseUrl];
    
    return YES;
}

- (void)setNetworkBaseUrl {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://101.132.109.136:8080/";
    config.debugLogEnabled = YES;
}



//先跳转到首页
- (void)setupLoginViewController {
    QDJumpViewController *jumpViewController = [[QDJumpViewController alloc] init];
    self.window.rootViewController = jumpViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma mark 启动广告
-(void)setupAdveriseView
{
    // TODO 请求广告接口 获取广告图片
    
    //现在了一些固定的图片url代替
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    
    [AdvertiseHelper showAdvertiserView:imageArray];
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


//借贷
- (void)createTabBarController {


    TMControlManagerViewController *controlManageVC = [[TMControlManagerViewController alloc] init];
    UINavigationController *controlManagerVCNV = [[UINavigationController alloc] initWithRootViewController:controlManageVC];
    
    TMSideViewController *sideVC = [[TMSideViewController alloc] init];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:controlManagerVCNV leftDrawerViewController:sideVC];
    /** 设置打开/关闭抽屉的手势 */
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerController.closeDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerController.showsShadow = NO;
    /** 设置左边抽屉显示的多少 */
    drawerController.maximumLeftDrawerWidth = SCREEN_SIZE.width - 50;
    self.window.rootViewController = drawerController;
    [self.window makeKeyAndVisible];
}

//担保
- (void)createMyLoanTabBarController {
//    QDTabBarViewController *tabBarViewController = [[QDTabBarViewController alloc] init];
//
//    // 首页
//    QDBorrowHomeViewController *borrowVC = [[QDBorrowHomeViewController alloc] init];
//    QDNavigationController *homeViewNavController = [[QDNavigationController alloc] initWithRootViewController:borrowVC];
//    borrowVC.hidesBottomBarWhenPushed = NO;
//    borrowVC.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页" image:[UIImageMake(@"icon-home-nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon-home-light") tag:0];
//
//
//    // 找贷款
//    QDBorrowMessageViewController *messageVC = [[QDBorrowMessageViewController alloc] init];
////    messageVC.hidesBottomBarWhenPushed = NO;
//    QDNavigationController *loanNavController = [[QDNavigationController alloc] initWithRootViewController:messageVC];
//    loanNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"消息" image:[UIImageMake(@"icon-fuwu-nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon-fuwu-light") tag:1];
//
//    //个人中心
//    QDMyViewController *myViewController = [[QDMyViewController alloc] init];
//    myViewController.hidesBottomBarWhenPushed = NO;
//    QDNavigationController *myNavController = [[QDNavigationController alloc] initWithRootViewController:myViewController];
//    myNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我的" image:[UIImageMake(@"icon-wode-nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon-wode-light") tag:3];
//
//     tabBarViewController.viewControllers = @[homeViewNavController,loanNavController,myNavController];
    //    QDTabBarViewController *tabBarViewController = [[QDTabBarViewController alloc] init];
    //
    QDTabBarViewController *tabBarViewController = [[QDTabBarViewController alloc] init];
    // 首页
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    QDNavigationController *homeViewNavController = [[QDNavigationController alloc] initWithRootViewController:homeViewController];
    homeViewController.hidesBottomBarWhenPushed = NO;
    homeViewController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"首页" image:[UIImageMake(@"icon-home-nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon-home-light") tag:0];
    
    
    // 找贷款
    QDCompanyViewController *loanViewController = [[QDCompanyViewController alloc] init];
    loanViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *loanNavController = [[QDNavigationController alloc] initWithRootViewController:loanViewController];
    loanNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"找贷款" image:[UIImageMake(@"icon-fuwu-nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon-fuwu-light") tag:1];
    
    //个人中心
    QDMyViewController *myViewController = [[QDMyViewController alloc] init];
    myViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *myNavController = [[QDNavigationController alloc] initWithRootViewController:myViewController];
    myNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我的" image:[UIImageMake(@"icon-wode-nor") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon-wode-light") tag:3];
    
    tabBarViewController.viewControllers = @[homeViewNavController,loanNavController,myNavController];
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];
    

}

- (void)didChangeStatusFrameNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeStatusBarFrame:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)didChangeStatusBarFrame:(NSNotification *)noti {
    NSLog(@"%@",noti.userInfo[@"UIApplicationStatusBarFrameUserInfoKey"]);
    if ([UIApplication sharedApplication].statusBarFrame.size.height==40) {
        
    }
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
