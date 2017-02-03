//
//  UITextField+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UITextField+Andy.h"
#import <objc/message.h>

@implementation UITextField (Andy)

- (void)andy_setTextL:(NSString *)key
{
    [self setPlaceholder:NSLocalizedString(key, nil)];
}

- (void)setAndy_maxLength:(NSUInteger)andy_maxLength{
    
    /*
     创建关联要使用到Objective-C的运行时函数：objc_setAssociatedObject来把一个对象与另外一个对象进行关联。该函数需要四个参数：源对象，关键字，关联的对象和一个关联策略。当然，此处的关键字和关联策略是需要进一步讨论的。
     ■  关键字是一个void类型的指针。每一个关联的关键字必须是唯一的。通常都是会采用静态变量来作为关键字。
     ■  关联策略表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；还有这种关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。这种关联策略是通过使用预先定义好的常量来表示的。
     */
    objc_setAssociatedObject(self, @"AndyLimitMaxLengthKey", @(andy_maxLength), OBJC_ASSOCIATION_COPY);
    
    
    if (andy_maxLength > 0)
    {
        [self addTarget:self action:@selector(andy_valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    }
    else
    {
        [self removeTarget:self action:@selector(andy_valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    }
    
}

//动态绑定
- (NSUInteger)andy_maxLength
{
    return [objc_getAssociatedObject(self, @"AndyLimitMaxLengthKey") unsignedIntegerValue];
}

#pragma mark - private
- (void)andy_valueChanged:(UITextField *)textField
{
    if (self.andy_maxLength == 0)
    {
        return;
    }
    
    NSUInteger currentLength = [textField.text length];
    if (currentLength <= self.andy_maxLength)
    {
        return;
    }
    //主线程中进行操作
    NSString *subString = [textField.text substringToIndex:self.andy_maxLength];
    dispatch_async(dispatch_get_main_queue(), ^{
        textField.text = subString;
        /*
         - (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
         - (void)sendActionsForControlEvents:(UIControlEvents)controlEvents;
         事件与操作的区别：事件报告对屏幕的触摸；操作报告对控件的操纵。
         */
        [textField sendActionsForControlEvents:UIControlEventEditingChanged];
    });
}

@end
