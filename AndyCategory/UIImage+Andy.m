//
//  UIImage+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIImage+Andy.h"
#import <Accelerate/Accelerate.h>
#import <Photos/Photos.h>

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (Andy)

- (UIImage *)andy_circleImage
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)andy_resizedImageWithName:(NSString *)name
{
    return [self andy_resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)andy_resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}


+ (UIImage *)andy_scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

+ (UIImage *)andy_reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

/** 根据最大宽高重设图片大小 */
+ (UIImage *)andy_reSizeImage:(UIImage *)image maxEdge:(CGFloat)maxEdge
{
    CGSize imgSize = image.size;
    if (imgSize.width > imgSize.height) {
        CGFloat height = maxEdge / imgSize.width * imgSize.height;
        return [self andy_reSizeImage:image toSize:CGSizeMake(maxEdge, height)];
    } else {
        CGFloat width = maxEdge / imgSize.height * imgSize.width;
        return [self andy_reSizeImage:image toSize:CGSizeMake(width, maxEdge)];
    }
}


/** 根据最小宽高重设图片大小 */
+ (UIImage *)andy_reSizeImage:(UIImage *)image minEdge:(CGFloat)minEdge
{
    CGSize imgSize = image.size;
    if (imgSize.width > imgSize.height) {
        CGFloat width = minEdge / imgSize.height * imgSize.width;
        return [self andy_reSizeImage:image toSize:CGSizeMake(width, minEdge)];
    } else {
        CGFloat height = minEdge / imgSize.width * imgSize.height;
        return [self andy_reSizeImage:image toSize:CGSizeMake(minEdge, height)];
    }
}

+ (UIImage *)andy_scaleImage:(UIImage *)image toSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor > heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    // this is actually the interesting part:
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [image drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage ;
}

- (void)andy_savePictureToDocuments:(UIImage *)image imageName:(NSString *)imageName
{
    NSString *path = [[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:imageName];
    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
}

- (void)andy_savePictureToPhotoLibrary:(UIImage *)image imageName:(NSString *)imageName delegate:(id)delegate
{
    UIImageWriteToSavedPhotosAlbum(image, delegate, nil, nil);
}

+ (UIImage *)andy_combineImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    UIGraphicsBeginImageContext(image1.size);
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
+ (UIImage *)andy_combineImage:(UIImage *)image1 toImage:(UIImage *)image2 image1Offset:(CGPoint)offset
{
    //创建绘图上下文
    UIGraphicsBeginImageContext(image2.size);
    
    //CGContextRef thisctx=UIGraphicsGetCurrentContext();
    //图像坐标变换
    //CGContextRotateCTM(thisctx, -M_PI);
    //CGContextTranslateCTM(thisctx, -image2.size.width, -image2.size.height);
    //绘制底图
    //CGContextDrawImage(thisctx, CGRectMake(0, 0, image2.size.width, image2.size.height), [image2 CGImage]);
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    //在底图上绘制图片
    //CGContextDrawImage(thisctx, CGRectMake(0, 0, image1.size.width, image1.size.height), [image1 CGImage]);
    [image1 drawInRect:CGRectMake(offset.x, offset.y, image1.size.width, image1.size.height)];
    //得到所绘制的图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)andy_combineImageForHorizontalTile:(UIImage *)frontImage backgroundImage:(UIImage *)backgroundImage rect:(CGSize)rect
{
    //创建绘图上下文
    UIGraphicsBeginImageContext(rect);
    
    //CGContextRef thisctx=UIGraphicsGetCurrentContext();
    //图像坐标变换
    //CGContextRotateCTM(thisctx, -M_PI);
    //CGContextTranslateCTM(thisctx, -image2.size.width, -image2.size.height);
    //绘制底图
    //CGContextDrawImage(thisctx, CGRectMake(0, 0, image2.size.width, image2.size.height), [image2 CGImage]);
    for (int i = 0; i < (rect.width/backgroundImage.size.width) + 1; i++)
    {
        [backgroundImage drawInRect:CGRectMake(backgroundImage.size.width * i, 0, backgroundImage.size.width, backgroundImage.size.height)];
    }
    
    //在底图上绘制图片
    //CGContextDrawImage(thisctx, CGRectMake(0, 0, image1.size.width, image1.size.height), [image1 CGImage]);
    for(int i = 0; i < (rect.width/frontImage.size.width) + 1; i++)
    {
        [frontImage drawInRect:CGRectMake(frontImage.size.width * i, 0, frontImage.size.width, frontImage.size.height)];
    }
    //得到所绘制的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)andy_getImageWithContentFile:(NSString *)fileName
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:imagePath];
}

+ (UIImage *)andy_normalResImageWithUrl:(NSURL *)url WithinSize:(CGFloat)maxInSize
{
    // Convert ALAsset to UIImage
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    // Determine output size
    CGFloat maxSize = maxInSize;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat newWidth = width;
    CGFloat newHeight = height;
    
    // If any side exceeds the maximun size, reduce the greater side to 1200px and proportionately the other one
    if (width > maxSize || height > maxSize)
    {
        if (width > height)
        {
            newWidth = maxSize;
            newHeight = (height * maxSize) / width;
        }
        else
        {
            newHeight = maxSize;
            newWidth = (width * maxSize) / height;
        }
    }
    
    // Resize the image
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Set maximun compression in order to decrease file size and enable faster uploads & downloads
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.0f);
    UIImage *processedImage = [UIImage imageWithData:imageData];
    
    return processedImage;
}

