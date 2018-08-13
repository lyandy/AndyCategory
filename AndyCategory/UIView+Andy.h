//
//  UIView+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Andy)

@property (nonatomic, assign) CGSize  andy_Size;
@property (nonatomic, assign) CGFloat andy_Width;
@property (nonatomic, assign) CGFloat andy_Height;
@property (nonatomic, assign) CGFloat andy_X;
@property (nonatomic, assign) CGFloat andy_Y;
@property (nonatomic, assign) CGFloat andy_CenterX;
@property (nonatomic, assign) CGFloat andy_CenterY;
@property (nonatomic, assign) CGFloat andy_Top;
@property (nonatomic, assign) CGFloat andy_Bottom;
@property (nonatomic, assign) CGFloat andy_Left;
@property (nonatomic, assign) CGFloat andy_Right;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 可以在分类 Category 中声明 @property 属性。但此时的属性声明只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量 */
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)andy_isShowingOnKeyWindow;

+ (instancetype)andy_viewFromXib;

+ (instancetype)andy_viewFromXibName:(NSString *)xibName;

- (void)andy_drawShadow;

- (void)andy_drawShadowWithColor:(UIColor *)shadowColor;

- (void)andy_drawShadowWithColor:(UIColor *)shadowColor edgeInset:(UIEdgeInsets)edgeInset offset:(CGSize)offset;

- (void)andy_hideShadow;

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
- (UINavigationController *)andy_selfNavigationController;
- (UIView *)andy_subviewWithTag:(NSInteger)tag;

@end

@interface UIView (Gesture)

/**
 * 在当前视图上添加点击事件。
 */
- (void)andy_addTapAction:(SEL)tapAction target:(id)target;

@end

@interface UIView (FirstResponder)

// 获取视图的第一响应者
- (UIView *)andy_findViewThatIsFirstResponder;
// 获取所有的子视图
- (NSArray *)andy_descendantViews;

@end

@interface UIView (AutoLayout)

#pragma mark - 中心点的约束
/**
 视图的中心点横坐标相对于依赖的视图view中心点横坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutCenterXToViewCenterX:(UIView *)view constant:(CGFloat)constant;

/**
 视图的中心点纵坐标相对于依赖的视图view中心点纵坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutCenterYToViewCenterY:(UIView *)view constant:(CGFloat)constant;

/**
 相对于依赖的视图view居中
 
 @param view 依赖的视图
 */
- (void)andy_setAutoLayoutCenterToViewCenter:(UIView *)view;

#pragma mark - 顶部的约束
/**
 视图的顶部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutTopToViewTop:(UIView *)view constant:(CGFloat)constant;

/**
 视图的顶部相对于依赖的视图view底部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutTopToViewBottom:(UIView *)view constant:(CGFloat)constant;

#pragma mark - 左边的约束
/**
 视图的左边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutLeftToViewLeft:(UIView *)view constant:(CGFloat)constant;


/**
 视图的左边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutLeftToViewRight:(UIView *)view constant:(CGFloat)constant;

#pragma mark - 底部的约束
/**
 视图的底部相对于依赖的视图view底部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutBottomToViewBottom:(UIView *)view constant:(CGFloat)constant;

/**
 视图的底部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutBottomToViewTop:(UIView *)view constant:(CGFloat)constant;


#pragma mark - 右边的约束
/**
 视图的右边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutRightToViewLeft:(UIView *)view constant:(CGFloat)constant;


/**
 视图的右边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint*)andy_setAutoLayoutRightToViewRight:(UIView *)view constant:(CGFloat)constant;


#pragma mark - 尺寸的约束
/**
 视图的宽度约束
 
 @param constant 宽度
 */
- (NSLayoutConstraint*)andy_setAutoLayoutWidth:(CGFloat)constant;

/**
 视图的宽度约束
 
 @param view 依赖的视图
 @param constant 宽度
 */
- (NSLayoutConstraint*)andy_setAutoLayoutWidthToView:(UIView *)view constant:(CGFloat)constant;


/**
 视图的高度约束
 
 @param constant 高度
 */
- (NSLayoutConstraint*)andy_setAutoLayoutHeight:(CGFloat)constant;

/**
 视图的高度约束
 
 @param view 依赖的视图
 @param constant 高度
 */
- (NSLayoutConstraint*)andy_setAutoLayoutHeightToView:(UIView *)view constant:(CGFloat)constant;

/**
 视图的大小约束
 
 @param size 尺寸
 */
- (void)andy_setAutoLayoutSize:(CGSize)size;

@end
