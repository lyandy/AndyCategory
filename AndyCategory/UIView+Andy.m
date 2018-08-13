//
//  UIView+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIView+Andy.h"

@implementation UIView (Andy)

- (CGSize)andy_Size
{
    return self.frame.size;
}

- (void)setAndy_Size:(CGSize)andy_Size
{
    CGRect frame = self.frame;
    frame.size = andy_Size;
    self.frame = frame;
}

- (CGFloat)andy_Width
{
    return self.frame.size.width;
}

- (void)setAndy_Width:(CGFloat)andy_Width
{
    CGRect frame = self.frame;
    frame.size.width = andy_Width;
    self.frame = frame;
}

- (CGFloat)andy_Height
{
    return self.frame.size.height;
}

- (void)setAndy_Height:(CGFloat)andy_Height
{
    CGRect frame = self.frame;
    frame.size.height = andy_Height;
    self.frame = frame;
}

- (CGFloat)andy_X
{
    return self.frame.origin.x;
}

- (void)setAndy_X:(CGFloat)andy_X
{
    CGRect frame = self.frame;
    frame.origin.x = andy_X;
    self.frame = frame;
}

- (CGFloat)andy_Y
{
    return self.frame.origin.y;
}

- (void)setAndy_Y:(CGFloat)andy_Y
{
    CGRect frame = self.frame;
    frame.origin.y = andy_Y;
    self.frame = frame;
}

- (CGFloat)andy_CenterX
{
    return self.center.x;
}

- (void)setAndy_CenterX:(CGFloat)andy_CenterX
{
    CGPoint center = self.center;
    center.x = andy_CenterX;
    self.center = center;
}

- (CGFloat)andy_CenterY
{
    return self.center.y;
}

- (void)setAndy_CenterY:(CGFloat)andy_CenterY
{
    CGPoint center = self.center;
    center.y = andy_CenterY;
    self.center = center;
}

- (CGFloat)andy_Top {
    return [self andy_Y];
}

- (void)setAndy_Top:(CGFloat)andy_Top {
    [self setAndy_Y:andy_Top];
}

- (CGFloat)andy_Left {
    return [self andy_X];
}

- (void)setAndy_Left:(CGFloat)andy_Left
{
    [self setAndy_X:andy_Left];
}

- (CGFloat)andy_Bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setAndy_Bottom:(CGFloat)andy_Bottom

{
    self.frame = CGRectMake(self.andy_Left, andy_Bottom - self.andy_Height, self.andy_Width, self.andy_Height);
}

- (CGFloat)andy_Right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setAndy_Right:(CGFloat)andy_Right
{
    self.frame = CGRectMake(andy_Right - self.andy_Width, self.andy_Top, self.andy_Width, self.andy_Height);
}

- (BOOL)andy_isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)andy_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (instancetype)andy_viewFromXibName:(NSString *)xibName
{
    return [[[NSBundle mainBundle]loadNibNamed:xibName ? xibName : NSStringFromClass([self class]) owner:xibName options:nil] lastObject];
}

- (void)andy_drawShadow
{
    self.layer.shadowRadius = 1.5f;
    self.layer.shadowColor = [UIColor colorWithRed:200.f/255.f green:200.f/255.f blue:200.f/255.f alpha:1.f].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.9f;
    self.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(-1.5f, -1.5f, -1.5f, -1.5f);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.bounds, shadowInsets)];
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)andy_drawShadowWithColor:(UIColor *)shadowColor
{
    self.layer.shadowRadius = 1.5f;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.9f;
    self.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(-1.5f, -1.5f, -1.5f, -1.5f);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.bounds, shadowInsets)];
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)andy_drawShadowWithColor:(UIColor *)shadowColor edgeInset:(UIEdgeInsets)edgeInset offset:(CGSize)offset
{
    self.layer.shadowRadius = 3.0f;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = 1.0f;
    self.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets = edgeInset;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.bounds, shadowInsets)];
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)andy_hideShadow
{
    self.layer.shadowRadius = 0.0f;
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.0f;
    self.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.bounds, shadowInsets)];
    self.layer.shadowPath = shadowPath.CGPath;
}

- (BOOL)andy_intersectsWithView:(UIView *)view
{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (void)andy_removeAllSubviews
{
    while ([self.subviews count] > 0)
    {
        UIView *subview = [self.subviews objectAtIndex:0];
        [subview removeFromSuperview];
    }
}

- (void)andy_removeViewWithTag:(NSInteger)tag
{
    if (tag == 0)
    {
        return;
    }
    UIView *view = [self viewWithTag:tag];
    if (view != nil)
    {
        [view removeFromSuperview];
    }
}

- (void)andy_removeSubViewArray:(NSMutableArray *)views
{
    for (UIView *sub in views)
    {
        [sub removeFromSuperview];
    }
}

- (void)andy_removeViewWithTags:(NSArray *)tagArray
{
    for (NSNumber *num in tagArray)
    {
        [self andy_removeViewWithTag:[num integerValue]];
    }
}

- (void)andy_removeViewWithTagLessThan:(NSInteger)tag
{
    NSMutableArray *views = [NSMutableArray array];
    for (UIView *view in self.subviews)
    {
        if (view.tag > 0 && view.tag < tag)
        {
            [views addObject:view];
        }
    }
    [self andy_removeSubViewArray:views];
}

- (void)andy_removeViewWithTagGreaterThan:(NSInteger)tag
{
    NSMutableArray *views = [NSMutableArray array];
    for (UIView *view in self.subviews)
    {
        if (view.tag > 0 && view.tag > tag)
        {
            [views addObject:view];
        }
    }
    [self andy_removeSubViewArray:views];
}

- (UIViewController *)andy_selfViewController
{
    UIResponder *nextResponder =  self;
    
    do
    {
        nextResponder = [nextResponder nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController *)nextResponder;
        
    } while (nextResponder != nil);
    
    return nil;
}

- (UINavigationController *)andy_selfNavigationController
{
    UIResponder *nextResponder =  self;
    
    do
    {
        nextResponder = [nextResponder nextResponder];
        
        if ([nextResponder isKindOfClass:[UINavigationController class]])
            return (UINavigationController *)nextResponder;
        
    } while (nextResponder != nil);
    
    return nil;
}

- (UIView *)andy_subviewWithTag:(NSInteger)tag
{
    for (UIView *sub in self.subviews)
    {
        if (sub.tag == tag)
        {
            return sub;
        }
    }
    return nil;
}

@end

@implementation UIView (Gesture)

- (void)andy_addTapAction:(SEL)tapAction target:(id)target
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:tapAction];
    gesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:gesture];
}

