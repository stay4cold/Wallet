//
//  RecordDao.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "RecordDao.h"
#import "Dao.h"

@implementation RecordDao

+ (NSMutableArray<RecordWithTypeModel *> *)getRangeRecordWithTypesFrom:(NSDate *)from to:(NSDate *)to {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT Record.*, RecordType.ID as r_ID, RecordType.name as r_name, RecordType.img_name as r_img_name, RecordType.type as r_type, RecordType.state as r_state, RecordType.ranking as r_ranking from Record LEFT JOIN RecordType ON Record.record_type_id=r_ID WHERE time BETWEEN ? AND ? ORDER BY time DESC, create_time DESC" withArgumentsInArray:@[from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        RecordWithTypeModel *model = [RecordWithTypeModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.money = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money"]];
        model.remark = [result stringForColumn:@"remark"];
        model.time = [result dateForColumn:@"time"];
        model.create_time = [result dateForColumn:@"create_time"];
        model.record_type_id = [result objectForColumn:@"record_type_id"];
        model.assets_id = [result objectForColumn:@"assets_id"];
        RecordTypeModel *typeModel = [RecordTypeModel new];
        typeModel.ID = [result objectForColumn:@"r_ID"];
        typeModel.name = [result stringForColumn:@"r_name"];
        typeModel.img_name = [result stringForColumn:@"r_img_name"];
        typeModel.type = [result longForColumn:@"r_type"];
        typeModel.state = [result longForColumn:@"r_state"];
        typeModel.ranking = [result objectForColumn:@"r_ranking"];
        model.recordTypes = [NSMutableArray arrayWithObject:typeModel];
        [arr addObject:model];
    }
    return arr;
                           
}
+ (NSMutableArray<RecordWithTypeModel *> *)getRangeRecordWithTypesFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT Record.*, RecordType.ID as r_ID, RecordType.name as r_name, RecordType.img_name as r_img_name, RecordType.type as r_type, RecordType.state as r_state, RecordType.ranking as r_ranking from Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.r_ID WHERE (RecordType.r_type=? AND time BETWEEN ? AND ?) ORDER BY time DESC, create_time DESC" withArgumentsInArray:@[@(type), from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        RecordWithTypeModel *model = [RecordWithTypeModel new];
        model.ID = [result objectForColumn:@"ID"];
