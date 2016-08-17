//
//  UILabel+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UILabel+Andy.h"

@implementation UILabel (Andy)

+ (UILabel *)andy_labelWithText:(NSString *)text fontSize:(NSInteger)fontSize textColor:(UIColor *)color frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    if (fontSize)
    {
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    label.textColor = color;
    label.textAlignment = textAlignment;
    
    return label;
}


+ (UILabel *)andy_labelWithText:(NSString *)text fontSize:(NSInteger)fontSize frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment
{
    
    UILabel *label = [UILabel andy_labelWithText:text fontSize:fontSize textColor:nil frame:frame textAlignment:textAlignment];
    
    return label;
}

+ (UILabel *)andy_labelWithText:(NSString *)text frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment
{
    
    UILabel *label = [UILabel andy_labelWithText:text fontSize:0 frame:frame textAlignment:textAlignment];
    
    return label;
}

+ (UILabel *)andy_roundCornerLabelWithText:(NSString *)text fontSize:(NSInteger)fontSize radius:(CGFloat)radius frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment
{
    
    UILabel *label = [UILabel andy_labelWithText:text fontSize:fontSize frame:frame textAlignment:textAlignment];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = radius;
    
    return label;
}

- (void)andy_setTextL:(NSString *)key
{
    [self setText:NSLocalizedString(key, nil)];
}

+ (CGFloat)andy_getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    label.attributedText = attributedString;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)andy_getWidthWithTitle:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    label.attributedText = attributedString;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

@end
