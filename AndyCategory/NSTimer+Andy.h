//
//  NSTimer+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 2016/12/26.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Andy)

+ (NSTimer *)andy_timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo handler:(void(^)(void))handler;

+ (NSTimer *)andy_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo handler:(void(^)(void))handler;

@end
