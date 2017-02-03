//
//  UITextField+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Andy)

- (void)andy_setTextL:(NSString *)key;

@property (assign,nonatomic) NSUInteger andy_maxLength;

@end
