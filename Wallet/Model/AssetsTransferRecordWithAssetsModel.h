//
//  AssetsTransferRecordWithAssetsModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsTransferRecordModel.h"

@interface AssetsTransferRecordWithAssetsModel : AssetsTransferRecordModel

@property (nonatomic, copy) NSString *assetsNameFrom;
@property (nonatomic, copy) NSString *assetsNameTo;

@end
