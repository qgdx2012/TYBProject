//
//  BaseTabBarController.h
//  YBHappyVolleyball
//
//  Created by 钱龙 on 16/9/5.
//  Copyright © 2016年 山东远邦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

@property (nonatomic, getter=isTabBarHidden,readonly)BOOL tabBarHidden;

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