+ (UIImage *)andy_createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

// Tint: Color
- (UIImage *)andy_tintedImageWithColor:(UIColor *)color
{
    return [self andy_tintedImageWithColor:color level:1.0f];
}

// Tint: Color + level
- (UIImage *)andy_tintedImageWithColor:(UIColor *)color level:(CGFloat)level
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self andy_tintedImageWithColor:color rect:rect level:level];
}

// Tint: Color + Rect
- (UIImage *)andy_tintedImageWithColor:(UIColor *)color rect:(CGRect)rect
{
    return [self andy_tintedImageWithColor:color rect:rect level:1.0f];
}

// Tint: Color + Rect + level
- (UIImage *)andy_tintedImageWithColor:(UIColor *)color rect:(CGRect)rect level:(CGFloat)level
{
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetAlpha(ctx, level);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, rect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.scale
                                       orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}

// Tint: Color + Insets
- (UIImage *)andy_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets
{
    return [self andy_tintedImageWithColor:color insets:insets level:1.0f];
}

// Tint: Color + Insets + level
- (UIImage *)andy_tintedImageWithColor:(UIColor *)color insets:(UIEdgeInsets)insets level:(CGFloat)level
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self andy_tintedImageWithColor:color rect:UIEdgeInsetsInsetRect(rect, insets) level:level];
}

// Light: Level
- (UIImage *)andy_lightenWithLevel:(CGFloat)level
{
    return [self andy_tintedImageWithColor:[UIColor whiteColor] level:level];
}

// Light: Level + Insets
- (UIImage *)andy_lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets
{
    return [self andy_tintedImageWithColor:[UIColor whiteColor] insets:insets level:level];
}

// Light: Level + Rect
- (UIImage *)andy_lightenRect:(CGRect)rect withLevel:(CGFloat)level
{
    return [self andy_tintedImageWithColor:[UIColor whiteColor] rect:rect level:level];
}

// Dark: Level
- (UIImage *)andy_darkenWithLevel:(CGFloat)level
{
    return [self andy_tintedImageWithColor:[UIColor blackColor] level:level];
}

// Dark: Level + Insets
- (UIImage *)andy_darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets
{
    return [self andy_tintedImageWithColor:[UIColor blackColor] insets:insets level:level];
}

