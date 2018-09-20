//
//  BankCreator.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankModel.h"

@interface BankCreator : NSObject

+ (NSMutableArray<BankModel *> *)getAllBankItems;

@end
