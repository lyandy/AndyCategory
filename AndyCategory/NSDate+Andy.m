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

@implementation NSDate (CSS)

// 判断是否在某个时间段内,需要手动修改里起始时间
- (BOOL)css_isInTime {
    // 判断时间是否在活动时间范围内,可以配置
    NSDate *startTime = [NSDate css_dateInYear:2016 month:8 day:10];
    NSDate *endTime = [NSDate css_dateInYear:2016 month:8 day:31];
    if (([self compare:startTime] == NSOrderedDescending) && ([self compare:endTime] == NSOrderedAscending)) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)css_dateYMDString
{
    NSDateFormatter *dateYMDFormatter = [[NSDateFormatter alloc] init];
    dateYMDFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateYMDFormatter stringFromDate:self];
}

- (NSString *)css_dateYMDString2
{
    NSDateFormatter *dateYMDFormatter2 = [[NSDateFormatter alloc] init];
    dateYMDFormatter2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter2 setDateFormat:@"yyyy年MM月dd日"];
    
    return [dateYMDFormatter2 stringFromDate:self];
}

- (NSString *)css_dateYMDString3
{
    NSDateFormatter *dateYMDFormatter3 = [[NSDateFormatter alloc] init];
    dateYMDFormatter3.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter3 setDateFormat:@"yyyy.MM.dd"];
    
    return [dateYMDFormatter3 stringFromDate:self];
}

- (NSString *)css_ymdhmString
{
    NSDateFormatter *dateYMDHMFormatter = [[NSDateFormatter alloc] init];
    dateYMDHMFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDHMFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    
    return [dateYMDHMFormatter stringFromDate:self];
}

- (NSString *)css_ymString
{
    NSDateFormatter *dateYMFormatter = [[NSDateFormatter alloc] init];
    dateYMFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMFormatter setDateFormat:@"yyyy年MM月"];
    
    return [dateYMFormatter stringFromDate:self];
}

- (NSString *)css_ymString2
{
    NSDateFormatter *dateYMFormatter2 = [[NSDateFormatter alloc] init];
    dateYMFormatter2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMFormatter2 setDateFormat:@"yyyy-MM"];
    
    return [dateYMFormatter2 stringFromDate:self];
}

- (NSString *)css_mdString
{
    NSDateFormatter *dateMDFormatter = [[NSDateFormatter alloc] init];
    dateMDFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateMDFormatter setDateFormat:@"MM-dd"];
    
    return [dateMDFormatter stringFromDate:self];
}

- (NSString *)css_mdString2
{
    NSDateFormatter *dateMDFormatter2 = [[NSDateFormatter alloc] init];
    dateMDFormatter2.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateMDFormatter2 setDateFormat:@"MM月dd日"];
    
    return [dateMDFormatter2 stringFromDate:self];
}

- (NSString *)css_fullString;
{
    NSDateFormatter *dateFullFormatter = [[NSDateFormatter alloc] init];
    dateFullFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFullFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFullFormatter stringFromDate:self];
}

- (NSString *)css_yString
{
    NSDateFormatter *dateYFormatter = [[NSDateFormatter alloc] init];
    dateYFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYFormatter setDateFormat:@"yyyy年"];
    
    return [dateYFormatter stringFromDate:self];
}

- (NSString *)css_mString
{
    NSDateFormatter *dateMFormatter = [[NSDateFormatter alloc] init];
    dateMFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateMFormatter setDateFormat:@"MM月"];
    
    return [dateMFormatter stringFromDate:self];
}

- (NSString *)css_weekday
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    
    return [weekdays objectAtIndex:comps.weekday];
}

- (NSString *)css_weekdayString
{
    NSString *week = [self css_weekday];
    
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

- (NSString *)css_firstWeekdayInCurrentMonth
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
    
    return [beginDate css_weekday];
}

- (NSInteger)css_daysInCurrentMonth
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSRange range =[calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return range.length;
}

- (NSDate *)css_dateOffsetMonth:(NSInteger)offset
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.month = offset;
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *)css_dateOffsetDay:(NSInteger)offset
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = offset;
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}

- (NSInteger)css_daysToDate:(NSDate *)toDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:self toDate:toDate options:0];
    
    return [comps day];
}

+ (NSDate *)css_dateInYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.year = year;
    comp.month = month;
    comp.day = day;
    
    return [calendar dateFromComponents:comp];
}

- (NSDateComponents *)components
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:self];
}

- (NSDate *)css_dateToNextDay:(NSInteger)nextDay
{
    if (self.components.day < nextDay) {
        return [NSDate css_dateInYear:self.components.year month:self.components.month day:nextDay];
    }else{
        NSDate *date = [self css_dateOffsetMonth:1];
        return [NSDate css_dateInYear:date.components.year month:date.components.month day:nextDay];
    }
}

- (NSDate *)css_dateAfterNowDay:(NSInteger)offset
{
    NSDateFormatter *dateYMDFormatter = [[NSDateFormatter alloc] init];
    dateYMDFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateYMDFormatter setDateFormat:@"yyyy-MM-dd"];
    
    if (offset <= 0) {
        return self;
    }
    NSString *todayString = [self css_dateYMDString];
    NSDate *today = [dateYMDFormatter dateFromString:todayString];
    return [today css_dateOffsetDay:offset];
}

@end