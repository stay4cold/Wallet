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
    NSArray *source = @[@[NSLocalizedString(@"text_bank_zhaoshang", nil), @"bank_zhaoshang"],
                        @[NSLocalizedString(@"text_bank_icbc", nil), @"bank_icbc"],
                        @[NSLocalizedString(@"text_bank_abchina", nil), @"bank_abchina"],
                        @[NSLocalizedString(@"text_bank_boc", nil), @"bank_boc"],
                        @[NSLocalizedString(@"text_bank_ccb", nil), @"bank_ccb"],
                        @[NSLocalizedString(@"text_bank_pingan", nil), @"bank_pingan"],
                        @[NSLocalizedString(@"text_bank_bankcomm", nil), @"bank_bankcomm"],
                        @[NSLocalizedString(@"text_bank_citicbank", nil), @"bank_citicbank"],
                        @[NSLocalizedString(@"text_bank_cib", nil), @"bank_cib"],
                        @[NSLocalizedString(@"text_bank_cebbank", nil), @"bank_cebbank"],
                        @[NSLocalizedString(@"text_bank_cmbc", nil), @"bank_cmbc"],
                        @[NSLocalizedString(@"text_bank_chinapost", nil), @"bank_chinapost"],
                        @[NSLocalizedString(@"text_assets_card", nil), @"assets_card"]
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
