//
//  UIImageView+Andy.m
//  AndyCategory_Example
//
//  Created by 李扬 on 2018/2/13.
//  Copyright © 2018年 403760530@qq.com. All rights reserved.
//

#import "UIImageView+Andy.h"

@implementation UIImageView (Andy)

static NSString * const ROTATE_ANIMATION_KEY = @"Rotate_Animation_Key";

- (void)andy_startRotateCover {
    //1.判断self.layer上是否添加了动画
    CAAnimation *animation = [self.layer animationForKey:ROTATE_ANIMATION_KEY];
    
    if (animation) {
        //如果动画停止了，启动动画
        if (self.layer.speed == 0) {
            //恢复动画
            [self resumeAnimation];
        }
    } else {
        //如果没有添加动画，则添加旋转动画
        [self addAnimation];
    }
}

- (void)andy_stopRotateCover {
    
    //1.判断self.layer上是否添加了动画
    CAAnimation *animation = [self.layer animationForKey:ROTATE_ANIMATION_KEY];
    
    if (animation) {
        //如果动画正在进行，停止动画
        if (self.layer.speed != 0) {
            //恢复动画
            [self pauseAnimation];
        }
    }
}

//恢复动画
- (void)resumeAnimation {
    
    //1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = self.layer.timeOffset;
    
    //2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    [self.layer setTimeOffset:0];
    [self.layer setBeginTime:begin];
    
    self.layer.speed = 1;
}

//暂停动画
- (void)pauseAnimation {
    
    //（0-5）
    //开始时间：0
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    self.layer.timeOffset = pauseTime;
    
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    self.layer.speed = 0;
}

- (void)addAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.byValue = @(M_PI/4);
    animation.duration = 2;
    animation.repeatCount = HUGE_VALF;
    animation.cumulative = YES;
    
    [self.layer addAnimation:animation forKey:ROTATE_ANIMATION_KEY];
}

@end
