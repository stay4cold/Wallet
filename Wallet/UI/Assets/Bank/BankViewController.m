//
//  BankViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "BankViewController.h"

@interface BankViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"text_choose_bank", nil);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"text_affirm", nil) style:UIBarButtonItemStyleDone target:self action:@selector(confirm)];
}

- (void)confirm {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bankViewSelect:)]) {
        [self.delegate bankViewSelect:[self.dataArray objectAtIndex:self.selectIndexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [BankCreator getAllBankItems];
    }
    return _dataArray;
}

- (NSIndexPath *)selectIndexPath {
    if (!_selectIndexPath) {
        _selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _selectIndexPath;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexPath = indexPath;
    [tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([indexPath isEqual:self.selectIndexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.bank = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

@end
