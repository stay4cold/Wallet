//
//  HomeViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "HomeViewController.h"
#import "SettingViewController.h"
#import "StatisticViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStyleDone target:self action:@selector(toSettingController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"statistics"] style:UIBarButtonItemStyleDone target:self action:@selector(toStatisticController)];
}

- (void)toSettingController {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    [self.navigationController pushViewController:[SettingViewController new] animated:YES];
}

- (void)toStatisticController {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    [self.navigationController pushViewController:[StatisticViewController new] animated:YES];
}

@end
