//
//  MonthSumMoneyModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

//某月支出或收入的总和
#import <Foundation/Foundation.h>

@interface MonthSumMoneyModel : NSObject

@property (nonatomic, assign) RecordType type;
@property (nonatomic, copy) NSString *month;//月份，格式：2018-07
@property (nonatomic, strong) NSDecimalNumber *sumMoney;//支出或收入的总和

@end
