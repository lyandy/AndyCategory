//
//  UIBarButtonItem+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Andy)

+ (instancetype)andy_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

+ (instancetype)andy_itemWithImage:(NSString *)image highImage:(NSString *)highImage actionBlock:(void (^)(id sender))actionBlock;

+ (instancetype)andy_itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(void (^)(id sender))actionBlock;

@end
