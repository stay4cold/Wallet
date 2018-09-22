//
//  DecimalUtils.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "DecimalUtils.h"

@implementation DecimalUtils

//分转化为元
+ (NSString *)fen2Yuan:(NSDecimalNumber *)fen {
    if (fen) {
        if ([fen isEqual:NSDecimalNumber.notANumber]) {
            fen = NSDecimalNumber.zero;
        }
        NSDecimalNumber *yuan = [fen decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
        NSNumberFormatter *f = [NSNumberFormatter new];
        f.groupingSeparator = @"";
        f.numberStyle = NSNumberFormatterDecimalStyle;
        return [[self formatter:[f stringFromNumber:yuan]] stringFromNumber:yuan];
    } else {
        return @"";
    }
}

+ (NSString *)formatNum:(NSString *)num {
    NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:num];
    if ([dn isEqual:NSDecimalNumber.notANumber]) {
        dn = NSDecimalNumber.zero;
    }
    return [[self formatter:num] stringFromNumber:dn];
}

//分转换为元，去掉分隔符
+ (NSString *)fen2YuanNoSeparator:(NSDecimalNumber *)fen {
    return [[self fen2Yuan:fen] stringByReplacingOccurrencesOfString:@"," withString:@""];
}

//元转换为分
+ (NSDecimalNumber *)yuan2Fen:(NSString *)yuan {
    NSDecimalNumber *yuanNum = [NSDecimalNumber decimalNumberWithString:yuan];
    if ([yuanNum isEqual:NSDecimalNumber.notANumber]) {
        return NSDecimalNumber.zero;
    } else {
        // 元最多两位小数，可直接去掉小数位
        NSDecimalNumber *multi = [NSDecimalNumber decimalNumberWithString:@"100"];
        NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        return [yuanNum decimalNumberByMultiplyingBy:multi withBehavior:handler];
    }
}

+ (NSNumberFormatter *)formatter:(NSString *)yuan {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSArray *strArr = [yuan componentsSeparatedByString:@"."];
    if (strArr.count == 2) {
        if ([strArr[1] length] == 1) {
            [formatter setPositiveFormat:@"#,##0.0"];
        } else {
            [formatter setPositiveFormat:@"#,##0.00"];
        }
    } else {
        [formatter setPositiveFormat:@"#,###"];
    }
    return formatter;
}

@end
