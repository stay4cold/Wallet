//
//  TypeRecordView.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/26.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "TypeRecordView.h"

@interface TypeRecordView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TypeSumMoneyModel *model;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger sortType;

@end

@implementation TypeRecordView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return _tableView;
}

- (void)configModel:(TypeSumMoneyModel *)model withYear:(NSInteger)year withMonth:(NSInteger)month withSortType:(NSInteger)sortType {
    self.model = model;
    self.year = year;
    self.month = month;
    self.sortType = sortType;
    [self update];
}

- (void)update {
    if (self.sortType == 0) {
        self.dataArray = [RecordDao getRangeRecordWithTypesFrom:[DateUtils monthStartForYear:self.year month:self.month] to:[DateUtils monthEndForYear:self.year month:self.month] type:_model.type typeId:_model.typeId];
        NSMutableArray *arr = [RecordDao getRangeRecordWithTypesFrom:[DateUtils monthStartForYear:self.year month:self.month] to:[DateUtils monthEndForYear:self.year month:self.month] type:_model.type typeId:_model.typeId];
        self.dataArray = [NSMutableArray array];
        TimeRecordModel *lastTimeRecord;
        for (RecordWithTypeModel *model in arr) {
            if (!lastTimeRecord || ![DateUtils sameDayWith:lastTimeRecord.date and:model.time]) {
                lastTimeRecord = [TimeRecordModel new];
                lastTimeRecord.date = model.time;
                [lastTimeRecord.records addObject:model];
                [self.dataArray addObject:lastTimeRecord];
            } else {
                [lastTimeRecord.records addObject:model];
            }
        }
    } else {
        self.dataArray = [RecordDao getRecordWithTypesSortMoneyFrom:[DateUtils monthStartForYear:self.year month:self.month] to:[DateUtils monthEndForYear:self.year month:self.month] type:_model.type typeId:_model.typeId];
    }
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor colorWithHexString:@"737373"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.sortType == 0) {
        return [[self.dataArray objectAtIndex:section] title];
    } else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.sortType == 0) {
        return self.dataArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sortType == 0) {
        return [[self.dataArray objectAtIndex:section] records].count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.sortType == 0) {
        cell.model = [[[self.dataArray objectAtIndex:indexPath.section] records] objectAtIndex:indexPath.row];
    } else {
        cell.model = [self.dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddRecordViewController *avc = [AddRecordViewController new];
    avc.recordWithType = [self currentSelectModel:indexPath];
    [(UINavigationController *)[self currentController] pushViewController:avc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(ws);
    RecordWithTypeModel *record = [self currentSelectModel:indexPath];
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:NSLocalizedString(@"text_delete", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@(%@%@)", record.recordTypes[0].name,[ConfigManager getCurrentSymbol], [DecimalUtils fen2Yuan:record.money]] message:NSLocalizedString(@"text_delete_record_note", nil) preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"text_affirm", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [RecordDao deleteRecord:record];
            [ws update];
        }]];
        [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"text_cancel", nil) style:UIAlertActionStyleCancel handler:nil]];
        [[ws currentController] presentViewController:ac animated:YES completion:nil];
    }];
    return @[delete];
}

- (UIViewController *)currentController {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (RecordWithTypeModel *)currentSelectModel:(NSIndexPath *)indexPath {
    if (self.sortType == 0) {
        return [[[self.dataArray objectAtIndex:indexPath.section] records] objectAtIndex:indexPath.row];
    } else {
        return [self.dataArray objectAtIndex:indexPath.row];
    }
}
@end

