//
//  ConfigManager.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject

+ (NSNumber *)getAssetsId;
+ (void)setAssetsId:(NSNumber *)ID;
+ (NSString *)getCurrentSymbol;
+ (void)setCurrentSymbol:(NSString *)symbol;
+ (NSArray<NSString *> *)getSymbol;
+ (NSArray<NSString *> *)getSimpleSymbol;
+ (NSInteger)getBudget;
//设置预算，元为单位
+ (void)setBudget:(NSInteger)budget;
+ (BOOL)isFast;
+ (void)setFast:(BOOL)fast;

@end
