//
//  WalletEnumHeader.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#ifndef WalletEnumHeader_h
#define WalletEnumHeader_h

typedef NS_ENUM(NSInteger, RecordType) {
    RecordTypeOutlay,//支出
    RecordTypeIncome,//收入
};

typedef NS_ENUM(NSInteger, RecordState) {
    RecordStateNormal,//正常
    RecordStateDeleted,//删除
};

typedef NS_ENUM(NSInteger, AssetsType) {
    AssetsTypeAdd = -2,//新建账户
    AssetsTypeNo = -1,//不选择账户
    AssetsTypeNormal,//资产
    AssetsTypeInvest,//投资
};

#endif /* WalletEnumHeader_h */
