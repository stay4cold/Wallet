//
//  TimeRecordModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/20.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeRecordModel : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray *records;

@end