// Dark: Level + Rect
- (UIImage *)andy_darkenRect:(CGRect)rect withLevel:(CGFloat)level
{
    return [self andy_tintedImageWithColor:[UIColor blackColor] rect:rect level:level];
}


+ (UIImage *)andy_imageResourceNamed:(NSString *)name ofType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [UIImage imageWithContentsOfFile:path];
}

// UIView转UIImage
+ (UIImage *)andy_imageWithView:(UIView *)view
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    return image;
}


// UIView转UIImage，后台线程跑，主线程返回
+ (void)andy_imageWithViewAsync:(UIView *)view complete:(void (^)(UIImage *image))complete
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage *img = [UIImage andy_imageWithView:view];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(img);
        });
    });
}

UIImage* rotateUIImage(const UIImage* src, float angleDegrees)
{
    UIView* rotatedViewBox = [[UIView alloc] initWithFrame: CGRectMake(0, 0, src.size.width, src.size.height)];
    float angleRadians = angleDegrees * ((float)M_PI / 180.0f);
    CGAffineTransform t = CGAffineTransformMakeRotation(angleRadians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    UIGraphicsBeginImageContext(rotatedSize);
    //http://stackoverflow.com/questions/5017540/how-to-i-rotate-uiimageview-by-90-degrees-inside-a-uiscrollview-with-correct-ima
    //UIGraphicsBeginImageContextWithOptions(rotatedSize,NO,0.f);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, angleRadians);
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-src.size.width / 2, -src.size.height / 2, src.size.width, src.size.height), [src CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// UIView转UIImage
+ (UIImage *)andy_imageWithView:(UIView *)view withRect:(CGRect)rect
{
    CGSize cropImageSize = rect.size;
    UIGraphicsBeginImageContext(cropImageSize);
    CGContextRef resizedContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext, -(rect.origin.x), -(rect.origin.y));
    [view.layer renderInContext:resizedContext];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//截取部分图像
-(UIImage *)andy_imageInRect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

- (UIImage *)andy_imageSquare
{
    CGSize size = self.size;
    CGFloat squareSize = MIN(size.width, size.height);
    CGRect squareRect = CGRectMake((size.width - squareSize) / 2.0, (size.height - squareSize) / 2.0, squareSize, squareSize);
    return [self andy_imageInRect:squareRect];
}

- (UIImage *)andy_imageRotatedByRadians:(CGFloat)radians
{
    return [self andy_imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)andy_imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 等比例缩放
- (UIImage *)andy_imageWithScale:(CGFloat)scale
{
    CGSize scaleSize = CGSizeMake(self.size.width * scale, self.size.height * scale);
    UIGraphicsBeginImageContext(scaleSize);
    [self drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

// 按比例缩放适应指定大小
- (UIImage *)andy_imageFitSize:(CGSize)size
{
    CGSize imgSize = self.size;
    CGFloat radio = MAX(size.width / imgSize.width, size.height / imgSize.height);
    if (radio < 1)
    {
        return [self andy_imageWithScale:radio];
    }
    return self;
}

//遮罩合成新图片
- (UIImage *)andy_imageWithMask:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    CGImageRef masked = CGImageCreateWithMask([self CGImage], mask);
    CGImageRelease(mask);
    UIImage *img = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    return img;
}

- (UIImage *)andy_imageWithImage:(UIImage *)image
{
    CGSize size = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)andy_blurImage
{
    return [self andy_applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil];
}

- (UIImage *)andy_blurImageWithRadius:(CGFloat)radius
{
    return [self andy_applyBlurWithRadius:radius
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil];
}


- (UIImage *)andy_blurImageWithMask:(UIImage *)maskImage
{
    return [self andy_applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:maskImage];
}

- (UIImage *)andy_blurImageAtFrame:(CGRect)frame
{
    return [self applyBlurWithRadius:20
                           tintColor:[UIColor colorWithWhite:0 alpha:0.0]
               saturationDeltaFactor:1.4
                           maskImage:nil
                             atFrame:frame];
}

// 核心代码
- (UIImage *)andy_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1)
    {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage)
    {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage)
    {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange)
    {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1)
            {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange)
        {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i)
            {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur)
            {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else
            {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
        {
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
        {
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur)
    {
        CGContextSaveGState(outputContext);
        if (maskImage)
        {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor)
    {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *)croppedImageAtFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x * self.scale, frame.origin.y * self.scale, frame.size.width * self.scale, frame.size.height * self.scale);
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, frame);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[self scale] orientation:[self imageOrientation]];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage *)addImageToImage:(UIImage *)img atRect:(CGRect)cropRect{
    
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [self drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = cropRect.origin;
    [img drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage
                          atFrame:(CGRect)frame
{
    UIImage *blurredFrame = \
    [[self croppedImageAtFrame:frame] andy_applyBlurWithRadius:blurRadius
                                                tintColor:tintColor
                                    saturationDeltaFactor:saturationDeltaFactor
                                                maskImage:maskImage];
    
    return [self addImageToImage:blurredFrame atRect:frame];
}

- (UIImage *)andy_grayScale
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 width,
                                                 height,
                                                 8, // bits per component
                                                 0,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL)
    {
        return nil;
    }
    
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:image];
    CFRelease(image);
    CGContextRelease(context);
    
    return grayImage;
}

- (UIColor *)andy_averageColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0)
    {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else
    {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

//保存到相册
- (void)saveToCameraRoll:(nullable void(^)(BOOL success, NSError *__nullable error))completionHandler
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:self];
    } completionHandler:completionHandler];
}

