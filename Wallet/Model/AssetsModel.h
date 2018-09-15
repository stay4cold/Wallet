//
//  AssetsModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

//资产
#import <Foundation/Foundation.h>

@interface AssetsModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img_name;
@property (nonatomic, assign) RecordType type;
@property (nonatomic, assign) RecordState state;
@property (nonatomic, copy) NSString *remark;//备注信息
@property (nonatomic, strong) NSDate *create_time;
@property (nonatomic, strong) NSDecimalNumber *money;
@property (nonatomic, strong) NSDecimalNumber *money_init;//初始化金额

@end
