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

+ (NSMutableArray<AssetsModel *> *)getAllAssets {
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
        model.create_time = [result dateForColumn:@"create_time"];
        model.money = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money"]];
        model.money_init = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money_init"]];
        [arr addObject:model];
    }
    return arr;
}

+ (AssetsModel *)getAssetsById:(NSNumber *)ID {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT * FROM Assets WHERE state = ? AND ID = ?" withArgumentsInArray:@[@(0), ID]];
    if ([result next]) {
        AssetsModel *model = [AssetsModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.name = [result stringForColumn:@"name"];
        model.img_name = [result stringForColumn:@"img_name"];
        model.type = [result longForColumn:@"type"];
        model.state = [result longForColumn:@"state"];
        model.remark = [result stringForColumn:@"remark"];
        model.create_time = [result dateForColumn:@"create_time"];
        model.money = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money"]];
        model.money_init = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money_init"]];
        return model;
    }
    return nil;
}

+ (BOOL)insertAssets:(NSMutableArray<AssetsModel *> *)assets {
    [[Dao sharedDao] beginTransaction];
    for (AssetsModel *model in assets) {
        [[Dao sharedDao] executeUpdate:@"INSERT INTO Assets(name, img_name, type, state, remark, create_time, money, money_init) VALUES(?,?,?,?,?,?,?,?)" withArgumentsInArray:@[model.name, model.img_name, @(model.type), @(model.state), model.remark, model.create_time, model.money, model.money_init]];
    }
    return [[Dao sharedDao] commit];
}

+ (BOOL)updateAssets:(NSMutableArray<AssetsModel *> *)assets {
    [[Dao sharedDao] beginTransaction];
    for (AssetsModel *model in assets) {
        [[Dao sharedDao] executeUpdate:@"UPDATE Assets SET name = ?, img_name = ?, type = ?, state = ?, remark = ?, create_time = ?, money = ?, money_init = ? WHERE ID = ?" withArgumentsInArray:@[model.name, model.img_name, @(model.type), @(model.state), model.remark, model.create_time, model.money, model.money_init, model.ID]];
    }
    return [[Dao sharedDao] commit];
}

+ (BOOL)deleteAssets:(AssetsModel *)assets {
    return [[Dao sharedDao] executeUpdate:@"DELETE FROM Assets WHERE ID = ?" withArgumentsInArray:@[assets.ID]];
}

+ (AssetsMoneyModel *)getAssetsMoney {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT SUM(Assets.money) AS netAssets, SUM(CASE WHEN Assets.money > 0 THEN Assets.money ELSE 0 END) AS allAssets, SUM(CASE WHEN Assets.money < 0 THEN Assets.money ELSE 0 END) AS liabilityAssets FROM Assets WHERE Assets.state = 0"];
    if ([result next]) {
        AssetsMoneyModel *model = [AssetsMoneyModel new];
        model.netAssets = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"netAssets"]];
        model.allAssets = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"allAssets"]];
        model.liabilityAssets = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"liabilityAssets"]];
        return model;
    }
    return nil;
}

+ (NSMutableArray<AssetsTypeModel *> *)getAllAssetsByType:(AssetsType)type {
    NSMutableArray *arr = [NSMutableArray array];
    if (type == AssetsTypeNormal) {
        [arr addObject:[AssetsTypeModel assetsWithName:@"现金" imgName:@"assets_wallet" type:1]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"银行卡" imgName:@"assets_card" type:2]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"支付宝" imgName:@"assets_alipay" type:3]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"微信钱包" imgName:@"assets_wechat" type:4]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"京东钱包" imgName:@"assets_jd" type:5]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"饭卡" imgName:@"assets_rice_card" type:6]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"公交卡" imgName:@"assets_bus_card" type:7]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"其他账户" imgName:@"assets_other" type:8]];
    } else {
        [arr addObject:[AssetsTypeModel assetsWithName:@"货币基金" imgName:@"assets_monetary" type:9]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"基金" imgName:@"assets_funding" type:10]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"股票" imgName:@"assets_stock" type:11]];
        [arr addObject:[AssetsTypeModel assetsWithName:@"其他账户" imgName:@"assets_other" type:12]];
    }
    return arr;
}

@end