model.money = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money"]];        model.remark = [result stringForColumn:@"remark"];
        model.time = [result dateForColumn:@"time"];
        model.create_time = [result dateForColumn:@"create_time"];
        model.record_type_id = [result objectForColumn:@"record_type_id"];
        model.assets_id = [result objectForColumn:@"assets_id"];
        RecordTypeModel *typeModel = [RecordTypeModel new];
        typeModel.ID = [result objectForColumn:@"r_ID"];
        typeModel.name = [result stringForColumn:@"r_name"];
        typeModel.img_name = [result stringForColumn:@"r_img_name"];
        typeModel.type = [result longForColumn:@"r_type"];
        typeModel.state = [result longForColumn:@"r_state"];
        typeModel.ranking = [result objectForColumn:@"r_ranking"];
        model.recordTypes = [NSMutableArray arrayWithObject:typeModel];
        [arr addObject:model];
    }
    return arr;
}
+ (NSMutableArray<RecordWithTypeModel *> *)getRangeRecordWithTypesFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type typeId:(NSNumber *)typeId {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT Record.*, RecordType.ID as r_ID, RecordType.name as r_name, RecordType.img_name as r_img_name, RecordType.type as r_type, RecordType.state as r_state, RecordType.ranking as r_ranking from Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.r_ID from Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.r_ID WHERE (RecordType.r_type=? AND Record.record_type_id=? AND time BETWEEN ? AND ?) ORDER BY time DESC, create_time DESC" withArgumentsInArray:@[@(type),typeId, from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        RecordWithTypeModel *model = [RecordWithTypeModel new];
        model.ID = [result objectForColumn:@"ID"];
model.money = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money"]];        model.remark = [result stringForColumn:@"remark"];
        model.time = [result dateForColumn:@"time"];
        model.create_time = [result dateForColumn:@"create_time"];
        model.record_type_id = [result objectForColumn:@"record_type_id"];
        model.assets_id = [result objectForColumn:@"assets_id"];
        RecordTypeModel *typeModel = [RecordTypeModel new];
        typeModel.ID = [result objectForColumn:@"r_ID"];
        typeModel.name = [result stringForColumn:@"r_name"];
        typeModel.img_name = [result stringForColumn:@"r_img_name"];
        typeModel.type = [result longForColumn:@"r_type"];
        typeModel.state = [result longForColumn:@"r_state"];
        typeModel.ranking = [result objectForColumn:@"r_ranking"];
        model.recordTypes = [NSMutableArray arrayWithObject:typeModel];
        [arr addObject:model];
    }
    return arr;
}
+ (NSMutableArray<RecordWithTypeModel *> *)getRecordWithTypesSortMoneyFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type typeId:(NSNumber *)typeId {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT Record.*, RecordType.ID as r_ID, RecordType.name as r_name, RecordType.img_name as r_img_name, RecordType.type as r_type, RecordType.state as r_state, RecordType.ranking as r_ranking from Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.r_ID from Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.r_ID WHERE (RecordType.r_type=? AND Record.record_type_id=? AND time BETWEEN ? AND ?) ORDER BY money DESC, create_time DESC" withArgumentsInArray:@[@(type), typeId, from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        RecordWithTypeModel *model = [RecordWithTypeModel new];
        model.ID = [result objectForColumn:@"ID"];
model.money = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money"]];        model.remark = [result stringForColumn:@"remark"];
        model.time = [result dateForColumn:@"time"];
        model.create_time = [result dateForColumn:@"create_time"];
        model.record_type_id = [result objectForColumn:@"record_type_id"];
        model.assets_id = [result objectForColumn:@"assets_id"];
        RecordTypeModel *typeModel = [RecordTypeModel new];
        typeModel.ID = [result objectForColumn:@"r_ID"];
        typeModel.name = [result stringForColumn:@"r_name"];
        typeModel.img_name = [result stringForColumn:@"r_img_name"];
        typeModel.type = [result longForColumn:@"r_type"];
        typeModel.state = [result longForColumn:@"r_state"];
        typeModel.ranking = [result objectForColumn:@"r_ranking"];
        model.recordTypes = [NSMutableArray arrayWithObject:typeModel];
        [arr addObject:model];
    }
    return arr;
}

+ (BOOL)insertRecord:(RecordModel *)record {
    return [[Dao sharedDao] executeUpdate:@"INSERT INTO Record(money, remark, time, create_time, record_type_id, assets_id) VALUES(?,?,?,?,?,?)" withArgumentsInArray:@[record.money, record.remark, record.time, record.create_time, record.record_type_id, record.assets_id]];
}

+ (BOOL)updateRecords:(NSMutableArray<RecordModel *> *)records {
    [[Dao sharedDao] beginTransaction];
    for (RecordModel *record in records) {
        [[Dao sharedDao] executeUpdate:@"UPDATE Record SET money = ?, remark = ?, time = ?, create_time = ?, record_type_id = ?, assets_id = ? WHERE ID = ?" withArgumentsInArray:@[record.money, record.remark, record.time, record.create_time, record.record_type_id, record.assets_id, record.ID]];
    }
    return [[Dao sharedDao] commit];
}

+ (BOOL)deleteRecord:(RecordModel *)record {
    return [[Dao sharedDao] executeUpdate:@"DELETE FROM Record WHERE ID = ?" withArgumentsInArray:@[record.ID]];
}

