//
//  NSFileManager+Andy.m
//  SPLICEit
//
//  Created by 李扬 on 2016/12/26.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSFileManager+Andy.h"
#import <sys/stat.h>

@implementation NSFileManager (Andy)

- (uint64_t)andy_fileSizeAtPath:(NSString *)filePath
{
    return [self sizeAtPath:filePath diskMode:NO];
}

- (uint64_t)andy_diskSizeAtPath:(NSString *)filePath
{
    return [self sizeAtPath:filePath diskMode:YES];
}

- (uint64_t)sizeAtPath:(NSString *)filePath diskMode:(BOOL)diskMode
{
    uint64_t totalSize = 0;
    
    NSMutableArray *searchPaths = [NSMutableArray arrayWithObject:filePath];
    while ([searchPaths count] > 0)
    {
        @autoreleasepool
        {
            NSString *fullPath = [searchPaths objectAtIndex:0];
            [searchPaths removeObjectAtIndex:0];
            
            struct stat fileStat;
            if (lstat([fullPath fileSystemRepresentation], &fileStat) == 0)
            {
                if (fileStat.st_mode & S_IFDIR)
                {
                    NSArray *childSubPaths = [self contentsOfDirectoryAtPath:fullPath error:nil];
                    for (NSString *childItem in childSubPaths)
                    {
                        NSString *childPath = [fullPath stringByAppendingPathComponent:childItem];
                        [searchPaths insertObject:childPath atIndex:0];
                    }
                }else
                {
                    if (diskMode)
                        totalSize += fileStat.st_blocks*512;
                    else
                        totalSize += fileStat.st_size;
                }
            }
        }
    }
    
    return totalSize;
}

#pragma mark -

- (BOOL)andy_isAlias:(NSString *)aliasPath
{
    NSURL *aliasURL = [NSURL fileURLWithPath:aliasPath];
    if (!aliasURL)
        return NO;
    
    NSString *fileType = nil;
    BOOL status = [aliasURL getResourceValue:&fileType forKey:NSURLFileResourceTypeKey error:NULL];
    if (!status || !fileType || ![fileType isEqualToString:NSURLFileResourceTypeRegular])
        return NO;
    
    NSNumber *aliasValue = nil;
    status = [aliasURL getResourceValue:&aliasValue forKey:NSURLIsAliasFileKey error:NULL];
    if (!status || !aliasValue)
        return NO;
    
    return [aliasValue boolValue];
}

- (NSString *)andy_resolvingAlias:(NSString *)aliasPath
{
    NSURL *aliasURL = [NSURL fileURLWithPath:aliasPath];
    if (!aliasURL)
        return nil;
    
    NSData *aliasData = [NSURL bookmarkDataWithContentsOfURL:aliasURL error:NULL];
    if (!aliasData)
        return nil;
    
    /*
     NSURLBookmarkResolutionWithoutUI 如果原文件是需要挂载的磁盘,挂载的过程中不显示UI
     NSURLBookmarkResolutionWithoutMounting 如果原文件在一个未挂载的磁盘,则不必挂载,但会返回NULL
     NSURLBookmarkResolutionWithSecurityScope 适用于沙盒下使用替身文件(创建时指定了NSURLBookmarkCreationWithSecurityScope)
     */
    BOOL stale = NO;
    NSURL *originalURL = [NSURL URLByResolvingBookmarkData:aliasData
                                                   options:NSURLBookmarkResolutionWithoutUI
                                             relativeToURL:nil
                                       bookmarkDataIsStale:&stale
                                                     error:NULL];
    if (!originalURL)
        return nil;
    
    return [originalURL path];
}

- (BOOL)andy_createAlias:(NSString *)aliasPath fromPath:(NSString *)originalPath
{
    NSURL *aliasURL = [NSURL fileURLWithPath:aliasPath];
    if (!aliasURL)
        return NO;
    
    NSURL *originalURL = [NSURL fileURLWithPath:originalPath];
    if (!originalURL)
        return NO;
    
    NSURLBookmarkCreationOptions createOptions = NSURLBookmarkCreationSuitableForBookmarkFile;
    NSData *aliasData = [originalURL bookmarkDataWithOptions:createOptions
                              includingResourceValuesForKeys:nil
                                               relativeToURL:nil
                                                       error:NULL];
    if (!aliasData)
        return NO;
    
    return [NSURL writeBookmarkData:aliasData
                              toURL:aliasURL
                            options:createOptions
                              error:NULL];
}


@end
