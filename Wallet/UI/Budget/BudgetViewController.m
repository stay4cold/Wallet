//
//  BudgetViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "BudgetViewController.h"

@interface BudgetViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation BudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择货币符号";
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirm)];
    self.tableView.tableFooterView = [UIView new];
    self.selectIndex = [[ConfigManager getSimpleSymbol] indexOfObject:[ConfigManager getCurrentSymbol]] ;
}

- (void)confirm {
    [ConfigManager setCurrentSymbol:[[ConfigManager getSimpleSymbol] objectAtIndex:self.selectIndex]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)dataArray {
    return [NSMutableArray arrayWithArray:[ConfigManager getSymbol]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == self.selectIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    [tableView reloadData];
}

@end
