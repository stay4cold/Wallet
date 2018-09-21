//
//  SettingViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingNormalViewCell.h"
#import "TypeManagerViewController.h"
#import "BudgetViewController.h"
#import "AssetsManagerViewController.h"

@implementation NormalItem

+ (NormalItem *)normalTitle:(NSString *)title content:(NSString *)content {
    NormalItem *item = [[NormalItem alloc] init];
    item.title = title;
    item.content = content;
    return item;
}

@end

@implementation CheckItem

+ (CheckItem *)itemTitle:(NSString *)title content:(NSString *)content check:(BOOL)checked {
    CheckItem *item = [CheckItem new];
    item.title = title;
    item.content = content;
    item.checked = checked;
    return item;
}

@end

@interface SettingViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SettingNormalViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataArray = nil;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingNormalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([[self.dataArray objectAtIndex:indexPath.row] isKindOfClass:[NormalItem class]]) {
        cell.normalItem = [self.dataArray objectAtIndex:indexPath.row];
    } else {
        cell.checkItem = [self.dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self showBudget];
            break;
        case 1:
            [self.navigationController pushViewController:[AssetsManagerViewController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[BudgetViewController new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[TypeManagerViewController new] animated:YES];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:[NormalItem normalTitle:@"月预算" content:[self getBudget]]];
        [_dataArray addObject:[NormalItem normalTitle:@"资产管理" content:@"新建和修改资产账户"]];
        [_dataArray addObject:[NormalItem normalTitle:@"货币符号" content:@"只改变货号，不转换汇率"]];
        [_dataArray addObject:[NormalItem normalTitle:@"收支类型管理" content:@"添加、修改和排序"]];
        [_dataArray addObject:[CheckItem itemTitle:@"快速记账" content:@"打开APP直接记账" check:[ConfigManager isFast]]];
        [_dataArray addObject:[NormalItem normalTitle:@"连续记账" content:@"长按首页添加按钮，连续记账"]];
    }
    return _dataArray;
}

- (NSString *)getBudget {
    if ([ConfigManager getBudget] == 0) {
        return @"未设置";
    } else {
        return [NSString stringWithFormat:@"%@%@", [ConfigManager getCurrentSymbol], [DecimalUtils formatNum:[NSString stringWithFormat:@"%ld", ConfigManager.getBudget]]];
    }
}

- (void)showBudget {
    WS(ws);
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"设置预算" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = [NSString stringWithFormat:@"%ld", [ConfigManager getBudget]];
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ConfigManager setBudget:[ac.textFields[0].text integerValue]];
        ws.dataArray = nil;
        [ws.tableView reloadData];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
