//
//  UIImage+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AndyCenterImageType) {
    // 方形
    AndyCenterImageTypeSquare,
    // 圆形
    AndyCenterImageTypeCircle,
    // 切圆角
    AndyCenterImageTypeCornorRadious
};

typedef NS_ENUM(NSUInteger, AndyQRImageType) {
    // 方形
    AndyQRImageTypeSquare,
    // 圆形
    AndyQRImageTypeCircle,
    // 切圆角
    AndyQRImageTypeCornorRadious
};

@interface UIImage (Andy)

/**
 * 圆形图片
 */
- (UIImage  * _Nullable )andy_circleImage;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage * _Nullable)andy_resizedImageWithName:(NSString * _Nonnull)name;
+ (UIImage * _Nullable)andy_resizedImageWithName:(NSString * _Nonnull)name left:(CGFloat)left top:(CGFloat)top;

+ (UIImage  * _Nullable )andy_scaleImage:(UIImage * _Nonnull)image toScale:(float)scaleSize;
+ (UIImage  * _Nullable )andy_scaleImage:(UIImage * _Nonnull)image toSize:(CGSize)targetSize;
+ (UIImage  * _Nullable )andy_reSizeImage:(UIImage * _Nonnull)image toSize:(CGSize)reSize;
+ (UIImage  * _Nullable )andy_combineImage:(UIImage * _Nonnull)image1 toImage:(UIImage * _Nonnull)image2;
+ (UIImage  * _Nullable )andy_combineImage:(UIImage * _Nonnull)image1 toImage:(UIImage * _Nonnull)image2 image1Offset:(CGPoint)offset;
+ (UIImage  * _Nullable )andy_getImageWithContentFile:(NSString * _Nonnull)fileName;

/** 根据最大宽高重设图片大小 */
+ (UIImage  * _Nullable )andy_reSizeImage:(UIImage * _Nonnull)image maxEdge:(CGFloat)maxEdge;

/** 根据最小宽高重设图片大小 */
+ (UIImage  * _Nullable )andy_reSizeImage:(UIImage * _Nonnull)image minEdge:(CGFloat)minEdge;

+ (UIImage  * _Nullable )andy_normalResImageWithUrl:(NSURL * _Nonnull)url WithinSize:(CGFloat)maxInSize;

+ (UIImage  * _Nullable )andy_createImageWithColor:(UIColor * _Nonnull)color;

- (UIImage  * _Nullable )andy_tintedImageWithColor:(UIColor * _Nonnull)color;
- (UIImage  * _Nullable )andy_tintedImageWithColor:(UIColor * _Nonnull)color level:(CGFloat)level;
- (UIImage  * _Nullable )andy_tintedImageWithColor:(UIColor * _Nonnull)color rect:(CGRect)rect;
- (UIImage  * _Nullable )andy_tintedImageWithColor:(UIColor * _Nonnull)color rect:(CGRect)rect level:(CGFloat)level;
- (UIImage  * _Nullable )andy_tintedImageWithColor:(UIColor * _Nonnull)color insets:(UIEdgeInsets)insets;
- (UIImage  * _Nullable )andy_tintedImageWithColor:(UIColor * _Nonnull)color insets:(UIEdgeInsets)insets level:(CGFloat)level;

- (UIImage  * _Nullable )andy_lightenWithLevel:(CGFloat)level;
- (UIImage  * _Nullable )andy_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
- (UIImage  * _Nullable )andy_lightenRect:(CGRect)rect withLevel:(CGFloat)level;

- (UIImage  * _Nullable )andy_darkenWithLevel:(CGFloat)level;
- (UIImage  * _Nullable )andy_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets;
- (UIImage  * _Nullable )andy_darkenRect:(CGRect)rect withLevel:(CGFloat)level;

+ (UIImage  * _Nullable )andy_imageResourceNamed:(NSString * _Nonnull)name ofType:(NSString * _Nonnull)type;
+ (UIImage  * _Nullable )andy_imageWithView:(UIView * _Nonnull)view;    // UIView转UIImage
+ (void)andy_imageWithViewAsync:(UIView * _Nonnull)view complete:(void (^ _Nullable)(UIImage * _Nullable image))complete;


+ (UIImage  * _Nullable )andy_imageWithView:(UIView * _Nonnull)view withRect:(CGRect)rect;

