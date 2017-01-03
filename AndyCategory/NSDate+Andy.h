//
//  NSDate+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Andy)

@property (nonatomic, readonly) NSInteger andy_year; ///< Year component
@property (nonatomic, readonly) NSInteger andy_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger andy_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger andy_hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger andy_minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger andy_second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger andy_nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger andy_weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger andy_weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger andy_weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger andy_weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger andy_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger andy_quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL andy_isLeapMonth; ///< Weather the month is leap month
@property (nonatomic, readonly) BOOL andy_isLeapYear; ///< Weather the year is leap year
@property (nonatomic, readonly) BOOL andy_isToday; ///< Weather date is today (based on current locale)
@property (nonatomic, readonly) BOOL andy_isYesterday; ///< Weather date is yesterday (based on current

/**
 *  是否为今天
 */
- (BOOL)andy_isToday;

/**
 *  是否为昨天
 */
- (BOOL)andy_isYesterday;

/**
 *  是否为今年
 */
- (BOOL)andy_isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)andy_dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)andy_deltaWithNow;

- (NSString *)andy_dateStringWithFormat:(NSString *)format;

+ (NSDate *)andy_dateWithYear:(int)year;

// 获取今天周几
- (NSInteger)andy_getNowWeekday;

@end

@interface NSDate (CSS)

// 判断是否在某个时间段内,需要手动修改里起始时间
- (BOOL)css_isInTime;

/**
 *  格式化日期
 *
 *  @return 时间日期字符串。
 */
- (NSString *)css_dateYMDString;
- (NSString *)css_dateYMDString2;
- (NSString *)css_dateYMDString3;

- (NSString *)css_ymdhmString;
- (NSString *)css_ymString;
- (NSString *)css_ymString2;
- (NSString *)css_mdString;
- (NSString *)css_mdString2;
- (NSString *)css_fullString;
- (NSString *)css_yString;
- (NSString *)css_mString;

/**
 *  获取当前日期是周几
 *
 *  @return 输出结果是星期几的字符串。
 */
- (NSString *)css_weekday;

- (NSString *)css_weekdayString;

/**
 *  获取当前日期所在月的第一天是周几
 *
 *  @return 输出结果是星期几的字符串。
 */
- (NSString *)css_firstWeekdayInCurrentMonth;

/**
 *  获取当前日期所在月有多少天
 *
 *  @return 天数
 */
- (NSInteger)css_daysInCurrentMonth;

- (NSDate *)css_dateOffsetYears:(NSInteger)offset;

- (NSDate *)css_dateOffsetWeeks:(NSInteger)offset;

- (NSDate *)css_dateOffsetHours:(NSInteger)offset;

- (NSDate *)css_dateOffsetMinutes:(NSInteger)offset;

- (NSDate *)css_dateOffsetSeconds:(NSInteger)offset;

/**
 *  获取当前日期所在月的下offset个月
 *
 *  @return 获得时间
 */
- (NSDate *)css_dateOffsetMonths:(NSInteger)offset;

/**
 *  获取当前日期的下offset个日期
 *
 *  @return 获得时间
 */
- (NSDate *)css_dateOffsetDays:(NSInteger)offset;

/**
 *  获取当前日期距离下个date的天数
 *
 *  @return 天数
 */
- (NSInteger)css_daysToDate:(NSDate *)toDate;

/**
 *  获取日期
 *
 *  @return 日期
 */
+ (NSDate *)css_dateInYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 *  获取当前日期组件实例
 *
 *  @return 获得组件实例
 */
- (NSDateComponents *)components;

/**
 *  current = 2016.7.19 & nextDay = 12 -->> return 2016.8.12
 *  current = 2016.7.19 & nextDay = 19 -->> return 2016.8.19
 *  current = 2016.7.19 & nextDay = 21 -->> return 2016.7.21
 */
- (NSDate *)css_dateToNextDay:(NSInteger)nextDay;

/**
 *  current = 2016.7.19 16:00:00 & nextDay = 3 -->> return 2016.7.22 00:00:00
 */
- (NSDate *)css_dateAfterNowDay:(NSInteger)offset;

@end
