//
//  NSObject+Andy.h
//  AndyCategory_Test
//
//  Created by chengshuangshuang on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Andy)

// 获取当前对象的所有属性
- (NSArray *)andy_properties;

+ (NSString *)andy_className;

// 获取当前对象的类名
- (NSString *)andy_className;

- (instancetype)andy_performSelector:(SEL)selector withObjects:(NSArray *)objects;

- (UIViewController *)andy_topViewController;

/**
 @brief 添加一个block,当该对象释放时被调用
 **/
- (void)andy_guardDeallocBlock:(void(^)(void))block;


-(NSString *)andy_appVersion;

-(NSInteger)andy_integerAppBuild;

-(NSString *)andy_stringAppBuild;

-(NSString *)andy_appIdentifier;

-(NSString *)andy_appCurrentLanguage;

- (NSData *)andy_JSONDataSerialization;
- (NSString *)andy_JSONStringSerialization;
- (NSString *)andy_JSONStringSerializationPrinted:(BOOL)isPretined;


@end
