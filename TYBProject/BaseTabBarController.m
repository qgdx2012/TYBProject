//
//  BaseTabBarController.m
//  YBHappyVolleyball
//
//  Created by 钱龙 on 16/9/5.
//  Copyright © 2016年 山东远邦. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "CatogaryViewController.h"
#import "ShopCarViewController.h"
#import "MineViewController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addChildViewControllers) name:@"tabBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifitinAction:) name:@"changeTabBar" object:nil];
    [self addChildViewControllers];
}
- (void)notifitinAction:(NSNotification *)noti{
    NSNumber *index = [noti.userInfo objectForKey:@"index"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectedIndex = index.intValue;
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addChildViewControllers{
    [self addChildViewController:[[HomeViewController alloc]init] TitleName:@"" tabBarTitleName:@"首页" tabBarImageName:@"tabar1.png" tabBarSelImageName:@"seltabar1.png"];
    [self addChildViewController:[[CatogaryViewController alloc]init] TitleName:@"" tabBarTitleName:@"分类" tabBarImageName:@"tabar2.png" tabBarSelImageName:@"seltabar2.png"];
     [self addChildViewController:[[ShopCarViewController alloc]init] TitleName:@"购物车" tabBarTitleName:@"购物车" tabBarImageName:@"tabar3.png" tabBarSelImageName:@"seltabar3.png"];
     [self addChildViewController:[[MineViewController alloc]init] TitleName:@"" tabBarTitleName:@"我的" tabBarImageName:@"tabar4.png" tabBarSelImageName:@"seltabar4.png"];
}
-(void)addChildViewController:(UIViewController *)VC
                    TitleName:(NSString *)titleName
              tabBarTitleName:(NSString *)tabBarTitleName
              tabBarImageName:(NSString *)tabBarImageName tabBarSelImageName:(NSString *)tabBarSelImageName
{
    VC.title = titleName;
    // 修改标题位置
    self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    
    UIImage *img = [UIImage imageNamed:tabBarImageName];
    UIImage *selimg = [UIImage imageNamed:[NSString stringWithFormat:@"%@",tabBarSelImageName]];
    VC.tabBarItem.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [selimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置选中和未选中字体颜色
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
    
    //修改字体属性
    //    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
    //                                      [UIFont fontWithName:@"Helvetica" size:17.0], NSFontAttributeName, nil]
    //                            forState:UIControlStateNormal];
    
    BaseNavigationController *Nav = [[BaseNavigationController alloc] initWithRootViewController:VC];
    Nav.tabBarItem.title = tabBarTitleName;
    [self addChildViewController:Nav];
    
}

- (BOOL)isTabBarHidden{
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    return tabBarFrame.origin.y >= viewFrame.size.height;
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    BOOL isHidden = self.tabBarHidden;
    if (hidden == isHidden) {
        return;
    }
    
    UIView *transitionView = [[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject];
    if(transitionView == nil) {
        DLog(@"could not get the container view!");
        return;
    }
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    CGRect containerFrame = transitionView.frame;
    tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    containerFrame.size.height = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.35];
    }
    self.tabBar.frame = tabBarFrame;
    transitionView.frame = containerFrame;
    if (animated) {
        [UIView commitAnimations];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"taBar" object:nil];
}
@end