#pragma mark - 生成原始二维码
+ (void)andy_qrImageWithString:(NSString *)string size:(CGSize)size completion:(void (^)(UIImage *qrImage))completion{
    
    [self andy_qrImageWithString:string size:size iconImage:nil scale:0 completion:completion];
}

#pragma mark - 带图片二维码(图片为默认比例0.2、默认方形)
+ (void)andy_qrImageWithString:(NSString *)string size:(CGSize)size iconImage:(UIImage *)iconImage completion:(void (^)(UIImage * qrImage))completion {
    
    [self andy_qrImageWithString:string size:size iconImage:iconImage scale:0.20 completion:completion];
}

#pragma mark - 带图片二维码（图片指定比例、方形）
+ (void)andy_qrImageWithString:(NSString *)string size:(CGSize)size iconImage:(UIImage *)iconImage scale:(CGFloat)scale completion:(void (^)(UIImage * qrImage))completion {
    // 传入 AndyCenterImageTypeSquare
    [self andy_qrImageWithString:string size:size CenterImageType:AndyCenterImageTypeSquare iconImage:iconImage scale:scale completion:completion];
}

#pragma mark - 带图片二维码（图片指定比例、指定CenterImgType）
+ (void)andy_qrImageWithString:(NSString *)string size:(CGSize)size CenterImageType:(AndyCenterImageType)type iconImage:(UIImage *)iconImage scale:(CGFloat)scale completion:(void (^)(UIImage *qrImage))completion{
    // 断言
    NSAssert(completion, @"completion must be implemented");
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取输出文件
        CIImage *ciImage = [UIImage andy_qrImageWithString:string];
        
        // 放大为高清图
        UIImage *qrImage = [UIImage andy_ciImage:ciImage size:size];
        
        // 添加中间小图片
        qrImage = [self andy_qrcodeImage:qrImage iconImage:iconImage centerImageType:type scale:scale];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回调
            completion(qrImage);
        });
    });
    
}


