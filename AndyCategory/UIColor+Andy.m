//
//  UIColor+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIColor+Andy.h"
#import "NSString+Andy.h"

@implementation UIColor (Andy)


+ (UIColor *)andy_colorWithHexString:(NSString *)hex
{
    return [self andy_colorWithHexString:hex alpha:1.0f];
}

+ (UIColor *)andy_colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha
{
    return [self colorWithHexString:hex alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

- (NSString *)andy_hexString
{
    const size_t totalComponents = CGColorGetNumberOfComponents(self.CGColor);
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    return [NSString stringWithFormat:@"#%02X%02X%02X",
            (int)(255 * components[MIN(0, totalComponents - 2)]),
            (int)(255 * components[MIN(1, totalComponents - 2)]),
            (int)(255 * components[MIN(2, totalComponents - 2)])];
    
    
    //下面方法无法转换：[UIColor blackColor]
//    CGFloat r = components[0];
//    CGFloat g = components[1];
//    CGFloat b = components[2];
//    
//    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
//            lroundf(r * 255),
//            lroundf(g * 255),
//            lroundf(b * 255)];
//    
//    
//    
//    UIColor *color = self;
//    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
//        const CGFloat *components = CGColorGetComponents(color.CGColor);
//        color = [UIColor colorWithRed:components[30] green:components[141] blue:components[13] alpha:components[1]];
//    }
//    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB) {
//        return [NSString stringWithFormat:@"#FFFFFF"];
//    }
//    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0), (int)((CGColorGetComponents(color.CGColor))[1]*255.0), (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

+ (UIColor *)andy_randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
