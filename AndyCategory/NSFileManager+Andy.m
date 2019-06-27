//
//  NSFileManager+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 2019/6/27.
//  Copyright © 2019 andyli. All rights reserved.
//

#import "NSFileManager+Andy.h"

@implementation NSFileManager (Andy)

+ (void)andy_getMIMEType:(NSString*)filepath
            completion:(void (^)(NSString *))completion
{
    if (filepath.andy_stringByRemovingSpace.length == 0 || !completion) return;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL fileURLWithPath:filepath]
                                 completionHandler:^(NSData * _Nullable data,
                                                     NSURLResponse * _Nullable response,
                                                     NSError * _Nullable error) {
                                     completion(response.MIMEType);
                                 }] resume];
}

+ (void)andy_divideFilename:(NSString *)filename
               completion:(void (^)(NSString *, NSString *))completion
{
    if (filename.andy_stringByRemovingSpace.length == 0 || !completion) return;
    
    // 新的文件名
    NSMutableString *destFilename = [NSMutableString stringWithString:filename];
    NSString *pathExtension = filename.pathExtension;
    if (pathExtension.length) {
        pathExtension = [@"." stringByAppendingString:pathExtension];
    }
    NSRange range = [destFilename rangeOfString:pathExtension];
    if (range.location != NSNotFound) {
        [destFilename deleteCharactersInRange:range];
    }
    completion(destFilename, pathExtension);
}

+ (NSArray *)andy_subpathsAtPath:(NSString *)dir
                    extensions:(NSArray *)extensions
{
    if (dir.andy_stringByRemovingSpace.length == 0) return nil;
    
    NSArray *oldSubpaths = [[NSFileManager defaultManager] subpathsAtPath:dir];
    if (extensions.count == 0) return oldSubpaths;
    
    NSMutableArray *subpaths = [NSMutableArray array];
    for (NSString *subpath in oldSubpaths) {
        if ([extensions containsObject:subpath.pathExtension]) {
            [subpaths addObject:[dir stringByAppendingPathComponent:subpath]];
        }
    }
    return subpaths;
}

+ (NSArray *)andy_subdirsAtPath:(NSString *)dir
{
    if (dir.length == 0) return nil;
    
    NSMutableArray *subdirs = [NSMutableArray array];
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *subpaths = [mgr subpathsAtPath:dir];
    for (NSString *subpath in subpaths) {
        BOOL isDir;
        NSString *path = [dir stringByAppendingPathComponent:subpath];
        [mgr fileExistsAtPath:path isDirectory:&isDir];
        if (!isDir) continue;
        [subdirs addObject:path];
    }
    
    return subdirs;
}

+ (NSString *)andy_checkPathExists:(NSString *)path
{
    if (path.length == 0) return nil;
    
    __block NSString *filepath = path;
    NSFileManager *mgr = [NSFileManager defaultManager];
    while ([mgr fileExistsAtPath:filepath]) {
        [NSFileManager andy_divideFilename:filepath completion:^(NSString *filename, NSString *extension) {
            filepath = [NSString stringWithFormat:@"%@2%@", filename, extension];
        }];
    }
    return filepath;
}

@end