#pragma mark - 给二维码设置背景（默认方形）
+ (void)andy_qrImage:(UIImage *)qrImage backgroundImage:(UIImage *)backgroundImage backgroundImageSize:(CGSize)backgroundImageSize completion:(void (^)(UIImage *qrImage))completion{
    [self andy_qrIamge:qrImage centerImageType:AndyCenterImageTypeSquare backgroundImage:backgroundImage backgroundImageSize:backgroundImageSize completion:completion];
}
#pragma mark - 给二维码设置背景
+ (void)andy_qrIamge:(UIImage *)qrImage centerImageType:(AndyCenterImageType)type backgroundImage:(UIImage *)backgroundImage backgroundImageSize:(CGSize)backgroundImageSize completion:(void (^)(UIImage *qrImage))completion{
    
    // 断言
    NSAssert(completion, @"completion must be implemented");
    // 为二维码添加自定义背景
    
    __block UIImage * bgImg;
    __block UIImage * qrImg;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 保证背景、二维码两者的像素比例合适，分辨率跟newImage一致
        bgImg = [self andy_scaleImage:backgroundImage toSize:backgroundImageSize];
        qrImg = [self andy_scaleImage:qrImage toSize:qrImage.size];
        
        UIImage *newImage = [self andy_qrcodeImage:bgImg iconImage:qrImg centerImageType:type scale:1.0 * qrImg.size.width /  bgImg.size.width];;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(newImage);
        });
    });
    
}

#pragma mark - 字符串生成CIImage
+ (CIImage *)andy_qrImageWithString:(NSString *)string{
    // 创建过滤器
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 设置默认过滤属性
    [qrFilter setDefaults];
    
    // 使用KVC设置属性 (将字符串转为data)
    [qrFilter setValue:[string dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    
    // 获取输出文件
    CIImage *ciImage = qrFilter.outputImage;
    
    return ciImage;
}


#pragma mark  将CIImage转为高清的UIImage
+ (UIImage *)andy_ciImage:(CIImage *)ciImage size:(CGSize)size {
    //
    CGRect extent = CGRectIntegral(ciImage.extent);
    // 倍数
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(cs);
    //return [UIImage imageWithCGImage:scaledImage]; // 分辨率为72
    
    UIImage *image = [UIImage imageWithCGImage:scaledImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    CGImageRelease(scaledImage);
    
    return image; // 分辨率根据屏幕分辨率扩大相应倍数 72 * 倍数
}

#pragma mark  小图片二维码合并
+ (UIImage *)andy_qrcodeImage:(UIImage *)qrImage iconImage:(UIImage *)iconImage centerImageType:(AndyCenterImageType)type scale:(CGFloat)scale {
    // 图片放大倍数等于屏幕分辨类
    CGFloat screenScale = [UIScreen mainScreen].scale; // 是屏幕缩放率
    CGRect rect = CGRectMake(0, 0, qrImage.size.width * screenScale, qrImage.size.height * screenScale);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, screenScale);
    
    [qrImage drawInRect:rect];
    
    if(iconImage)
    { // 如果有图片
        
        CGSize avatarSize = CGSizeMake(rect.size.width * scale, rect.size.height * scale);
        CGFloat x = (rect.size.width - avatarSize.width) * 0.5;
        CGFloat y = (rect.size.height - avatarSize.height) * 0.5;
        if (type == AndyCenterImageTypeCircle)
        { // 如果为圆形
            
            iconImage = [iconImage andy_circleImage];
            
        }
        else if (type == AndyCenterImageTypeCornorRadious)
        {
            iconImage = [iconImage andy_cornerRadius:5.0f size:avatarSize];
        }
        
        [iconImage drawInRect:CGRectMake(x, y, avatarSize.width, avatarSize.height)];
    }
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:result.CGImage scale:screenScale orientation:UIImageOrientationUp] ;
}



#pragma mark - 图片切圆角
- (UIImage *)andy_cornerRadius:(CGFloat)radius size:(CGSize)size
{
    CGRect rect = (CGRect){0.f, 0.f, size};
    
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}

#pragma mark  高斯模糊图片
+ (UIImage *)andy_createGaussianImage:(UIImage *)image
{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey, inputImage,@"inputRadius", @(70.5), nil];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    
    return resultImage;
}


@end
