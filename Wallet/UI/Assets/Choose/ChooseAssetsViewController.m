//
//  ChooseAssetsViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "ChooseAssetsViewController.h"

@interface ChooseAssetsViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) AssetsModel *selectedModel;
@property (nonatomic, strong) AssetsModel *noAssets;
@property (nonatomic, strong) AssetsModel *addAssets;

@end

@implementation ChooseAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择账户";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirm)];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChooseAssetsViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)confirm {
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseAssets:)]) {
        [self.delegate chooseAssets:self.selectedModel];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loadData {
    self.dataArray = [AssetsDao getAllAssets];
    if (!self.noAndAddHidden) {
        [self.dataArray addObjectsFromArray:@[self.noAssets, self.addAssets]];
    }
    [self.tableView reloadData];
}

- (AssetsModel *)selectedModel {
    if (!_selectedModel) {
        for (AssetsModel *assets in self.dataArray) {
            if ([assets.ID integerValue] == [self.checkedID integerValue]) {
                _selectedModel = assets;
                break;
            }
        }
        if (!_selectedModel) {
            _selectedModel = [self.dataArray objectAtIndex:0];
        }
    }
    return _selectedModel;
}

- (AssetsModel *)noAssets {
    if (!_noAssets) {
        _noAssets = [AssetsModel new];
        _noAssets.ID = [NSNumber numberWithInt:AssetsTypeNo];
        _noAssets.name = @"不选择账户";
        _noAssets.remark = @"仅计入收支账单";
        _noAssets.img_name = @"ic_no_account";
    }
    return _noAssets;
}

- (AssetsModel *)addAssets {
    if (!_addAssets) {
        _addAssets = [AssetsModel new];
        _addAssets.ID = [NSNumber numberWithInt:AssetsTypeAdd];
        _addAssets.name = @"新建账户";
        _addAssets.img_name = @"ic_add_account";
    }
    return _addAssets;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AssetsModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model isEqual:self.addAssets]) {
        [self.navigationController pushViewController:[AllAssetsViewController new] animated:YES];
    } else {
        self.selectedModel = [self.dataArray objectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChooseAssetsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AssetsModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([self.selectedModel.ID isEqual:model.ID]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.model = model;
    return cell;
}

@end
