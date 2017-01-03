//
//  NSDictionary+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 2017/1/3.
//  Copyright © 2017年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Andy)

+ (nullable NSDictionary *)andy_dictionaryWithPlistData:(NSData *)plist;

+ (nullable NSDictionary *)andy_dictionaryWithPlistString:(NSString *)plist;

- (nullable NSData *)andy_plistData;

- (nullable NSString *)andy_plistString;

- (NSArray *)andy_allKeysSorted;

- (NSArray *)andy_allValuesSortedByKeys;

- (BOOL)andy_containsObjectForKey:(id)key;

- (NSDictionary *)andy_entriesForKeys:(NSArray *)keys;

- (nullable NSString *)andy_jsonStringEncoded;

- (nullable NSString *)andy_jsonPrettyStringEncoded;

+ (nullable NSDictionary *)andy_dictionaryWithXML:(id)xmlDataOrString;

@end


@interface NSMutableDictionary (Andy)

+ (nullable NSMutableDictionary *)andy_dictionaryWithPlistData:(NSData *)plist;

+ (nullable NSMutableDictionary *)andy_dictionaryWithPlistString:(NSString *)plist;

- (nullable id)andy_popObjectForKey:(id)aKey;

- (NSDictionary *)andy_popEntriesForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END;


