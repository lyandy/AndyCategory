//
//  UIImageView+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIImageView+Andy.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Andy)

- (void)andy_setImageWithUrl:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage completion:(void (^)())completion
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? image : placeHolderImage;
        
        if (completion != nil)
        {
            completion();
        }
    }];
}

@end
