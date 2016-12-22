//
//  UIColor+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIColor+Andy.h"

@implementation UIColor (Andy)


+ (UIColor *)andy_colorWithHexString:(NSString *)hex
{
    return [self andy_colorWithHexString:hex hasAlpha:NO alpha:NO];
}

+ (UIColor *)andy_colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha
{
    return [self andy_colorWithHexString:hex hasAlpha:YES alpha:alpha];
}

+ (UIColor *)andy_colorWithHexString:(NSString *)hex hasAlpha:(BOOL)hasAlpha alpha:(CGFloat)alpha
{
    if (!hex) return nil;
    
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    }
    
    NSString *rStr = nil, *gStr = nil, *bStr = nil, *aStr = nil;
    
    if (hex.length == 3) {
        rStr = [hex substringWithRange:NSMakeRange(0, 1)];
        rStr = [NSString stringWithFormat:@"%@%@", rStr, rStr];
        gStr = [hex substringWithRange:NSMakeRange(1, 1)];
        gStr = [NSString stringWithFormat:@"%@%@", gStr, gStr];
        bStr = [hex substringWithRange:NSMakeRange(2, 1)];
        bStr = [NSString stringWithFormat:@"%@%@", bStr, bStr];
        aStr = @"FF";
    } else if (hex.length == 4) {
        rStr = [hex substringWithRange:NSMakeRange(0, 1)];
        rStr = [NSString stringWithFormat:@"%@%@", rStr, rStr];
        gStr = [hex substringWithRange:NSMakeRange(1, 1)];
        gStr = [NSString stringWithFormat:@"%@%@", gStr, gStr];
        bStr = [hex substringWithRange:NSMakeRange(2, 1)];
        bStr = [NSString stringWithFormat:@"%@%@", bStr, bStr];
        aStr = [hex substringWithRange:NSMakeRange(3, 1)];
        aStr = [NSString stringWithFormat:@"%@%@", aStr, aStr];
    } else if (hex.length == 6) {
        rStr = [hex substringWithRange:NSMakeRange(0, 2)];
        gStr = [hex substringWithRange:NSMakeRange(2, 2)];
        bStr = [hex substringWithRange:NSMakeRange(4, 2)];
        aStr = @"FF";
    } else if (hex.length == 8) {
        rStr = [hex substringWithRange:NSMakeRange(0, 2)];
        gStr = [hex substringWithRange:NSMakeRange(2, 2)];
        bStr = [hex substringWithRange:NSMakeRange(4, 2)];
        aStr = [hex substringWithRange:NSMakeRange(6, 2)];
    } else {
        // Unknown encoding
        return [UIColor clearColor];
    }
    
    unsigned r, g, b, a;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    [[NSScanner scannerWithString:aStr] scanHexInt:&a];
    
    if (hasAlpha) {
        a = alpha * 255.0f;
    }
    
    if (r == g && g == b) {
        // Optimal case for grayscale
        return [UIColor colorWithWhite:(((CGFloat)r)/255.0f) alpha:(((CGFloat)a)/255.0f)];
    } else {
        return [UIColor colorWithRed:(((CGFloat)r)/255.0f) green:(((CGFloat)g)/255.0f) blue:(((CGFloat)b)/255.0f) alpha:(((CGFloat)a)/255.0f)];
    }
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

+ (UIColor *)andy_randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
