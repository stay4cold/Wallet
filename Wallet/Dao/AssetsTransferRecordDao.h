//
//  AssetsTransferRecordDao.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetsTransferRecordWithAssetsModel.h"

@interface AssetsTransferRecordDao : NSObject

- (NSMutableArray<AssetsTransferRecordWithAssetsModel *> *)getTransferRecordsById:(NSNumber *)ID;
- (BOOL)insertTransferRecord:(NSMutableArray<AssetsTransferRecordModel *> *)assetsTransferRecord;

@end
