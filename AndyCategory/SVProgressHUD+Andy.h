//
//  SVProgressHUD+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (Andy)

+ (void)andy_showLoadingWithStatus:(NSString *)status;

+ (void)andy_showInfoWithStatus:(NSString *)status;

+ (void)andy_showSuccessWithStatus:(NSString *)status;

+ (void)andy_showErrorWithStatus:(NSString *)status;


@end
