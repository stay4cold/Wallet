//
//  StatisticViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "StatisticViewController.h"
#import "ReviewViewController.h"

@interface StatisticViewController ()

@end

@implementation StatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"历史统计";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回顾" style:UIBarButtonItemStyleDone target:self action:@selector(toReviewController)];
}

- (void)toReviewController {
    [self.navigationController pushViewController:[ReviewViewController new] animated:YES];
}


@end
