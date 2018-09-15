//
//  SumMoneyModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

//支出或收入的总和
#import <Foundation/Foundation.h>

@interface SumMoneyModel : NSObject

@property (nonatomic, assign) RecordType type;
@property (nonatomic, strong) NSDecimalNumber *sum_money;//支出或收入的总和

@end
