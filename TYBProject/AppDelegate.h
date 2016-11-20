//
//  AppDelegate.h
//  TYBProject
//
//  Created by 钱龙 on 16/11/18.
//  Copyright © 2016年 钱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) NSString *curNetworkStatus;//当前网络状态
@property (nonatomic, strong) BaseTabBarController *rootViewController;
+ (instancetype)appDelegate;
@end

