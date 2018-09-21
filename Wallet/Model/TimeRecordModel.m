//
//  TimeRecordModel.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/20.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "TimeRecordModel.h"

@implementation TimeRecordModel

- (NSString *)title {
    if (!_title) {
        _title = [DateUtils monthDayFor:self.date];
    }
    return _title;
}

- (NSMutableArray *)records {
    if (!_records) {
        _records = [NSMutableArray array];
    }
    return _records;
}

@end
