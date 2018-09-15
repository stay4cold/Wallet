//
//  DaySumMoneyModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

//某天的支出或收入总和
#import <Foundation/Foundation.h>

@interface DaySumMoneyModel : NSObject

@property (nonatomic, assign) RecordType type;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSDecimalNumber *daySumMoney;//支出或收入总和

@end
