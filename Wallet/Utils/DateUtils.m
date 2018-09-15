//
//  DateUtils.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (NSDateFormatter *)getYearMonthFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM";
    return formatter;
}

+ (NSDateFormatter *)getAllFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
    return formatter;
}

+ (NSDateFormatter *)getMonthDayFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd";
    return formatter;
}

+ (NSDateFormatter *)getYearMonthDayFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return formatter;
}

+ (NSDate *)todayDate {
    return [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
}

+ (NSInteger)month2Index:(NSString *)month {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[self dateForString:month format:[self getYearMonthFormatter]]];
}

+ (NSString *)currentYearMonth {
    return [[self getYearMonthFormatter] stringFromDate:[NSDate date]];
}

+ (NSInteger)currentYear {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]];
}
//获取修正后的当前月份
+ (NSInteger)currentMonth {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]];
}
/**
 * 获取当前月份开始时刻的 Date
 * 比如当前是 2018年4月
 * 返回的 Date 是 format 后： 2018-04-01T00:00:00.000+0800
 *
 * @return 当前月份开始的 Date
 */
+ (NSDate *)currentMonthStart {
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    return [self monthStartForYear:component.year month:component.month];
}

/**
 * 获取当前月份结束时刻的 Date
 * 比如当前是 2018年4月
 * 返回的 Date 是 format 后： 2018-04-30T23:59:59.999+0800
 *
 * @return 当前月份结束的 Date
 */
+ (NSDate *)currentMonthEnd {
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    return [self monthEndForYear:component.year month:component.month];
}

//根据年月日创建 Date 对象
+ (NSDate *)dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.second = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

// 时间字符串转化为 Date 对象
+ (NSDate *)dateForString:(NSString *)time format:(NSDateFormatter *)formatter {
    return [formatter dateFromString:time];
}

//Date 对象转化为 时间字符串
+ (NSString *)stringForDate:(NSDate *)date format:(NSDateFormatter *)formatter {
    return [formatter stringFromDate:date];
}

//Date 对象转化为xx月xx日格式字符串
+ (NSString *)monthDayFor:(NSDate *)date {
    return [[self getMonthDayFormatter] stringFromDate:date];
}

//判断两个 Date 是否是同一天
+ (BOOL)sameDayWith:(NSDate *)date1 and:(NSDate *)date2 {
    return [[NSCalendar currentCalendar] isDate:date1 equalToDate:date2 toUnitGranularity:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay];
}

//格式化年月
+ (NSString *)stringForYear:(NSInteger)year month:(NSInteger)month {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    return [[self getYearMonthFormatter] stringFromDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
}

//获取某月有多少天
+ (NSInteger)dayCountForYear:(NSInteger)year month:(NSInteger)month {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[[NSCalendar currentCalendar] dateFromComponents:components]].length;
}

//获取某月份开始时刻的 Date
+ (NSDate *)monthStartForYear:(NSInteger)year month:(NSInteger)month {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

//获取某月份结束时刻的 Date
+ (NSDate *)monthEndForYear:(NSInteger)year month:(NSInteger)month {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    components.second = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[self monthStartForYear:year month:month] options:NSCalendarWrapComponents];
}

//获取某年开始时刻的 Date
+ (NSDate *)yearStartForYear:(NSInteger)year {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

//获取某年结束时刻的 Date
+ (NSDate *)yearEndForYear:(NSInteger)year {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 1;
    components.second = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[self yearStartForYear:year] options:NSCalendarWrapComponents];
}

+ (NSDate *)todayStart {
    return [NSDate dateWithTimeIntervalSince1970:[self todayStartMillis]];
}

+ (NSDate *)todayEnd {
    return [NSDate dateWithTimeIntervalSince1970:[self todayEndMillis]];
}

//获取今天开始时间戳
+ (NSTimeInterval)todayStartMillis {
    NSDate *date = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    return [date timeIntervalSince1970];
}

//获取今天结束时间戳
+ (NSTimeInterval)todayEndMillis {
    NSDateComponents *component = [[NSDateComponents alloc] init];
    component.day = 1;
    component.second = -1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:component toDate:[[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]] options:NSCalendarWrapComponents] timeIntervalSince1970];
}

/**
 * 获取字面时间
 * 如：
 * 1.今天
 * 2.昨天
 * 3.当年内，4月20日
 * 4.超过当年，2017年3月30日
 *
 * @return 字面时间
 */
+ (NSString *)wordTimeForDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if ([calendar isDateInToday:date]) {
        return @"今天";
    } else if ([calendar isDateInYesterday:date]) {
        return @"昨天";
    } else if ([calendar isDate:date equalToDate:[NSDate date] toUnitGranularity:NSCalendarUnitYear]) {
        return [self stringForDate:date format:[self getMonthDayFormatter]];
    } else {
        return [self stringForDate:date format:[self getYearMonthDayFormatter]];
    }
}

@end
