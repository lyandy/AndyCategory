//
//  UIImageView+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIImageView+Andy.h"
#import "UIImage+Andy.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Andy)

CGFloat const kAndyBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kAndyBlurredImageDefaultSaturationDeltaFactor = 1.8;

- (void)andy_setImageWithUrl:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage completion:(void (^)())completion
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
        self.image = image ? image : placeHolderImage;
        
        if (completion != nil)
        {
            completion();
        }
    }];
}

- (void)andy_setImageToBlur:(UIImage *)image completionBlock:(void (^)())completion
{
    [self andy_setImageToBlur:image
              blurRadius:kAndyBlurredImageDefaultBlurRadius
         completionBlock:completion];
}

- (void)andy_setImageToBlur:(UIImage *)image blurRadius:(CGFloat)blurRadius completionBlock:(void (^)())completion
{
    blurRadius = (blurRadius <= 0) ? kAndyBlurredImageDefaultBlurRadius : blurRadius;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [image andy_applyBlurWithRadius:blurRadius
                                                 tintColor:nil
                                     saturationDeltaFactor:kAndyBlurredImageDefaultSaturationDeltaFactor
                                                 maskImage:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if (completion) {
                completion();
            }
        });
    });
}

@end
