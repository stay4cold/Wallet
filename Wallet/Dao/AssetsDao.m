//
//  AssetsDao.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsDao.h"
#import "Dao.h"

@implementation AssetsDao

- (NSMutableArray<AssetsModel *> *)getAllAssets {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT * FROM Assets WHERE state = ?" withArgumentsInArray:@[@(0)]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        AssetsModel *model = [AssetsModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.name = [result stringForColumn:@"name"];
        model.img_name = [result stringForColumn:@"img_name"];
        model.type = [result longForColumn:@"type"];
        model.state = [result longForColumn:@"state"];
        model.remark = [result stringForColumn:@"remark"];
        model.create_time = [result objectForColumn:@"create_time"];
        model.money = [result objectForColumn:@"money"];
        model.money_init = [result objectForColumn:@"money_init"];
        [arr addObject:model];
    }
    return arr;
}

- (AssetsModel *)getAssetsById:(NSNumber *)ID {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT * FROM Assets WHERE state = ? AND ID = ?" withArgumentsInArray:@[@(0), ID]];
    if ([result next]) {
        AssetsModel *model = [AssetsModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.name = [result stringForColumn:@"name"];
        model.img_name = [result stringForColumn:@"img_name"];
        model.type = [result longForColumn:@"type"];
        model.state = [result longForColumn:@"state"];
        model.remark = [result stringForColumn:@"remark"];
        model.create_time = [result objectForColumn:@"create_time"];
        model.money = [result objectForColumn:@"money"];
        model.money_init = [result objectForColumn:@"money_init"];
        return model;
    }
    return nil;
}

- (BOOL)insertAssets:(NSMutableArray<AssetsModel *> *)assets {
    [[Dao sharedDao] beginTransaction];
    for (AssetsModel *model in assets) {
        [[Dao sharedDao] executeUpdate:@"INSERT INTO Assets(name, img_name, type, state, remark, create_time, money, money_init) VALUES(?,?,?,?,?,?,?,?)" withArgumentsInArray:@[model.name, model.img_name, @(model.type), @(model.state), model.remark, model.create_time, model.money, model.money_init]];
    }
    return [[Dao sharedDao] commit];
}

- (BOOL)updateAssets:(NSMutableArray<AssetsModel *> *)assets {
    [[Dao sharedDao] beginTransaction];
    for (AssetsModel *model in assets) {
        [[Dao sharedDao] executeUpdate:@"UPDATE Assets SET name = ?, img_name = ?, type = ?, state = ?, remark = ?, create_time = ?, money = ?, money_init = ? WHERE ID = ?" withArgumentsInArray:@[model.name, model.img_name, @(model.type), @(model.state), model.remark, model.create_time, model.money, model.money_init, model.ID]];
    }
    return [[Dao sharedDao] commit];
}

- (BOOL)deleteAssets:(AssetsModel *)assets {
    return [[Dao sharedDao] executeUpdate:@"DELETE FROM Assets WHERE ID = ?" withArgumentsInArray:@[assets.ID]];
}

- (AssetsMoneyModel *)getAssetsMoney {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT SUM(Assets.money) AS netAssets, SUM(CASE WHEN Assets.money > 0 THEN Assets.money ELSE 0 END) AS allAssets, SUM(CASE WHEN Assets.money < 0 THEN Assets.money ELSE 0 END) AS liabilityAssets FROM Assets WHERE Assets.state = 0"];
    if ([result next]) {
        AssetsMoneyModel *model = [AssetsMoneyModel new];
        model.netAssets = [result objectForColumn:@"netAssets"];
        model.allAssets = [result objectForColumn:@"allAssets"];
        model.liabilityAssets = [result objectForColumn:@"liabilityAssets"];
        return model;
    }
    return nil;
}

@end
