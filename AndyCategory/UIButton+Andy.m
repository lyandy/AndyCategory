//
//  UIButton+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIButton+Andy.h"
#import "UIImage+Andy.h"
#import <objc/runtime.h>

@implementation UIButton (Andy)

+ (UIButton *)andy_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color frame:(CGRect)frame
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton *)andy_roundCornerbuttonWithTitle:(NSString *)title titleColor:(UIColor *)color frame:(CGRect)frame radius:(CGFloat)radius
{
    
    UIButton *button = [UIButton andy_buttonWithTitle:title titleColor:color frame:frame];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = radius;
    
    return button;
}

+ (UIButton *)andy_buttonWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector
{
    
    UIButton *button = [UIButton andy_buttonWithTitle:nil titleColor:nil frame:frame];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)andy_roundCornerbuttonWithFrame:(CGRect)frame radius:(CGFloat)radius target:(id)target selector:(SEL)selector
{
    
    UIButton *button = [UIButton andy_roundCornerbuttonWithTitle:nil titleColor:nil frame:frame radius:radius];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)andy_setBackGroundColor:(UIColor *)bgColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIImage andy_createImageWithColor:bgColor] forState:state];
}

// 设置normal状态的多语言文本
- (void)andy_setTextNormal:(NSString *)key
{
    [self setTitle:NSLocalizedString(key, nil) forState:UIControlStateNormal];
}

// 设置highlight状态的多语言文本
- (void)andy_setTextHighlight:(NSString *)key
{
    [self setTitle:NSLocalizedString(key, nil) forState:UIControlStateHighlighted];
}

// 设置Selected状态的多语言文本
- (void)andy_setTextSelected:(NSString *)key
{
    [self setTitle:NSLocalizedString(key, nil) forState:UIControlStateSelected];
}

// 设置disable状态的多语言文本
- (void)andy_setTextDisable:(NSString *)key
{
    [self setTitle:NSLocalizedString(key, nil) forState:UIControlStateDisabled];
}

- (void)andy_actionBlock:(AndyButtonActionBlock)actionBlock
{
    [self andy_controlEvents:UIControlEventTouchUpInside withActionBlock:actionBlock];
}

- (void)andy_controlEvents:(UIControlEvents)events withActionBlock:(AndyButtonActionBlock)actionBlock
{
    [self addTarget:self action:@selector(andy_buttonAction:) forControlEvents:events];
    objc_setAssociatedObject(self, @"AndyButtonActionBlockKey", actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)andy_buttonAction:(id)sender {
    AndyButtonActionBlock actionBlock = (AndyButtonActionBlock)objc_getAssociatedObject(sender, @"AndyButtonActionBlockKey");
    if (actionBlock)
    {
        self.enabled = NO;
        actionBlock(sender);
        self.enabled = YES;
    }
}

@end
