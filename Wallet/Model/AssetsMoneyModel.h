//
//  AssetsMoneyModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsMoneyModel : NSObject

@property (nonatomic, strong) NSDecimalNumber *netAssets;
@property (nonatomic, strong) NSDecimalNumber *allAssets;
@property (nonatomic, strong) NSDecimalNumber *liabilityAssets;

@end
