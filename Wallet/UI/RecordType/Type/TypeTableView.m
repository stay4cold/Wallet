//
//  TypeTableView.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "TypeTableView.h"
#import "TypeTableViewCell.h"
#import "RecordTypeDao.h"
#import "AddTypeViewController.h"
#import "RecordDao.h"

@interface TypeTableView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TypeTableView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TypeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        [self addSubview:_tableView];
        WS(ws);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(ws);
        }];
    }
    return _tableView;
}

- (void)setType:(RecordType)type {
    _type = type;
    [self loadData];
}

- (void)loadData {
    self.dataArray = [RecordTypeDao getRecordTypes:self.type];
    [self.tableView reloadData];
}

- (void)deleteRecordTypeAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count < 2) {
        [self showHUDInView:self justWithText:@"请至少保留一个类型" disMissAfterDelay:2];
        return;
    }
    RecordTypeModel *model = [RecordTypeModel recordTypeWithModel:[self.dataArray objectAtIndex:indexPath.row]];
    
    WS(ws);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"删除 %@?", model.name] message:@"删除该分类后，将无法在记账页选择该分类，该分类下原有账单仍保持不变" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([RecordDao getRecordCountWithTypeId:model.ID] > 0) {
            model.state = RecordStateDeleted;
            [RecordTypeDao updateRecordTypes:[NSMutableArray arrayWithObject:model]];
        } else {
            [RecordTypeDao deleteRecordType:model];
        }
        [ws loadData];
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Public methods

- (void)startOrder {
    [self.tableView setEditing:YES animated:YES];
}

- (void)endOrder {
    if (self.dataArray.count > 1) {
        NSMutableArray *sortArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.dataArray.count; i++) {
            RecordTypeModel *model = [self.dataArray objectAtIndex:i];
            if ([model.ranking integerValue] != i) {
                model.ranking = [NSNumber numberWithInteger:i];
                [sortArray addObject:model];
            }
        }
        [RecordTypeDao updateRecordTypes:sortArray];
    }
    [self.tableView setEditing:NO animated:YES];
    [self loadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(ws);
    UITableViewRowAction *del = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [ws deleteRecordTypeAtIndexPath:indexPath];
    }];
    return @[del];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddTypeViewController *avc = [AddTypeViewController new];
    avc.model = [self.dataArray objectAtIndex:indexPath.row];
    [(UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController) pushViewController:avc animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    RecordTypeModel *moveModel = [self.dataArray objectAtIndex:sourceIndexPath.row];
    [self.dataArray removeObjectAtIndex:sourceIndexPath.row];
    [self.dataArray insertObject:moveModel atIndex:destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
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
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

@end
