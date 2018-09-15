//
//  TypeSumMoneyModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeSumMoneyModel : NSObject

@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, strong) NSDecimalNumber *typeSumMoney;
@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, assign) RecordType type;
@property (nonatomic, assign) NSInteger count;

@end
