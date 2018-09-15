//
//  AddRecordViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AddRecordViewController.h"

@interface AddRecordViewController ()

@end

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isSuccessive) {
        self.title = @"记一笔(连续)";
    } else {
        self.title = @"记一笔";
    }
    
//    self.title = @"新建";
}

@end