+ (NSMutableArray<SumMoneyModel *> *)getSumMoneyFrom:(NSDate *)from to:(NSDate *)to {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT RecordType.type AS type, SUM(Record.money) AS sumMoney FROM Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.ID WHERE time BETWEEN ? AND ? GROUP BY RecordType.type" withArgumentsInArray:@[from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        SumMoneyModel *model = [SumMoneyModel new];
        model.type = [result longForColumn:@"type"];
        model.sum_money = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"sumMoney"]];
        [arr addObject:model];
    }
    return arr;
}
+ (NSInteger)getRecordCountWithTypeId:(NSNumber *)typeId {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT COUNT(ID) FROM Record WHERE record_type_id = ?" withArgumentsInArray:@[typeId]];
    if ([result next]) {
        return [result intForColumnIndex:0];
    }
    return 0;
}
+ (NSMutableArray<RecordModel *> *)getRecordsWithTypeId:(NSNumber *)typeId {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT * FROM Record WHERE record_type_id = ?" withArgumentsInArray:@[typeId]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        RecordModel *model = [RecordModel new];
        model.ID = [result objectForColumn:@"ID"];
model.money = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"money"]];        model.remark = [result stringForColumn:@"remark"];
        model.time = [result dateForColumn:@"time"];
        model.create_time = [result dateForColumn:@"create_time"];
        model.record_type_id = [result objectForColumn:@"record_type_id"];
        model.assets_id = [result objectForColumn:@"assets_id"];
        [arr addObject:model];
    }
    return arr;
}

+ (NSMutableArray<DaySumMoneyModel *> *)getDaySumMoneyFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT RecordType.type AS type, Record.time AS time, SUM(Record.money) AS daySumMoney FROM Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.ID where (RecordType.type=? and Record.time BETWEEN ? AND ?) GROUP BY Record.time" withArgumentsInArray:@[@(type), from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        DaySumMoneyModel *model = [DaySumMoneyModel new];
        model.type = [result longForColumn:@"type"];
        model.time = [result dateForColumn:@"time"];
        model.daySumMoney = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"daySumMoney"]];
        [arr addObject:model];
    }
    return arr;
}

+ (NSMutableArray<TypeSumMoneyModel *> *)getTypeSumMoneyFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT t_type.type AS type, t_type.img_name AS imgName,t_type.name AS typeName, Record.record_type_id AS typeId, SUM(Record.money) AS typeSumMoney, COUNT(Record.record_type_id) AS count FROM Record LEFT JOIN RecordType AS t_type ON Record.record_type_id=t_type.ID where (t_type.type=? and Record.time BETWEEN ? AND ?) GROUP by Record.record_type_id Order by sum(Record.money) DESC" withArgumentsInArray:@[@(type), from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        TypeSumMoneyModel *model = [TypeSumMoneyModel new];
        model.imgName = [result stringForColumn:@"imgName"];
        model.typeName = [result stringForColumn:@"typeName"];
        model.typeSumMoney = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"typeSumMoney"]];
        model.typeId = [result objectForColumn:@"typeId"];
        model.type = [result longForColumn:@"type"];
        model.count = [result longForColumn:@"count"];
        [arr addObject:model];
    }
    return arr;
}

+ (NSMutableArray<MonthSumMoneyModel *> *)getMonthOfYearSumMoneyFrom:(NSDate *)from to:(NSDate *)to {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT substr(datetime(substr(Record.time, 1, 10), 'unixepoch', 'localtime'), 1, 7) AS month, RecordType.type AS type, SUM(Record.money) AS sumMoney FROM Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.id WHERE time BETWEEN ? AND ? GROUP BY RecordType.type, month ORDER BY Record.time DESC" withArgumentsInArray:@[from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        MonthSumMoneyModel *model = [MonthSumMoneyModel new];
        model.type = [result longForColumn:@"type"];
        model.month = [result stringForColumn:@"month"];
        model.sumMoney = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"sumMoney"]];
        [arr addObject:model];
    }
    return arr;
}

+ (NSMutableArray<DaySumMoneyModel *> *)getDaySumMoneyDataFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT RecordType.type AS type, Record.time AS time, sum(Record.money) AS daySumMoney FROM Record LEFT JOIN RecordType ON Record.record_type_id=RecordType.id where (RecordType.type=? and Record.time BETWEEN ? AND ?) GROUP BY Record.time" withArgumentsInArray:@[@(type), from, to]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        DaySumMoneyModel *model = [DaySumMoneyModel new];
        model.type = [result longForColumn:@"type"];
        model.time = [result dateForColumn:@"time"];
        model.daySumMoney = [NSDecimalNumber decimalNumberWithString:[result stringForColumn:@"daySumMoney"]];
        [arr addObject:model];
    }
    return arr;
}

@end
