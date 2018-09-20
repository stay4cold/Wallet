//
//  AddAssetsViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AllAssetsViewController.h"
#import "AssetsListView.h"

@interface AllAssetsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeControl;
@property (weak, nonatomic) IBOutlet AssetsListView *investView;
@property (weak, nonatomic) IBOutlet AssetsListView *normalView;

@end

@implementation AllAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加资产";
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadData];
}

- (IBAction)typeChanged:(UISegmentedControl *)sender {
    self.normalView.hidden = sender.selectedSegmentIndex == 1;
    self.investView.hidden = sender.selectedSegmentIndex == 0;
}

- (void)loadData {
    self.normalView.type = AssetsTypeNormal;
    self.normalView.nc = self.navigationController;
    self.investView.type = AssetsTypeInvest;
    self.investView.nc = self.navigationController;
}

@end
