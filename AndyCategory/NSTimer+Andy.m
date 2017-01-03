//
//  NSTimer+Andy.m
//  SPLICEit
//
//  Created by 李扬 on 2016/12/26.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSTimer+Andy.h"

@implementation NSTimer (Andy)

+ (NSTimer *)andy_timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo handler:(void(^)(void))handler
{
    return [self timerWithTimeInterval:ti target:self selector:@selector(_timerHandler:) userInfo:[handler copy] repeats:yesOrNo];
}

+ (NSTimer *)andy_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo handler:(void(^)(void))handler
{
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(_timerHandler:) userInfo:[handler copy] repeats:yesOrNo];
}

+ (void)_timerHandler:(NSTimer *)inTimer;
{
    if (inTimer.userInfo)
    {
        void(^handler)(void) = [inTimer userInfo];
        handler();
    }
}

@end
