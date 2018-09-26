//
//  StatisticViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "StatisticViewController.h"
#import "ReviewViewController.h"
#import "BillView.h"
#import "ReportView.h"

@interface StatisticViewController ()

@property (weak, nonatomic) IBOutlet BillView *billView;
@property (weak, nonatomic) IBOutlet ReportView *reportView;

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;

@end

@implementation StatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"历史统计";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回顾" style:UIBarButtonItemStyleDone target:self action:@selector(toReviewController)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.billView setYear:self.year withMonth:self.month];
    [self.reportView setYear:self.year withMonth:self.month];
}

- (void)toReviewController {
    [self.navigationController pushViewController:[ReviewViewController new] animated:YES];
}

- (IBAction)typeChanged:(UISegmentedControl *)sender {
    self.billView.hidden = sender.selectedSegmentIndex;
    self.reportView.hidden = !sender.selectedSegmentIndex;
}

- (NSInteger)year {
    if (_year == 0) {
        _year = [DateUtils currentYear];
    }
    return _year;
}

- (NSInteger)month {
    if (_month == 0) {
        _month = [DateUtils currentMonth];
    }
    return _month;
}

@end