- (UIImage  * _Nullable )andy_imageInRect:(CGRect)rect;   //截取部分图像
- (UIImage  * _Nullable )andy_imageWithScale:(CGFloat)scale;   //按比例缩放
- (UIImage  * _Nullable )andy_imageFitSize:(CGSize)size;   //按比例缩放适应指定大小
- (UIImage  * _Nullable )andy_imageSquare;   //获取四方图
- (UIImage  * _Nullable )andy_imageRotatedByRadians:(CGFloat)radians;    //旋转图像多少弧度
- (UIImage  * _Nullable )andy_imageRotatedByDegrees:(CGFloat)degrees;    //旋转图像多少度
- (UIImage  * _Nullable )andy_imageWithMask:(UIImage * _Nonnull)maskImage;        //遮罩合成新图片
- (UIImage  * _Nullable )andy_imageWithImage:(UIImage * _Nonnull)image;           //合成新图片

// 灰度效果
- (UIImage  * _Nullable )andy_grayScale;

// 平均的颜色
- (UIColor * _Nonnull)andy_averageColor;

// 模糊效果(渲染很耗时间,建议在子线程中渲染)
- (UIImage  * _Nullable )andy_blurImage;
- (UIImage  * _Nullable )andy_blurImageWithMask:(UIImage * _Nonnull)maskImage;
- (UIImage  * _Nullable )andy_blurImageWithRadius:(CGFloat)radius;
- (UIImage  * _Nullable )andy_blurImageAtFrame:(CGRect)frame;

- (UIImage * _Nullable)andy_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor * _Nullable)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage * _Nullable)maskImage;

//保存到相册
- (void)saveToCameraRoll:(nullable void(^)(BOOL success, NSError *__nullable error))completionHandler;

#pragma mark - 生成原始二维码
+ (void)andy_qrImageWithString:(NSString * __nullable)string size:(CGSize)size completion:(nonnull void (^)(UIImage * __nullable qrImage))completion;

#pragma mark - 带图片二维码(图片为默认比例0.2、默认方形)
+ (void)andy_qrImageWithString:(NSString * __nullable)string size:(CGSize)size iconImage:(UIImage * __nullable)iconImage completion:(nonnull void (^)(UIImage * __nullable qrImage))completion;

#pragma mark - 带图片二维码（图片指定比例、方形）
+ (void)andy_qrImageWithString:(NSString * __nullable)string size:(CGSize)size iconImage:(UIImage * __nullable)iconImage scale:(CGFloat)scale completion:(nonnull void (^)(UIImage * __nullable qrImage))completion ;

#pragma mark - 带图片二维码（图片指定比例、指定CenterImgType）
+ (void)andy_qrImageWithString:(NSString * __nullable)string size:(CGSize)size CenterImageType:(AndyCenterImageType)type iconImage:(UIImage * __nullable)iconImage scale:(CGFloat)scale completion:(nonnull void (^)(UIImage * __nullable qrImage))completion;

#pragma mark - 给二维码设置背景（默认方形）
+ (void)andy_qrImage:(UIImage * __nullable)qrImage backgroundImage:(UIImage * __nullable)backgroundImage backgroundImageSize:(CGSize)backgroundImageSize completion:(nonnull void (^)(UIImage * __nullable qrImage))completion;

#pragma mark - 给二维码设置背景
+ (void)andy_qrIamge:(UIImage * __nullable)qrImage centerImageType:(AndyCenterImageType)type backgroundImage:(UIImage * __nullable)backgroundImage backgroundImageSize:(CGSize)backgroundImageSize completion:(nonnull void (^)(UIImage * __nullable qrImage))completion;

#pragma mark - 字符串生成CIImage
+ (CIImage * __nullable)andy_qrImageWithString:(NSString * __nullable)string;

#pragma mark  将CIImage转为高清的UIImage
+ (UIImage * __nullable)andy_ciImage:(CIImage * __nullable)ciImage size:(CGSize)size;

#pragma mark - 图片切圆角
- (UIImage * __nullable)andy_cornerRadius:(CGFloat)radius size:(CGSize)size;

#pragma mark  高斯模糊图片
+ (UIImage * __nullable)andy_createGaussianImage:(UIImage * __nullable)image;

@end
