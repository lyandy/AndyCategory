//
//  UIView+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Andy)

//
@property (nonatomic, assign) CGSize andy_Size;
@property (nonatomic, assign) CGFloat andy_Width;
@property (nonatomic, assign) CGFloat andy_Height;
@property (nonatomic, assign) CGFloat andy_X;
@property (nonatomic, assign) CGFloat andy_Y;
@property (nonatomic, assign) CGFloat andy_CenterX;
@property (nonatomic, assign) CGFloat andy_CenterY;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 可以在分类 Category 中声明 @property 属性。但此时的属性声明只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量 */
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)andy_isShowingOnKeyWindow;

+ (instancetype)andy_viewFromXib;

/**
 *  判断self和view是否重叠
 */
- (BOOL)andy_intersectsWithView:(UIView *)view;

- (void)andy_removeAllSubviews;
- (void)andy_removeViewWithTag:(NSInteger)tag;
- (void)andy_removeViewWithTags:(NSArray *)tagArray;
- (void)andy_removeViewWithTagLessThan:(NSInteger)tag;
- (void)andy_removeViewWithTagGreaterThan:(NSInteger)tag;
- (UIViewController *)andy_selfViewController;
- (UIView *)andy_subviewWithTag:(NSInteger)tag;


@end
