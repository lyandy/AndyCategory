//
//  UITableView+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 2017/11/27.
//  Copyright © 2017年 andyli. All rights reserved.
//

#import "UITableView+Andy.h"
#import <objc/runtime.h>

@implementation UITableView (Andy)

- (CGFloat)andy_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id))configuration
{
    if (!identifier || !indexPath)
    {
        return 0;
    }
    
    CGFloat height = [self heightForCellWithIdentifier:identifier forIndexPath:indexPath configuration:configuration];
    
    return height;
}

- (CGFloat)heightForCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration
{
    if (!identifier)
    {
        return 0;
    }
    
    UITableViewCell *templateLayoutCell = [self templateCellForReuseIdentifier:identifier forIndexPath:indexPath];
    if (configuration)
    {
        configuration(templateLayoutCell);
    }
    CGFloat height=[self systemFittingHeightForConfiguratedCell:templateLayoutCell];
    return height;
}

- (CGFloat)systemFittingHeightForConfiguratedCell:(UITableViewCell *)cell
{
    CGFloat contentViewWidth = self.bounds.size.width;
    CGFloat fittingHeight = 0;
    CGFloat accessroyWidth = 0;
    if (cell.accessoryView)
    {
        accessroyWidth = 16 + CGRectGetWidth(cell.accessoryView.frame);
    }
    else
    {
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        accessroyWidth = systemAccessoryWidths[cell.accessoryType];
    }
    
    contentViewWidth -= accessroyWidth;
    if (contentViewWidth > 0)
    {
        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
        
        // [bug fix] after iOS 10.3, Auto Layout engine will add an additional 0 width constraint onto cell's content view, to avoid that, we add constraints to content view's left, right, top and bottom.
        static BOOL isSystemVersionEqualOrGreaterThen10_2 = NO;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            isSystemVersionEqualOrGreaterThen10_2 = [UIDevice.currentDevice.systemVersion compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending;
        });
        NSArray<NSLayoutConstraint *> *edgeConstraints;
        
        if (isSystemVersionEqualOrGreaterThen10_2)
        {
            widthFenceConstraint.priority = UILayoutPriorityRequired - 1;
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:accessroyWidth];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            edgeConstraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
            [cell addConstraints:edgeConstraints];
        }
        
        [cell.contentView addConstraint:widthFenceConstraint];
        fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        [cell.contentView removeConstraint:widthFenceConstraint];
        if (isSystemVersionEqualOrGreaterThen10_2)
        {
            [cell removeConstraints:edgeConstraints];
        }
    }
    if (fittingHeight == 0)
    {
#if DEBUG
        if (cell.contentView.constraints.count > 0)
        {
            if (!objc_getAssociatedObject(self, _cmd))
            {
                NSLog(@"Warning once only: Cannot get a proper cell height (now 0) from '- systemFittingSize:'(AutoLayout). You should check how constraints are built in cell, making it into 'self-sizing' cell.");
                objc_setAssociatedObject(self, _cmd, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
#endif
        fittingHeight = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
        
    }
    
    if (fittingHeight == 0)
    {
        fittingHeight = 44;
    }
    
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone)
    {
        fittingHeight += 1.0 / [UIScreen mainScreen].scale;
    }
    return fittingHeight;
}

- (UITableViewCell *)templateCellForReuseIdentifier:(NSString *)identifier  forIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    NSMutableDictionary<NSString *, UITableViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers)
    {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    if (!templateCell)
    {
        templateCell = [self dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to tableview  for identifier - %@", identifier);
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellsByIdentifiers[identifier] = templateCell;
    }
    return templateCell;
}

@end
