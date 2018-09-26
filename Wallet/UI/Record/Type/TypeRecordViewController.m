//
//  TypeRecordViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/26.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "TypeRecordViewController.h"
#import "TypeRecordView.h"

@interface TypeRecordViewController ()

@property (weak, nonatomic) IBOutlet TypeRecordView *timeView;
@property (weak, nonatomic) IBOutlet TypeRecordView *moneyView;

@end

@implementation TypeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.typeName;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.timeView configModel:self.model withYear:self.year withMonth:self.month withSortType:0];
    [self.moneyView configModel:self.model withYear:self.year withMonth:self.month withSortType:1];
}

- (IBAction)typeChanged:(UISegmentedControl *)sender {
    self.timeView.hidden = sender.selectedSegmentIndex;
    self.moneyView.hidden = !sender.selectedSegmentIndex;
}

@end
