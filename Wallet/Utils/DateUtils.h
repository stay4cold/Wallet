//
//  DateUtils.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (NSDateFormatter *)getYearMonthFormatter;
+ (NSDateFormatter *)getAllFormatter;
+ (NSDateFormatter *)getMonthDayFormatter;
+ (NSDateFormatter *)getYearMonthDayFormatter;

+ (NSDate *)todayDate;
+ (NSInteger)month2Index:(NSString *)month;
+ (NSString *)currentYearMonth;
+ (NSInteger)currentYear;
//获取修正后的当前月份
+ (NSInteger)currentMonth;
/**
 * 获取当前月份开始时刻的 Date
 * 比如当前是 2018年4月
 * 返回的 Date 是 format 后： 2018-04-01T00:00:00.000+0800
 *
 * @return 当前月份开始的 Date
 */
+ (NSDate *)currentMonthStart;
/**
 * 获取当前月份结束时刻的 Date
 * 比如当前是 2018年4月
 * 返回的 Date 是 format 后： 2018-04-30T23:59:59.999+0800
 *
 * @return 当前月份结束的 Date
 */
+ (NSDate *)currentMonthEnd;
//根据年月日创建 Date 对象
+ (NSDate *)dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
// 时间字符串转化为 Date 对象
+ (NSDate *)dateForString:(NSString *)time format:(NSDateFormatter *)formatter;
//Date 对象转化为 时间字符串
+ (NSString *)stringForDate:(NSDate *)date format:(NSDateFormatter *)formatter;
//Date 对象转化为xx月xx日格式字符串
+ (NSString *)monthDayFor:(NSDate *)date;
//判断两个 Date 是否是同一天
+ (BOOL)sameDayWith:(NSDate *)date1 and:(NSDate *)date2;
//格式化年月
+ (NSString *)stringForYear:(NSInteger)year month:(NSInteger)month;
//获取某月有多少天
+ (NSInteger)dayCountForYear:(NSInteger)year month:(NSInteger)month;
//获取某月份开始时刻的 Date
+ (NSDate *)monthStartForYear:(NSInteger)year month:(NSInteger)month;
//获取某月份结束时刻的 Date
+ (NSDate *)monthEndForYear:(NSInteger)year month:(NSInteger)month;
//获取某年开始时刻的 Date
+ (NSDate *)yearStartForYear:(NSInteger)year;
//获取某年结束时刻的 Date
+ (NSDate *)yearEndForYear:(NSInteger)year;
+ (NSDate *)todayStart;
+ (NSDate *)todayEnd;
//获取今天开始时间戳
+ (NSTimeInterval)todayStartMillis;
//获取今天结束时间戳
+ (NSTimeInterval)todayEndMillis;
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
+ (NSString *)wordTimeForDate:(NSDate *)date;

@end
