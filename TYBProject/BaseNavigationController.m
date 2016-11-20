//
//  BaseNavigationController.m
//  YBHappyVolleyball
//
//  Created by 钱龙 on 16/9/5.
//  Copyright © 2016年 山东远邦. All rights reserved.
//

#import "BaseNavigationController.h"
#import "AppDelegate.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏的字体规格
    NSDictionary * attrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.navigationBar setTitleTextAttributes:attrDic];
    [self.navigationBar setBackgroundImage:ImageName(@"矩形-5-拷贝.png") forBarMetrics:UIBarMetricsDefault];//作用同上句
    //[self setStatusColor];
}
-(void)setStatusColor{
    UIView * statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
    statusBarView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:statusBarView];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        [self createBackBarItemWithViewController:viewController];
        [self createrightBarItemWithViewController:viewController];
    }
    [self setTabBarState];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    [self setTabBarState];
    return vc;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *vcs = [super popToViewController:viewController animated:animated];
    [self setTabBarState];
    return vcs;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    NSArray *vcs = [super popToRootViewControllerAnimated:animated];
    [self setTabBarState];
    return vcs;
}

- (void)createrightBarItemWithViewController:(UIViewController *)viewController{
    
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(MainScreenWidth - 42, 6, 32.f, 32.f);
    [backItem setImage:[UIImage imageNamed:@"share_button"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(JumpSharedView) forControlEvents:UIControlEventTouchUpInside];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIBarButtonItem *rBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    viewController.navigationItem.rightBarButtonItem = rBarButtonItem;
    
}

- (void)createBackBarItemWithViewController:(UIViewController *)viewController{
    //    self.navigationBar.tintColor = [UIColor blackColor];//系统返回的箭头颜色定制
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(0, 6, 32.f, 32.f);
    [backItem setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backToParentView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    viewController.navigationItem.leftBarButtonItem = lBarButtonItem;
    
}

- (void)backToParentView{
    
    if ([self presentationController] && self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self popViewControllerAnimated:YES];
    }
}
- (void)JumpSharedView{
    DLog(@"跳转分享页面");
}
- (void)setTabBarState{
    [[AppDelegate appDelegate].rootViewController setTabBarHidden:self.viewControllers.count > 1 animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
