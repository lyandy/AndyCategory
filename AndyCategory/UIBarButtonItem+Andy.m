//
//  UIBarButtonItem+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIBarButtonItem+Andy.h"
#import "UIView+Andy.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (Andy)

static const void *AndyBarButtonItemBlockKey = @"AndyBarButtonItemBlockKey";

+ (instancetype)andy_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.andy_Size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)andy_itemWithImage:(NSString *)image highImage:(NSString *)highImage actionBlock:(void (^)(id sender))actionBlock
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.andy_Size = button.currentBackgroundImage.size;
    [button addTarget:self action:@selector(andy_handleAction:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(button, AndyBarButtonItemBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

    return [[self alloc] initWithCustomView:button];
}

+ (void)andy_handleAction:(id)sender
{
    void (^block)(id) = objc_getAssociatedObject(sender, AndyBarButtonItemBlockKey);
    if (block)
    {
        block(sender);
    }
}

+ (instancetype)andy_itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(void (^)(id))actionBlock
{
    id selfInstance = [[self alloc] initWithTitle:title style:style target:self action:@selector(andy_handleAction:)];
    if (selfInstance)
    {
        objc_setAssociatedObject(selfInstance, AndyBarButtonItemBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return selfInstance;
}

@end
