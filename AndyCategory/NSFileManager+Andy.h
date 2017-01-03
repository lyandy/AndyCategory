//
//  NSFileManager+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 2016/12/26.
//  Copyright © 2016年 andyshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Andy)

/*
 快速计算文件/目录的size
 返回实际的byte数
 */
- (uint64_t)andy_fileSizeAtPath:(NSString *)filePath;

/*
 快速计算文件/目录的size
 返回占用磁盘空间
 */
- (uint64_t)andy_diskSizeAtPath:(NSString *)filePath;

/*
 返回是否为替身文件
 */
- (BOOL)andy_isAlias:(NSString *)aliasPath;

/*
 返回替身文件的原身
 */
- (NSString *)andy_resolvingAlias:(NSString *)aliasPath;

/*
 创建替身文件
 */
- (BOOL)andy_createAlias:(NSString *)aliasPath fromPath:(NSString *)originalPath;

@end
