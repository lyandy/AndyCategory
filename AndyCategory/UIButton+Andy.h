//
//  UIButton+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AndyButtonActionBlock)(id);

@interface UIButton (Andy)

+ (UIButton *)andy_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color frame:(CGRect)frame;

+ (UIButton *)andy_roundCornerbuttonWithTitle:(NSString *)title titleColor:(UIColor *)color frame:(CGRect)frame radius:(CGFloat)radius;

+ (UIButton *)andy_buttonWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector;

+ (UIButton *)andy_roundCornerbuttonWithFrame:(CGRect)frame radius:(CGFloat)radius target:(id)target selector:(SEL)selector;

- (void)andy_setBackGroundColor:(UIColor *)bgColor forState:(UIControlState)state;

// 设置normal状态的多语言文本
- (void)andy_setTextNormal:(NSString *)key;

// 设置highlight状态的多语言文本
- (void)andy_setTextHighlight:(NSString *)key;

// 设置Selected状态的多语言文本
- (void)andy_setTextSelected:(NSString *)key;

// 设置disable状态的多语言文本
- (void)andy_setTextDisable:(NSString *)key;

/**
 *  @brief  给按钮加上click事件
 *
 *  @param action 当按钮click时要执行的block。
 */
- (void)andy_actionBlock:(AndyButtonActionBlock)actionBlock;

/**
 *  @brief 给按钮加上block事件
 *
 *  @param events 要响应的事件
 *  @param action 当events触发时，要执行的block
 */
- (void)andy_controlEvents:(UIControlEvents)events withActionBlock:(AndyButtonActionBlock)actionBlock;

@end
