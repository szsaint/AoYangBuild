//
//  AppDelegate.m
//  AoYangBuild
//
//  Created by wl on 15/10/19.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "OrderController.h"
#import "MeController.h"
#import "ConectController.h"
#import "AYNavigationController.h"
#import "LoginController.h"

#import <YTKNetwork/YTKNetworkConfig.h>
#import <BeeCloud.h>


#define userName  [[NSUserDefaults standardUserDefaults]objectForKey:@"username"]
#define ConfigUrl @"http://112.80.40.185/wp-json"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    YTKNetworkConfig *config =[YTKNetworkConfig sharedInstance];
    config.baseUrl =ConfigUrl;
    
    if (userName) {
        self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController=self.tabBarController;
        [self.window makeKeyAndVisible];

    }else{
        LoginController *loginVc =[[LoginController alloc]init];
        self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController=loginVc;
        [self.window makeKeyAndVisible];
    }
    //请替换成自己的BeeCloud账户中的AppID和AppSecret
    [BeeCloud initWithAppID:@"c92a2bb3-5f3b-4c21-9340-28eff0aca577" andAppSecret:@"d3aa3a10-50a8-4233-b813-4c9dce224541"];
    
    //如果需要微信支付，请添加下面这行（自行替换微信APP ID）
    [BeeCloud initWeChatPay:@"wx6ba16481575d6a82"];
    
//    //如果需要PayPal，请添加下面这行
//    [BeeCloud initPayPal:@"AVT1Ch18aTIlUJIeeCxvC7ZKQYHczGwiWm8jOwhrREc4a5FnbdwlqEB4evlHPXXUA67RAAZqZM0H8TCR" secret:@"EL-fkjkEUyxrwZAmrfn46awFXlX-h2nRkyCVhhpeVdlSRuhPJKXx3ZvUTTJqPQuAeomXA8PZ2MkX24vF" sanBox:YES];
    return YES;
}
-(UITabBarController *)tabBarController{
    if (!_tabBarController) {
        MainController *main =[[MainController alloc]init];
        AYNavigationController *mainNav =[[AYNavigationController alloc]initWithRootViewController:main];
        
//        OrderController *order =[[OrderController alloc]init];
//        AYNavigationController *orderNav =[[AYNavigationController alloc]initWithRootViewController:order];
        
        MeController *me =[[MeController alloc]init];
        AYNavigationController *meNav =[[AYNavigationController alloc]initWithRootViewController:me];
        
        ConectController *conect =[[ConectController alloc]init];
        AYNavigationController *conectNav =[[AYNavigationController alloc]initWithRootViewController:conect];
        
        UITabBarController *tabarVC =[[UITabBarController alloc]init];
        tabarVC.viewControllers= @[mainNav,meNav,conectNav];
        self.tabBarController=tabarVC;
        
        NSDictionary *tabBarTextTinColor = [NSDictionary dictionaryWithObjectsAndKeys:
                                            appColor,NSForegroundColorAttributeName,
                                            nil];
        
        [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
        [[UITabBar appearance] setTintColor:appColor];
        //[UITabBar appearance].translucent=NO;
        
        [[UITabBarItem appearance] setTitleTextAttributes:tabBarTextTinColor forState:UIControlStateSelected];
        
        
        
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _tabBarController=tabarVC;
//        self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        self.window.rootViewController=tabarVC;
//        [self.window makeKeyAndVisible];

    }
    return _tabBarController;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if (![BeeCloud handleOpenUrl:url]) {
        //handle其他类型的url
    }
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
