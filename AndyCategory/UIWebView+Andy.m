//
//  UIWebView+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIWebView+Andy.h"

@implementation UIWebView (Andy)

- (void)andy_cleanForDealloc
{
    [self loadHTMLString:@"" baseURL:nil];
    
    [self stopLoading];
    
    self.delegate = nil;
    
    [self removeFromSuperview];
}

@end
