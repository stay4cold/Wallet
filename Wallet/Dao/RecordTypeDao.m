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
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_eat", nil) withImgName:@"type_eat" withType:RecordTypeOutlay withRanking:@(0)]];
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_calendar", nil) withImgName:@"type_calendar" withType:RecordTypeOutlay withRanking:@(1)]];
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_3c", nil) withImgName:@"type_3c" withType:RecordTypeOutlay withRanking:@(2)]];
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_clothes", nil) withImgName:@"type_clothes" withType:RecordTypeOutlay withRanking:@(3)]];
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_pill", nil) withImgName:@"type_pill" withType:RecordTypeOutlay withRanking:@(4)]];
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_candy", nil) withImgName:@"type_candy" withType:RecordTypeOutlay withRanking:@(5)]];
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_humanity", nil) withImgName:@"type_humanity" withType:RecordTypeOutlay withRanking:@(6)]];
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_pet", nil) withImgName:@"type_pet" withType:RecordTypeOutlay withRanking:@(7)]];
    
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_salary", nil) withImgName:@"type_salary" withType:RecordTypeIncome withRanking:@(0)]];
    [arr addObject:[self recordTypeModel:NSLocalizedString(@"type_pluralism", nil) withImgName:@"type_pluralism" withType:RecordTypeIncome withRanking:@(1)]];
    
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

+ (NSArray *)getAllRecordTypeImgs:(RecordType)type {
    if (type == RecordTypeOutlay) {
        return @[@"type_eat",
                 @"type_calendar",
                 @"type_3c",
                 @"type_clothes",
                 @"type_candy",
                 @"type_cigarette",
                 @"type_humanity",
                 @"type_pill",
                 @"type_fitness",
                 @"type_sim",
                 @"type_study",
                 @"type_pet",
                 @"type_train",
                 @"type_plain",
                 @"type_bus",
                 @"type_home",
                 @"type_wifi",
                 @"type_insure",
                 @"type_outlay_red",
                 @"type_adventure",
                 @"type_movie",
                 @"type_reduce",
                 @"type_shopping",
                 @"type_handling_fee",
                 ];
    } else {
        return @[@"type_salary",
                 @"type_pluralism",
                 @"type_wallet",
                 @"type_income_red",
                 @"type_back_money",
                 @"type_unexpected_income",
                 @"type_interest"];
    }
}

@end
