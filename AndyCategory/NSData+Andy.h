//
//  NSData+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSData (Andy)

- (nullable NSData *)andy_dataFromImage:(UIImage * __nonnull)image compressionQuality:(CGFloat)compressionQuality;

- (nullable NSData *)andy_aes256_encrypt:(NSString * __nullable)key;
- (nullable NSData *)andy_aes256_decrypt:(NSString * __nullable)key;

/**
 @brief 返回有效的UTF8编码的NSData数据,替换掉无效的编码
 **/
- (nullable NSData *)andy_UTF8Data;

- (nullable NSString *)andy_utf8String;

- (nullable NSString *)andy_base64EncodedString;

+ (nullable NSData *)andy_dataWithBase64EncodedString:(NSString * _Nullable)base64EncodedString;

@end
