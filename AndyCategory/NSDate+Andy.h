//
//  NSDate+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Andy)

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

//获取今天周几
- (NSInteger)andy_getNowWeekday;

@end
