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

@end
