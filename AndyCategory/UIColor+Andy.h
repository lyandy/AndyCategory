//
//  UIColor+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Andy)

/** 支持@“#fff”、 @“#ffff”、 @“#ffffff”、@“#ffffffff” 和不带'#'的八种格式 */
+ (UIColor *)andy_colorWithHexString:(NSString *)hex;

/** 支持@“#fff”、 @“#ffff”、 @“#ffffff”、@“#ffffffff” 和不带'#'的八种格式 */
+ (UIColor *)andy_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/** 转为十六进制表示(如：#FFFFFFFF) */
- (NSString *)andy_hexString;

+ (UIColor *)andy_randomColor;
@end
