//
//  RecordTypeDao.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecordTypeModel.h"

@interface RecordTypeDao : NSObject

+ (NSMutableArray<RecordTypeModel *> *)getAllRecordTypes;
+ (NSInteger)getRecordTypeCount;
+ (NSMutableArray<RecordTypeModel *> *)getRecordTypes:(RecordType)type;
+ (RecordTypeModel *)getRecordType:(RecordType)type byName:(NSString *)name;
+ (BOOL)insertRecordTypes:(NSMutableArray<RecordTypeModel *> *)recordType;
+ (BOOL)updateRecordTypes:(NSMutableArray<RecordTypeModel *> *)recordType;
+ (BOOL)deleteRecordType:(RecordTypeModel *)recordType;
+ (BOOL)initRecordTypes;
+ (NSArray *)getAllRecordTypeImgs:(RecordType)type;
@end
