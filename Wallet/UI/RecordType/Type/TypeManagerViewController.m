//
//  TypeManagerViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/17.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "TypeManagerViewController.h"
#import "TypeTableView.h"
#import "AddTypeViewController.h"

@interface TypeManagerViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeControl;
@property (weak, nonatomic) IBOutlet TypeTableView *incomeView;
@property (weak, nonatomic) IBOutlet TypeTableView *outlayView;
@property (weak, nonatomic) IBOutlet UIButton *addTypeBtn;

@property (nonatomic, strong) UIBarButtonItem *orderItem;
@property (nonatomic, strong) UIBarButtonItem *saveItem;

@end

@implementation TypeManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"text_type_manage", nil);
    self.navigationItem.rightBarButtonItem = self.orderItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.outlayView.type = RecordTypeOutlay;
    self.incomeView.type = RecordTypeIncome;
}

- (IBAction)typeChanged:(UISegmentedControl *)sender {
    self.outlayView.hidden = sender.selectedSegmentIndex == 1;
    self.incomeView.hidden = sender.selectedSegmentIndex == 0;
}

- (IBAction)addType:(id)sender {
    AddTypeViewController *avc = [AddTypeViewController new];
    avc.type = self.typeControl.selectedSegmentIndex;
    [self.navigationController pushViewController:avc animated:YES];
}

- (UIBarButtonItem *)orderItem {
    if (!_orderItem) {
        _orderItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"text_sort", nil) style:UIBarButtonItemStyleDone target:self action:@selector(order)];
    }
    return _orderItem;
}

- (UIBarButtonItem *)saveItem {
    if (!_saveItem) {
        _saveItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"text_save", nil) style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    }
    return _saveItem;
}

- (void)order {
    [self.outlayView startOrder];
    [self.incomeView startOrder];
    self.addTypeBtn.hidden = YES;
    self.navigationItem.rightBarButtonItem = self.saveItem;
}

- (void)save {
    [self.outlayView endOrder];
    [self.incomeView endOrder];
    self.addTypeBtn.hidden = NO;
    self.navigationItem.rightBarButtonItem = self.orderItem;
}

@end
