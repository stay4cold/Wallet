//
//  RecordDao.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetsModel.h"
#import "RecordModel.h"
#import "RecordWithTypeModel.h"
#import "SumMoneyModel.h"
#import "DaySumMoneyModel.h"
#import "MonthSumMoneyModel.h"
#import "TypeSumMoneyModel.h"

@interface RecordDao : NSObject

+ (NSMutableArray<RecordWithTypeModel *> *)getRangeRecordWithTypesFrom:(NSDate *)from to:(NSDate *)to;
+ (NSMutableArray<RecordWithTypeModel *> *)getRangeRecordWithTypesFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type;
+ (NSMutableArray<RecordWithTypeModel *> *)getRangeRecordWithTypesFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type typeId:(NSNumber *)typeId;
+ (NSMutableArray<RecordWithTypeModel *> *)getRecordWithTypesSortMoneyFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type typeId:(NSNumber *)typeId;;

+ (BOOL)insertRecord:(RecordModel *)record;
+ (BOOL)updateRecords:(NSMutableArray<RecordModel *> *)records;
+ (BOOL)deleteRecord:(RecordModel *)record;

+ (NSMutableArray<SumMoneyModel *> *)getSumMoneyFrom:(NSDate *)from to:(NSDate *)to;
+ (NSInteger)getRecordCountWithTypeId:(NSNumber *)typeId;
+ (NSMutableArray<RecordModel *> *)getRecordsWithTypeId:(NSNumber *)typeId;

+ (NSMutableArray<DaySumMoneyModel *> *)getDaySumMoneyFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type;
+ (NSMutableArray<TypeSumMoneyModel *> *)getTypeSumMoneyFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type;

+ (NSMutableArray<MonthSumMoneyModel *> *)getMonthOfYearSumMoneyFrom:(NSDate *)from to:(NSDate *)to;
+ (NSMutableArray<DaySumMoneyModel *> *)getDaySumMoneyDataFrom:(NSDate *)from to:(NSDate *)to type:(RecordType)type;


@end
