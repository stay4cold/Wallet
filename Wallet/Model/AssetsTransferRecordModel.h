//
//  AssetsTransferRecordModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsTransferRecordModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, assign) RecordState state;
@property (nonatomic, strong) NSDate *create_time;
@property (nonatomic, strong) NSDate *time;

@property (nonatomic, strong) NSNumber *assets_id_from;
@property (nonatomic, strong) NSNumber *assets_id_to;

@property (nonatomic, copy) NSString *remark;
@property (nonatomic, strong) NSDecimalNumber *money;//转账金额
@end
