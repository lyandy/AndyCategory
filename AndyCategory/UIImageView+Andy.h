//
//  UIImageView+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Andy)

- (void)andy_setImageWithUrl:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage completion:(void (^)())completion;

- (void)andy_setImageToBlur:(UIImage *)image
       completionBlock:(void (^)())completion;

- (void)andy_setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(void (^)())completion;

@end
