//
//  ChooseAssetsView.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsListView.h"
#import "TypeTableViewCell.h"
#import "AssetsDao.h"
#import "AddAssetsViewController.h"

@interface AssetsListView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AssetsListView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return _tableView;
}

- (void)setType:(AssetsType)type {
    _type = type;
    self.dataArray = [AssetsDao getAllAssetsByType:_type];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddAssetsViewController *avc = [AddAssetsViewController new];
    avc.assetsTypeModel = [self.dataArray objectAtIndex:indexPath.row];
    [self.nc pushViewController:avc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.assets = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

@end
