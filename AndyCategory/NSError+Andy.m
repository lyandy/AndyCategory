//
//  NSError+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSError+Andy.h"

@implementation NSError (Andy)

- (BOOL)andy_isURLError
{
    return [self.domain isEqualToString:NSURLErrorDomain];
}

@end
