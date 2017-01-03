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

- (NSData *)andy_dataFromImage:(UIImage *)image compressionQuality:(CGFloat)compressionQuality;

- (NSData *)andy_aes256_encrypt:(NSString *)key;
- (NSData *)andy_aes256_decrypt:(NSString *)key;

/**
 @brief 返回有效的UTF8编码的NSData数据,替换掉无效的编码
 **/
- (NSData *)andy_UTF8Data;

@end
