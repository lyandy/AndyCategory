//
//  NSObject+Andy.h
//  AndyCategory_Test
//
//  Created by chengshuangshuang on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Andy)

// 获取当前对象的所有属性
- (NSArray *)andy_properties;

// 获取当前对象的类名
- (NSString *)andy_className;

@end
