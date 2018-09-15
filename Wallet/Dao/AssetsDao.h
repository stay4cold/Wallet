//
//  AssetsDao.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetsModel.h"
#import "AssetsMoneyModel.h"

@interface AssetsDao : NSObject

- (NSMutableArray<AssetsModel *> *)getAllAssets;
- (AssetsModel *)getAssetsById:(NSNumber *)ID;
- (BOOL)insertAssets:(NSMutableArray<AssetsModel *> *)assets;
- (BOOL)updateAssets:(NSMutableArray<AssetsModel *> *)assets;
- (BOOL)deleteAssets:(AssetsModel *)assets;
- (AssetsMoneyModel *)getAssetsMoney;

@end
