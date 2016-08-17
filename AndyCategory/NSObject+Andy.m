//
//  NSObject+Andy.m
//  AndyCategory_Test
//
//  Created by chengshuangshuang on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSObject+Andy.h"
#import <objc/runtime.h>

@implementation NSObject (Andy)

- (NSArray *)andy_properties
{
    unsigned int count;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    objc_property_t *property_t = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++)
    {
        objc_property_t item = property_t[i];
        const char *tmp = property_getName(item);
        [array addObject:[NSString stringWithCString:tmp encoding:NSUTF8StringEncoding]];
    }
    
    return array;
}

- (NSString *)andy_className
{
    return [NSString stringWithUTF8String:class_getName([self class])];
}

@end
