//
//  AssetsModifyRecordDao.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsModifyRecordDao.h"
#import "Dao.h"

@implementation AssetsModifyRecordDao

+ (NSMutableArray<AssetsModifyRecordModel *> *)getAssetsRecordsById:(NSNumber *)ID {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT * FROM AssetsModifyRecord WHERE state = ? AND assets_id = ? ORDER BY create_time" withArgumentsInArray:@[@(0), ID]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        AssetsModifyRecordModel *model = [AssetsModifyRecordModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.state = [result longForColumn:@"state"];
        model.create_time = [result objectForColumn:@"create_time"];
        model.assets_id = [result objectForColumn:@"assets_id"];
        model.money_before = [result objectForColumn:@"money_before"];
        model.money = [result objectForColumn:@"money"];
        [arr addObject:model];
    }
    return arr;
}

+ (BOOL)insertAssetsRecords:(NSMutableArray<AssetsModifyRecordModel *> *)modifyRecord {
    [[Dao sharedDao] beginTransaction];
    for (AssetsModifyRecordModel *model in modifyRecord) {
        [[Dao sharedDao] executeUpdate:@"INSERT INTO AssetsModifyRecord(state, create_time, assets_id, money_before, money) VALUES(?,?,?,?,?)" withArgumentsInArray:@[@(model.state), model.create_time, model.assets_id, model.money_before, model.money]];
    }
    return [[Dao sharedDao] commit];
}

@end
