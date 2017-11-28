//
//  UITableView+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 2017/11/27.
//  Copyright © 2017年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Andy)

- (CGFloat)andy_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath  configuration:(void (^)(id cell))configuration;


@end
