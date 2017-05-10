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
//#import <Fabric/Fabric.h>
//#import <Crashlytics/Crashlytics.h>
#import "QDCompanyViewController.h"

#define APP_ID @"QGSs41nGgfDofETOfRgAKdSj-gzGzoHsz"
#define APP_KEY @"fmavP4Ny83CAmboSlDCWpQl3"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#if DEBUG 
    
#else 
    
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

    return YES;
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
    HomeViewController *certViewController = [[HomeViewController alloc] init];
    certViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *certNavController = [[QDNavigationController alloc] initWithRootViewController:certViewController];
    certNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"信用卡" image:[UIImageMake(@"icon_tabbar_lab") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_lab_selected") tag:2];
    
    //我的
    HomeViewController *myViewController = [[HomeViewController alloc] init];
    myViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *myNavController = [[QDNavigationController alloc] initWithRootViewController:myViewController];
    myNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我的" image:[UIImageMake(@"icon_tabbar_component") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_component_selected") tag:4];
    
    // window root controller
    tabBarViewController.viewControllers = @[homeViewNavController, loanNavController, certNavController,myNavController];
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];
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

//- (void)initFabric {
//    //Fabric设置
//    [Fabric with:@[[Crashlytics class]]];
//}


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
