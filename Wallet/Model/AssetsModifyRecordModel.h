//
//  AssetsModifyRecordModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

//资产调整记录
#import <Foundation/Foundation.h>

@interface AssetsModifyRecordModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, assign) RecordState state;
@property (nonatomic, strong) NSDate *create_time;
@property (nonatomic, strong) NSNumber *assets_id;
@property (nonatomic, strong) NSDecimalNumber *money_before;//调整余额前金额
@property (nonatomic, strong) NSDecimalNumber *money;//调整余额后金额

@end