@end

@implementation UIView (FirstResponder)

- (UIView *)andy_findViewThatIsFirstResponder
{
    if (self.isFirstResponder)
    {
        return self;
    }
    
    for (UIView *subView in self.subviews)
    {
        UIView *firstResponder = [subView andy_findViewThatIsFirstResponder];
        if (firstResponder != nil)
        {
            return firstResponder;
        }
    }
    return nil;
}

- (NSArray *)andy_descendantViews
{
    NSMutableArray *descendantArray = [NSMutableArray array];
    for (UIView *view in self.subviews)
    {
        [descendantArray addObject:view];
        [descendantArray addObjectsFromArray:[view andy_descendantViews]];
    }
    return [descendantArray copy];
}

@end

@implementation UIView (AutoLayout)

#pragma mark - 中心点的约束
/**
 视图的中心点横坐标相对于依赖的视图view中心点横坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutCenterXToViewCenterX:(UIView *)view constant:(CGFloat)constant{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintCenterX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintCenterX];
    return  constraintCenterX;
}

/**
 视图的中心点纵坐标相对于依赖的视图view中心点纵坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutCenterYToViewCenterY:(UIView *)view constant:(CGFloat)constant{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintCenterY = [NSLayoutConstraint constraintWithItem:self  attribute:NSLayoutAttributeCenterY   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintCenterY];
    return constraintCenterY;
    
}

/**
 相对于依赖的视图view居中
 
 @param view 依赖的视图
 */
- (void)andy_setAutoLayoutCenterToViewCenter:(UIView *)view{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintCenterX = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeCenterX   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    
    
    NSLayoutConstraint * constraintCenterY = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeCenterY   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self.superview addConstraints:@[constraintCenterX,constraintCenterY]];
    
}

#pragma mark - 顶部的约束
/**
 视图的顶部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutTopToViewTop:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintTop = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeTop   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintTop];
    return constraintTop;
    
    
}

/**
 视图的顶部相对于依赖的视图view底部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutTopToViewBottom:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintBottom = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeTop   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintBottom];
    return constraintBottom;
}

#pragma mark - 左边的约束
/**
 视图的左边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint* )andy_setAutoLayoutLeftToViewLeft:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintLeft = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintLeft];
    return constraintLeft;
}


/**
 视图的左边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutLeftToViewRight:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintRight = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintRight];
    return constraintRight;
    
}

#pragma mark - 底部的约束
/**
 视图的底部相对于依赖的视图view底部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutBottomToViewBottom:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintBottom = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeBottom   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintBottom];
    return constraintBottom;
}

/**
 视图的底部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutBottomToViewTop:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintBottom = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeBottom   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintBottom];
    return constraintBottom;
    
}


#pragma mark - 右边的约束
/**
 视图的右边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutRightToViewLeft:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintRight];
    return constraintRight;
}


/**
 视图的右边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint *)andy_setAutoLayoutRightToViewRight:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintRight];
    return constraintRight;
    
}


#pragma mark - 尺寸的约束
/**
 视图的宽度约束
 
 @param constant 宽度
 */
- (NSLayoutConstraint *)andy_setAutoLayoutWidth:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintWidth];
    return constraintWidth;
}

/**
 视图的宽度约束
 
 @param view 依赖的视图
 @param constant 宽度
 */
- (NSLayoutConstraint *)andy_setAutoLayoutWidthToView:(UIView *)view constant:(CGFloat)constant{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintWidth];
    return constraintWidth;
    
}


/**
 视图的高度约束
 
 @param constant 高度
 */
- (NSLayoutConstraint *)andy_setAutoLayoutHeight:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintHeight];
    return constraintHeight;
}

/**
 视图的高度约束
 
 @param view 依赖的视图
 @param constant 高度
 */
- (NSLayoutConstraint*)andy_setAutoLayoutHeightToView:(UIView *)view constant:(CGFloat)constant{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintHeight];
    return constraintHeight;
    
}

/**
 视图的大小约束
 
 @param size 尺寸
 */
- (void)andy_setAutoLayoutSize:(CGSize)size{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.width];
    
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.height];
    
    [self.superview addConstraints:@[constraintWidth,constraintHeight]];
    
}

@end
