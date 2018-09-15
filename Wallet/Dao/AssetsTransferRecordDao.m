//
//  AssetsTransferRecordDao.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsTransferRecordDao.h"
#import "Dao.h"

@implementation AssetsTransferRecordDao

- (NSMutableArray<AssetsTransferRecordWithAssetsModel *> *)getTransferRecordsById:(NSNumber *)ID {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT transfer_record.*, assets_from.name AS assetsNameFrom, assets_to.name AS assetsNameTo FROM Assets AS assets_from, Assets AS assets_to, AssetsTransferRecord AS transfer_record WHERE assets_from.ID = transfer_record.assets_id_from AND assets_to.ID = transfer_record.assets_id_to AND (transfer_record.assets_id_form= ? OR transfer_record.assets_id_to= ?) ORDER BY transfer_record.time DESC, transfer_record.create_time DESC" withArgumentsInArray:@[ID, ID]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        AssetsTransferRecordWithAssetsModel *model = [AssetsTransferRecordWithAssetsModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.state = [result longForColumn:@"state"];
        model.create_time = [result objectForColumn:@"create_time"];
        model.time = [result objectForColumn:@"time"];
        model.assets_id_from = [result objectForColumn:@"assets_id_from"];
        model.assets_id_to = [result objectForColumn:@"assets_id_to"];
        model.remark = [result stringForColumn:@"remark"];
        model.money = [result objectForColumn:@"money"];
        model.assetsNameFrom = [result stringForColumn:@"assetsNameFrom"];
        model.assetsNameTo = [result stringForColumn:@"assetsNameTo"];
        [arr addObject:model];
    }
    return arr;
}

- (BOOL)insertTransferRecord:(NSMutableArray<AssetsTransferRecordModel *> *)assetsTransferRecord {
    [[Dao sharedDao] beginTransaction];
    for (AssetsTransferRecordModel *model in assetsTransferRecord) {
        [[Dao sharedDao] executeUpdate:@"INSERT INTO AssetsTransferRecord(state, create_time, time, assets_id_from, assets_id_to, remark, money) VALUES(?,?,?,?,?,?,?)" withArgumentsInArray:@[@(model.state), model.create_time, model.time, model.assets_id_from, model.assets_id_to, model.remark, model.money]];
    }
    return [[Dao sharedDao] commit];
}

@end
