//
//  BankCreator.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "BankCreator.h"

@implementation BankCreator

+ (NSMutableArray<BankModel *> *)getAllBankItems {
    NSArray *source = @[@[@"招商银行", @"bank_zhaoshang"],
                        @[@"工商银行", @"bank_icbc"],
                        @[@"农业银行", @"bank_abchina"],
                        @[@"中国银行", @"bank_boc"],
                        @[@"建设银行", @"bank_ccb"],
                        @[@"平安银行", @"bank_pingan"],
                        @[@"交通银行", @"bank_bankcomm"],
                        @[@"中信银行", @"bank_citicbank"],
                        @[@"兴业银行", @"bank_cib"],
                        @[@"光大银行", @"bank_cebbank"],
                        @[@"民生银行", @"bank_cmbc"],
                        @[@"邮政储蓄银行", @"bank_chinapost"],
                        @[@"其它银行", @"assets_card"]
                        ];
    NSMutableArray *tArr = [NSMutableArray array];
    for (NSArray *arr in source) {
        BankModel *bank = [BankModel new];
        bank.name = arr[0];
        bank.imgName = arr[1];
        [tArr addObject:bank];
    }
    return tArr;
}

@end
