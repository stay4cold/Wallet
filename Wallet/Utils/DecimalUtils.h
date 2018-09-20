//
//  DecimalUtils.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecimalUtils : NSObject

//分转化为元
+ (NSString *)fen2Yuan:(NSDecimalNumber *)fen;
//
+ (NSString *)formatNum:(NSString *)num;
//分转换为元，去掉分隔符
+ (NSString *)fen2YuanNoSeparator:(NSDecimalNumber *)fen;
//元转换为分
+ (NSDecimalNumber *)yuan2Fen:(NSString *)yuan;

@end
