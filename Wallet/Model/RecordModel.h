//
//  RecordModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSDecimalNumber *money;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSDate *create_time;
@property (nonatomic, strong) NSNumber *record_type_id;
@property (nonatomic, strong) NSNumber *assets_id;

@end
