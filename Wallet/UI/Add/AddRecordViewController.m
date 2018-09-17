//
//  AddRecordViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AddRecordViewController.h"
#import "AddTypePageView.h"
#import "RecordTypeDao.h"

@interface AddRecordViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeControl;
@property (weak, nonatomic) IBOutlet AddTypePageView *outlayTypePageView;
@property (weak, nonatomic) IBOutlet AddTypePageView *incomeTypePageView;

@end

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isSuccessive) {
        self.title = @"记一笔(连续)";
    } else {
        self.title = @"记一笔";
    }
    
    self.outlayTypePageView.dataArray = [RecordTypeDao getAllRecordTypes];
}

- (IBAction)typeChanged:(UISegmentedControl *)sender {
    self.outlayTypePageView.hidden = sender.selectedSegmentIndex == 1;
    self.incomeTypePageView.hidden = sender.selectedSegmentIndex == 0;
}

@end
