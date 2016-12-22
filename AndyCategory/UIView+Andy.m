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
    for (UIView *next = [self superview]; next != nil; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
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

@implementation UIView (Hierarchy)

- (UIViewController *)viewController
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

- (void)andy_removeAllSubviews
{
    for (UIView *subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
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

- (void)andy_testAmbiguity
{
    if (self.hasAmbiguousLayout)
    {
        NSLog(@"<%@:%p>: %@", self.class.description, self, @"Ambiguous");
    }
    for (UIView *view in self.subviews)
    {
        [view andy_testAmbiguity];
    }
}

@end
