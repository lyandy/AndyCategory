//
//  UITextField+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UITextField+Andy.h"

@implementation UITextField (Andy)

- (void)andy_setTextL:(NSString *)key
{
    [self setPlaceholder:NSLocalizedString(key, nil)];
}

@end
