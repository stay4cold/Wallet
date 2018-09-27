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
#import "AssetsViewController.h"

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
    
    self.title = NSLocalizedString(@"text_setting", nil);
    
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
            [self.navigationController pushViewController:[AssetsViewController new] animated:YES];
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
        [_dataArray addObject:[NormalItem normalTitle:NSLocalizedString(@"text_monty_budget", nil) content:[self getBudget]]];
        [_dataArray addObject:[NormalItem normalTitle:NSLocalizedString(@"text_assets_manager", nil) content:NSLocalizedString(@"text_assets_manager_content", nil)]];
        [_dataArray addObject:[NormalItem normalTitle:NSLocalizedString(@"text_title_symbol", nil) content:NSLocalizedString(@"text_content_symbol", nil)]];
        [_dataArray addObject:[NormalItem normalTitle:NSLocalizedString(@"text_setting_type_manage", nil) content:NSLocalizedString(@"text_setting_type_manage_content", nil)]];
        [_dataArray addObject:[CheckItem itemTitle:NSLocalizedString(@"text_fast_accounting", nil) content:NSLocalizedString(@"text_fast_tip", nil) check:[ConfigManager isFast]]];
        [_dataArray addObject:[NormalItem normalTitle:NSLocalizedString(@"text_successive_record", nil) content:NSLocalizedString(@"text_successive_record_tip", nil)]];
    }
    return _dataArray;
}

- (NSString *)getBudget {
    if ([ConfigManager getBudget] == 0) {
        return NSLocalizedString(@"text_no_setting", nil);
    } else {
        return [NSString stringWithFormat:@"%@%@", [ConfigManager getCurrentSymbol], [DecimalUtils formatNum:[NSString stringWithFormat:@"%ld", ConfigManager.getBudget]]];
    }
}

- (void)showBudget {
    WS(ws);
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"text_set_budget", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        NSInteger budget = [ConfigManager getBudget];
        if (budget != 0) {
            textField.text = [NSString stringWithFormat:@"%ld", [ConfigManager getBudget]];
        }
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"text_affirm", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ConfigManager setBudget:[ac.textFields[0].text integerValue]];
        ws.dataArray = nil;
        [ws.tableView reloadData];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"text_cancel", nil) style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
