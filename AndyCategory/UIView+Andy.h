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

- (void)andy_drawShadow;

- (void)andy_drawShadowWithColor:(UIColor *)shadowColor;

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
- (UIView *)andy_subviewWithTag:(NSInteger)tag;

@end

@interface UIView (Hierarchy)

/**
 * 获取当前view最近的uiviewcontroller。
 */
@property (nonatomic, readonly) UIViewController *viewController;

/**
 * 移除所有子视图。
 */
- (void)andy_removeAllSubviews;

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

- (void)andy_testAmbiguity;

@end
