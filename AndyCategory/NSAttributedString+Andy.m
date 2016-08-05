//
//  NSAttributedString+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSAttributedString+Andy.h"
#import <UIKit/UIKit.h>

@implementation NSAttributedString (Andy)

- (NSAttributedString *)andy_adjustlineSpace:(float)space {
    NSMutableAttributedString *attribute  = [[NSMutableAttributedString alloc]initWithAttributedString:self];//创建一个可变属性文本对象
    NSMutableParagraphStyle *paragraph =[[NSMutableParagraphStyle alloc]init];//创建一个段落对象
    [paragraph setLineSpacing:space];//设置段落属性
    [paragraph setLineBreakMode:NSLineBreakByTruncatingTail];
    [attribute addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];//为属性文本添加属性
    return attribute;
}

@end
