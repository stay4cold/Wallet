//
//  RecordTypeDao.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "RecordTypeDao.h"
#import "Dao.h"

@implementation RecordTypeDao

+ (NSMutableArray<RecordTypeModel *> *)getAllRecordTypes {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT * FROM RecordType WHERE state = ? ORDER BY ranking" withArgumentsInArray:@[@0]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        RecordTypeModel *model = [RecordTypeModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.name = [result stringForColumn:@"name"];
        model.img_name = [result stringForColumn:@"img_name"];
        model.type = [result longForColumn:@"type"];
        model.ranking = [result objectForColumn:@"ranking"];
        model.state = [result longForColumn:@"state"];
        [arr addObject:model];
    }
    return arr;
}

+ (NSInteger)getRecordTypeCount {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT COUNT(ID) FROM RecordType"];
    if ([result next]) {
        return [result intForColumnIndex:0];
    }
    return 0;
}

+ (NSMutableArray<RecordTypeModel *> *)getRecordTypes:(RecordType)type {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT * FROM RecordType WHERE state = ? AND type = ? ORDER BY ranking" withArgumentsInArray:@[@0, @(type)]];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        RecordTypeModel *model = [RecordTypeModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.name = [result stringForColumn:@"name"];
        model.img_name = [result stringForColumn:@"img_name"];
        model.type = [result longForColumn:@"type"];
        model.ranking = [result objectForColumn:@"ranking"];
        model.state = [result longForColumn:@"state"];
        [arr addObject:model];
    }
    return arr;
}

+ (RecordTypeModel *)getRecordType:(RecordType)type byName:(NSString *)name {
    FMResultSet *result = [[Dao sharedDao] executeQuery:@"SELECT * FROM RecordType WHERE type = ? AND name = ?" withArgumentsInArray:@[@(type), name]];
    if ([result next]) {
        RecordTypeModel *model = [RecordTypeModel new];
        model.ID = [result objectForColumn:@"ID"];
        model.name = [result stringForColumn:@"name"];
        model.img_name = [result stringForColumn:@"img_name"];
        model.type = [result longForColumn:@"type"];
        model.ranking = [result objectForColumn:@"ranking"];
        model.state = [result longForColumn:@"state"];
        return model;
    }
    return nil;
}

+ (BOOL)insertRecordTypes:(NSMutableArray<RecordTypeModel *> *)recordType {
    [[Dao sharedDao] beginTransaction];
    for (RecordTypeModel *model in recordType) {
        [[Dao sharedDao] executeUpdate:@"INSERT INTO RecordType(name, img_name, type, ranking, state) VALUES(?,?,?,?,?)" withArgumentsInArray:@[model.name, model.img_name, @(model.type), model.ranking, @(model.state)]];
    }
    return [[Dao sharedDao] commit];
}

+ (BOOL)updateRecordTypes:(NSMutableArray<RecordTypeModel *> *)recordType {
    [[Dao sharedDao] beginTransaction];
    for (RecordTypeModel *model in recordType) {
       [[Dao sharedDao] executeUpdate:@"UPDATE RecordType SET name = ?, img_name = ?, type = ?, ranking = ?, state = ? WHERE ID = ?" withArgumentsInArray:@[model.name, model.img_name, @(model.type), model.ranking, @(model.state), model.ID]];
    }
    return [[Dao sharedDao] commit];
}

+ (BOOL)deleteRecordType:(RecordTypeModel *)recordType {
    return [[Dao sharedDao] executeUpdate:@"DELETE FROM RecordType WHERE ID = ?" withArgumentsInArray:@[recordType.ID]];
}

+ (BOOL)initRecordTypes {
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:[self recordTypeModel:@"餐饮" withImgName:@"type_eat" withType:RecordTypeOutlay withRanking:@(0)]];
    [arr addObject:[self recordTypeModel:@"日用" withImgName:@"type_calendar" withType:RecordTypeOutlay withRanking:@(1)]];
    [arr addObject:[self recordTypeModel:@"电子产品" withImgName:@"type_3c" withType:RecordTypeOutlay withRanking:@(2)]];
    [arr addObject:[self recordTypeModel:@"衣服" withImgName:@"type_clothes" withType:RecordTypeOutlay withRanking:@(3)]];
    [arr addObject:[self recordTypeModel:@"医疗" withImgName:@"type_pill" withType:RecordTypeOutlay withRanking:@(4)]];
    [arr addObject:[self recordTypeModel:@"零食" withImgName:@"type_candy" withType:RecordTypeOutlay withRanking:@(5)]];
    [arr addObject:[self recordTypeModel:@"礼物" withImgName:@"type_humanity" withType:RecordTypeOutlay withRanking:@(6)]];
    [arr addObject:[self recordTypeModel:@"宠物" withImgName:@"type_pet" withType:RecordTypeOutlay withRanking:@(7)]];
    
    [arr addObject:[self recordTypeModel:@"薪资" withImgName:@"type_salary" withType:RecordTypeIncome withRanking:@(0)]];
    [arr addObject:[self recordTypeModel:@"兼职" withImgName:@"type_pluralism" withType:RecordTypeIncome withRanking:@(1)]];
    
    return [self insertRecordTypes:arr];
}

+ (RecordTypeModel *)recordTypeModel:(NSString *)name withImgName:(NSString *)imgName withType:(RecordType)type withRanking:(NSNumber *)ranking {
    RecordTypeModel *model = [RecordTypeModel new];
    model.name = name;
    model.img_name = imgName;
    model.type = type;
    model.ranking = ranking;
    return model;
}

@end
