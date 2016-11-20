//
//  BaseViewViewController.m
//  YBHappyVolleyball
//
//  Created by 钱龙 on 16/9/5.
//  Copyright © 2016年 山东远邦. All rights reserved.
//

#import "BaseViewViewController.h"

@interface BaseViewViewController ()

@end

@implementation BaseViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertControl addAction:cancel];
    [self presentViewController:alertControl animated:YES completion:nil];
}

@end
