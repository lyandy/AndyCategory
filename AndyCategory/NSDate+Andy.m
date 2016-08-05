//
//  NSDate+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSDate+Andy.h"

@implementation NSDate (Andy)

/*
**
*  是否为今天
*/
- (BOOL)andy_isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)andy_isYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] andy_dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self andy_dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)andy_dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 *  是否为今年
 */
- (BOOL)andy_isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)andy_deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

//yyyy-MM-dd HH:mm:ss
- (NSString *)andy_dateStringWithFormat:(NSString *)format
{
    NSDateFormatter *dateTimeFormatter = [NSDateFormatter new];
    [dateTimeFormatter setDateFormat:format];
    [dateTimeFormatter setLocale:[NSLocale currentLocale]];
    return [dateTimeFormatter stringFromDate:self];
}

+ (NSDate *)andy_dateWithYear:(int)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    [components setYear:year];
    return [calendar dateFromComponents:components];
}

- (NSInteger)andy_getNowWeekday
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps day];
}

@end

static NSDateFormatter *dateYMDFormatter;
static NSDateFormatter *dateYMDFormatter2;
static NSDateFormatter *dateYMDFormatter3;
static NSDateFormatter *dateYMDHMFormatter;
static NSDateFormatter *dateYMFormatter;
static NSDateFormatter *dateYMFormatter2;
static NSDateFormatter *dateMDFormatter;
static NSDateFormatter *dateMDFormatter2;
static NSDateFormatter *dateFullFormatter;
static NSDateFormatter *dateYFormatter;
static NSDateFormatter *dateMFormatter;

static NSCalendar      *calendar;

@implementation NSDate (CSS)

+ (void)load
{
    dateYMDFormatter = [[NSDateFormatter alloc] init];
    dateYMDFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter setDateFormat:@"yyyy-MM-dd"];
    
    dateYMDFormatter2 = [[NSDateFormatter alloc] init];
    dateYMDFormatter2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter2 setDateFormat:@"yyyy年MM月dd日"];
    
    dateYMDFormatter3 = [[NSDateFormatter alloc] init];
    dateYMDFormatter3.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter3 setDateFormat:@"yyyy.MM.dd"];
    
    dateYMDHMFormatter = [[NSDateFormatter alloc] init];
    dateYMDHMFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDHMFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    
    dateYMFormatter = [[NSDateFormatter alloc] init];
    dateYMFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMFormatter setDateFormat:@"yyyy年MM月"];
    
    dateYMFormatter2 = [[NSDateFormatter alloc] init];
    dateYMFormatter2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMFormatter2 setDateFormat:@"yyyy-MM"];
    
    dateMDFormatter = [[NSDateFormatter alloc] init];
    dateMDFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateMDFormatter setDateFormat:@"MM-dd"];
    
    dateMDFormatter2 = [[NSDateFormatter alloc] init];
    dateMDFormatter2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateMDFormatter2 setDateFormat:@"MM月dd日"];
    
    dateFullFormatter = [[NSDateFormatter alloc] init];
    dateFullFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFullFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    dateYFormatter = [[NSDateFormatter alloc] init];
    dateYFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYFormatter setDateFormat:@"yyyy年"];
    
    dateMFormatter = [[NSDateFormatter alloc] init];
    dateMFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateMFormatter setDateFormat:@"MM月"];
    
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
}

// 判断是否在某个时间段内,需要手动修改里起始时间
- (BOOL)isInTime {
    // 判断时间是否在活动时间范围内,可以配置
    NSDate *startTime = [NSDate dateInYear:2016 month:8 day:10];
    NSDate *endTime = [NSDate dateInYear:2016 month:8 day:31];
    if (([self compare:startTime] == NSOrderedDescending) && ([self compare:endTime] == NSOrderedAscending)) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)dateString
{
    return [dateYMDFormatter stringFromDate:self];
}

- (NSString *)dateString2
{
    return [dateYMDFormatter2 stringFromDate:self];
}

- (NSString *)dateString3
{
    return [dateYMDFormatter3 stringFromDate:self];
}

- (NSString *)ymdhmString
{
    return [dateYMDHMFormatter stringFromDate:self];
}

- (NSString *)ymString
{
    return [dateYMFormatter stringFromDate:self];
}

- (NSString *)ymString2
{
    return [dateYMFormatter2 stringFromDate:self];
}

- (NSString *)mdString
{
    return [dateMDFormatter stringFromDate:self];
}

- (NSString *)mdString2
{
    return [dateMDFormatter2 stringFromDate:self];
}

- (NSString *)fullString;
{
    return [dateFullFormatter stringFromDate:self];
}

- (NSString *)yString
{
    return [dateYFormatter stringFromDate:self];
}

- (NSString *)mString
{
    return [dateMFormatter stringFromDate:self];
}

- (NSString *)weekday
{
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    
    return [weekdays objectAtIndex:comps.weekday];
}

- (NSString *)weekdayString
{
    NSString *week = [self weekday];
    
    NSDictionary *map = @{@"0" : @"周日",
                          @"1" : @"周一",
                          @"2" : @"周二",
                          @"3" : @"周三",
                          @"4" : @"周四",
                          @"5" : @"周五",
                          @"6" : @"周六",
                          };
    
    return map[week];
}

- (NSString *)firstWeekdayInCurrentMonth
{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];;
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:self];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    
    return [beginDate weekday];
}

- (NSInteger)daysInCurrentMonth
{
    NSRange range =[calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return range.length;
}

- (NSDate *)dateOffsetMonth:(NSInteger)offset
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.month = offset;
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *)dateOffsetDay:(NSInteger)offset
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = offset;
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}

- (NSInteger)daysToDate:(NSDate *)toDate
{
    NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:self toDate:toDate options:0];
    
    return [comps day];
}

+ (NSDate *)dateInYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.year = year;
    comp.month = month;
    comp.day = day;
    
    return [calendar dateFromComponents:comp];
}

- (NSDateComponents *)components
{
    return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:self];
}

- (NSDate *)dateToNextDay:(NSInteger)nextDay
{
    if (self.components.day < nextDay) {
        return [NSDate dateInYear:self.components.year month:self.components.month day:nextDay];
    }else{
        NSDate *date = [self dateOffsetMonth:1];
        return [NSDate dateInYear:date.components.year month:date.components.month day:nextDay];
    }
}

- (NSDate *)dateAfterNowDay:(NSInteger)offset
{
    if (offset <= 0) {
        return self;
    }
    NSString *todayString = [self dateString];
    NSDate *today = [dateYMDFormatter dateFromString:todayString];
    return [today dateOffsetDay:offset];
}

@end