//
//  UIFont+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 2018/9/6.
//  Copyright © 2018年 andyli. All rights reserved.
//

#import "UIFont+Andy.h"

@implementation UIFont (Andy)

+ (nullable UIFont *)andy_fontWithName:(NSString *)fontName size:(CGFloat)fontSize;
{
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (font == nil)
    {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}


@end
