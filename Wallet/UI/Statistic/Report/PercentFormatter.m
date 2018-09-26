//
//  PercentFormatter.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/26.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "PercentFormatter.h"

@interface PercentFormatter()

@property (nonatomic, strong) NSNumberFormatter *formatter;

@end

@implementation PercentFormatter

- (NSNumberFormatter *)formatter {
    if (!_formatter) {
        _formatter = [NSNumberFormatter new];
        [_formatter setPositiveFormat:@"###,###,##0.0"];
    }
    return _formatter;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return [self.formatter stringFromNumber:[NSNumber numberWithDouble:value]];
}

- (NSString *)stringForValue:(double)value entry:(ChartDataEntry *)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler *)viewPortHandler {
    return [self.formatter stringFromNumber:[NSNumber numberWithDouble:value]];
}

@end
