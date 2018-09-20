//
//  AssetsModifyRecordDao.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetsModifyRecordModel.h"

@interface AssetsModifyRecordDao : NSObject

+ (NSMutableArray<AssetsModifyRecordModel *> *)getAssetsRecordsById:(NSNumber *)ID;
+ (BOOL)insertAssetsRecords:(NSMutableArray<AssetsModifyRecordModel *> *)modifyRecord;

@end
