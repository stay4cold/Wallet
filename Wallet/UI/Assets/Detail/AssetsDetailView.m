//
//  AssetsDetailView.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsDetailView.h"
#import "AssetsDetailViewCell.h"
#import "AssetsDao.h"

@interface AssetsDetailView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSNumber *assetsID;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AssetsDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.delegate = self;
    self.dataSource = self;
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    self.allowsSelection = NO;
    self.showsVerticalScrollIndicator = NO;
    self.tableFooterView = [UIView new];
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([AssetsDetailViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)setAssetsID:(NSNumber *)assetsID withType:(NSInteger)type {
    _assetsID = assetsID;
    _type = type;
    if (_type == 0) {//转账
        self.dataArray = [AssetsTransferRecordDao getTransferRecordsById:_assetsID];
        if (self.dataArray.count == 0) {
            self.customViewForVTEmpty = [self emptyLabel:@"没有转账记录"];
        }
    } else {//修改
        self.dataArray = [AssetsModifyRecordDao getAssetsRecordsById:_assetsID];
        if (self.dataArray.count == 0) {
            self.customViewForVTEmpty = [self emptyLabel:@"没有修改记录"];
        }
    }
    [self reloadData];
}

- (UILabel *)emptyLabel:(NSString *)text {
    UILabel *emptyLabel = [UILabel new];
    emptyLabel.numberOfLines = 0;
    emptyLabel.text = text;
    emptyLabel.textColor = [UIColor grayColor];
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.font = [UIFont systemFontOfSize:16];
    return emptyLabel;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AssetsDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.type == 0) {
        cell.transferModel = [self.dataArray objectAtIndex:indexPath.row];
    } else {
        cell.modifyModel = [self.dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

@end
