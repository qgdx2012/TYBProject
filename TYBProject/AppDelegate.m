//
//  AppDelegate.m
//  TYBProject
//
//  Created by 钱龙 on 16/11/18.
//  Copyright © 2016年 钱龙. All rights reserved.
//

#import "AppDelegate.h"

#import "QlNetworkHelper.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
+ (instancetype)appDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _rootViewController = [[BaseTabBarController alloc] init];
    self.window.rootViewController = _rootViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.curNetworkStatus = @"WiFi";//默认状态为wifi
    [self registerReachability];
    return YES;
}
- (void)registerReachability{
    //监测网络
    [[QlNetworkHelper sharedManager] networkReaching];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStatusChangedValues:) name:@"NetReachabilityStatusChanged" object:nil];
}

- (void)netStatusChangedValues:(NSNotification *)notify{
    NSDictionary *dic = notify.userInfo;
    NSString *networkStatus = [dic objectForKey:@"networkStatus"];
    self.curNetworkStatus = networkStatus;
    NSString * string = [NSString stringWithFormat:@"当前网络状态为%@",networkStatus];
    //    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络状态" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    //    [alert show];
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
