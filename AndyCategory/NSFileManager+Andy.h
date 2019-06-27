//
//  NSFileManager+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 2019/6/27.
//  Copyright © 2019 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Andy)

/** 获得文件的MIMEType */
+ (void)andy_getMIMEType:(NSString*)filepath
            completion:(void (^)(NSString *MIMEType))completion;

/** 将文件名分割成文件名+拓展名 */
+ (void)andy_divideFilename:(NSString *)filename
               completion:(void (^)(NSString *filename, NSString *extension))completion;

/** 获得dir的所有符合extensions拓展名的子路径 */
+ (NSArray *)andy_subpathsAtPath:(NSString *)dir
                    extensions:(NSArray *)extensions;

/** 获得dir的所有子目录 */
+ (NSArray *)andy_subdirsAtPath:(NSString *)dir;

/** 检查某个路径是否存在，如果存在，就生成新的路径名，直到不存在为止 */
+ (NSString *)andy_checkPathExists:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
