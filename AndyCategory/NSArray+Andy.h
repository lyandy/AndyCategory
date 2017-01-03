//
//  NSArray+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 2017/1/3.
//  Copyright © 2017年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Andy)

+ (nullable NSArray *)andy_arrayWithPlistData:(NSData * __nullable)plist;

+ (nullable NSArray *)andy_arrayWithPlistString:(NSString * __nullable)plist;

- (nullable NSData *)andy_plistData;

- (nullable NSString *)andy_plistString;

- (nullable id)andy_randomObject;

- (nullable id)andy_objectOrNilAtIndex:(NSUInteger)index;

- (nullable NSString *)andy_jsonStringEncoded;

- (nullable NSString *)andy_jsonPrettyStringEncoded;

@end


@interface NSMutableArray (Andy)

+ (nullable NSMutableArray *)andy_arrayWithPlistData:(NSData * __nullable)plist;

+ (nullable NSMutableArray *)andy_arrayWithPlistString:(NSString * __nullable)plist;

- (void)andy_removeFirstObject;

- (void)andy_removeLastObject;

- (nullable id)andy_popFirstObject;

- (nullable id)andy_popLastObject;

- (void)andy_appendObject:(id __nonnull)anObject;

- (void)andy_prependObject:(id __nonnull)anObject;

- (void)andy_appendObjects:(NSArray * __nonnull)objects;

- (void)andy_prependObjects:(NSArray * __nonnull)objects;

- (void)andy_insertObjects:(NSArray * __nonnull)objects atIndex:(NSUInteger)index;

- (void)andy_reverse;

- (void)andy_shuffle;

@end

