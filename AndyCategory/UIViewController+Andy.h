//
//  UIViewController+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Andy)

- (UINavigationController *)andy_selfNavigationViewController;

// 设置多语言文本
- (void)andy_setTextL:(NSString *)key;

@end
