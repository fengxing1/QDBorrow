//
//  AppDelegate.h
//  QDBorrow
//
//  Created by 朱恪帅 on 2017/5/6.
//  Copyright © 2017年 zks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)createTabBarController;

- (void)createMyLoanTabBarController;

-(void)setupIntroductoryPage;
-(void)setupAdveriseView;
@end

