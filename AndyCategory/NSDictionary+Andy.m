//
//  NSDictionary+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 2017/1/3.
//  Copyright © 2017年 andyli. All rights reserved.
//

#import "NSDictionary+Andy.h"
#import "NSString+Andy.h"
#import "NSData+Andy.h"

@implementation NSDictionary (Andy)

+ (NSDictionary *)andy_dictionaryWithPlistData:(NSData *)plist
{
    if (plist == nil)
    {
        return nil;
    }
    else
    {
        NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
        if ([dictionary isKindOfClass:[NSDictionary class]])
        {
            return dictionary;
        }
        else
        {
            return nil;
        }
    }
}

+ (NSDictionary *)andy_dictionaryWithPlistString:(NSString *)plist
{
    if (plist == nil)
    {
        return nil;
    }
    else
    {
        NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
        return [self andy_dictionaryWithPlistData:data];
    }
}

- (NSData *)andy_plistData
{
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)andy_plistString
{
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData != nil)
    {
        return xmlData.andy_utf8String;
    }
    else
    {
        return nil;
    }
}

- (NSArray *)andy_allKeysSorted
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)andy_allValuesSortedByKeys
{
    NSArray *sortedKeys = [self andy_allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys)
    {
        [arr addObject:self[key]];
    }
    return arr;
}

- (BOOL)andy_containsObjectForKey:(id)key
{
    if (key == nil)
    {
        return NO;
    }
    else
    {
        return self[key] != nil;
    }
}

- (NSDictionary *)andy_entriesForKeys:(NSArray *)keys
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys)
    {
        id value = self[key];
        if (value != nil)
        {
            dic[key] = value;
        }
    }
    return dic;
}

- (NSString *)andy_jsonStringEncoded
{
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    else
    {
        return nil;
    }
}

- (NSString *)andy_jsonPrettyStringEncoded
{
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    else
    {
        return nil;
    }
}

- (NSString *)urlEncodeWithString:(NSString *)str
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 kCFAllocatorDefault,
                                                                                 (CFStringRef)str, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
                                                                                 kCFStringEncodingUTF8));
}

- (NSString *)andy_urlEncodedKeyValueString
{
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in self)
    {
        NSObject *value = [self valueForKey:key];
        if([value isKindOfClass:[NSString class]])
        {
            [string appendFormat:@"%@=%@&", [self urlEncodeWithString:key], [self urlEncodeWithString:(NSString *)value]];
        }
        else
        {
            [string appendFormat:@"%@=%@&", [self urlEncodeWithString:key], value];
        }
    }
    
    if([string length] > 0)
    {
        [string deleteCharactersInRange:NSMakeRange([string length] - 1, 1)];
    }
    
    return string;
}

- (NSString *)andy_jsonEncodedKeyValueString
{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (NSString *)andy_plistEncodedKeyValueString
{
    NSError *error = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end


@implementation NSMutableDictionary (Andy)

+ (NSMutableDictionary *)andy_dictionaryWithPlistData:(NSData *)plist
{
    if (plist == nil)
    {
        return nil;
    }
    else
    {
        NSMutableDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
        if ([dictionary isKindOfClass:[NSMutableDictionary class]])
        {
            return dictionary;
        }
        else
        {
            return nil;
        }
    }
}

+ (NSMutableDictionary *)andy_dictionaryWithPlistString:(NSString *)plist
{
    if (plist == nil)
    {
        return nil;
    }
    else
    {
        NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
        return [self andy_dictionaryWithPlistData:data];
    }
}

- (id)andy_popObjectForKey:(id)aKey
{
    if (aKey == nil)
    {
        return nil;
    }
    else
    {
        id value = self[aKey];
        [self removeObjectForKey:aKey];
        return value;
    }
}

- (NSDictionary *)andy_popEntriesForKeys:(NSArray *)keys
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys)
    {
        id value = self[key];
        if (value != nil)
        {
            [self removeObjectForKey:key];
            dic[key] = value;
        }
    }
    return dic;
}

@end

