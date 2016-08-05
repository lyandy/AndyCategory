//
//  UIViewController+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIViewController+Andy.h"

@implementation UIViewController (Andy)

- (UINavigationController *)andy_selfNavigationViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter)
    {
        if ([iter isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)iter;
        }
        else if (iter.parentViewController && iter.parentViewController != iter)
        {
            iter = iter.parentViewController;
        }
        else
        {
            iter = nil;
        }
    }
    return nil;
}

- (void)andy_setTextL:(NSString *)key
{
    [self setTitle:NSLocalizedString(key, nil)];
}

@end
