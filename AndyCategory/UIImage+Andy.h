//
//  UIImage+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Andy)

/**
 * 圆形图片
 */
- (UIImage *)andy_circleImage;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)andy_resizedImageWithName:(NSString *)name;
+ (UIImage *)andy_resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)andy_scaleImage:(UIImage *)image toScale:(float)scaleSize;
+ (UIImage *)andy_scaleImage:(UIImage *)image toSize:(CGSize)targetSize;
+ (UIImage *)andy_reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
+ (UIImage *)andy_combineImage:(UIImage *)image1 toImage:(UIImage *)image2;
+ (UIImage *)andy_combineImage:(UIImage *)image1 toImage:(UIImage *)image2 image1Offset:(CGPoint)offset;
+ (UIImage*)andy_getImageWithContentFile:(NSString*)fileName;

+ (UIImage *)andy_normalResImageWithUrl:(NSURL *)url WithinSize:(CGFloat)maxInSize;

+ (UIImage*)andy_createImageWithColor:(UIColor*) color;

-(UIImage*)andy_tintedImageWithColor:(UIColor*)color;
-(UIImage*)andy_tintedImageWithColor:(UIColor*)color level:(CGFloat)level;
-(UIImage*)andy_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage*)andy_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level;
-(UIImage*)andy_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage*)andy_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level;

-(UIImage*)andy_lightenWithLevel:(CGFloat)level;
-(UIImage*)andy_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)andy_lightenRect:(CGRect)rect withLevel:(CGFloat)level;

-(UIImage*)andy_darkenWithLevel:(CGFloat)level;
-(UIImage*)andy_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
-(UIImage*)andy_darkenRect:(CGRect)rect withLevel:(CGFloat)level;

+ (UIImage *)andy_imageResourceNamed:(NSString *)name ofType:(NSString *)type;
+ (UIImage *)andy_imageWithView:(UIView*)view;    // UIView转UIImage
+ (UIImage *)andy_imageWithView:(UIView*)view withRect:(CGRect)rect;

- (UIImage *)andy_imageInRect:(CGRect)rect;   //截取部分图像
- (UIImage *)andy_imageWithScale:(CGFloat)scale;   //按比例缩放
- (UIImage *)andy_imageFitSize:(CGSize)size;   //按比例缩放适应指定大小
- (UIImage *)andy_imageSquare;   //获取四方图
- (UIImage *)andy_imageRotatedByRadians:(CGFloat)radians;    //旋转图像多少弧度
- (UIImage *)andy_imageRotatedByDegrees:(CGFloat)degrees;    //旋转图像多少度
- (UIImage *)andy_imageWithMask:(UIImage *)maskImage;        //遮罩合成新图片
- (UIImage *)andy_imageWithImage:(UIImage *)image;           //合成新图片

// 灰度效果
- (UIImage *)andy_grayScale;

// 平均的颜色
- (UIColor *)andy_averageColor;

// 模糊效果(渲染很耗时间,建议在子线程中渲染)
- (UIImage *)andy_blurImage;
- (UIImage *)andy_blurImageWithMask:(UIImage *)maskImage;
- (UIImage *)andy_blurImageWithRadius:(CGFloat)radius;
- (UIImage *)andy_blurImageAtFrame:(CGRect)frame;

@end
