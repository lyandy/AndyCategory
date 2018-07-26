//
//  UILabel+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Andy)

+ (UILabel *)andy_labelWithText:(NSString *)text frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)andy_labelWithText:(NSString *)text fontSize:(NSInteger)fontSize frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)andy_labelWithText:(NSString *)text fontSize:(NSInteger)fontSize textColor:(UIColor *)color frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)andy_roundCornerLabelWithText:(NSString *)text fontSize:(NSInteger)fontSize radius:(CGFloat)radius frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment;

// 计算文字的高度  width:所显示文字显示的最大宽度
+ (CGFloat)andy_getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;

// 计算文字的宽度
+ (CGFloat)andy_getWidthWithTitle:(NSString *)title font:(UIFont *)font;


/**
 *  改变行间距
 */
+ (void)andy_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)andy_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)andy_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
