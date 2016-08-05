//
//  UIDevice+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIDevice (Andy)

+ (NSString *)andy_deviceVersion;

- (NSString *)deviceName;

- (NSString *)deviceType;

- (NSString *)uuid;

- (BOOL)touchIdEnable;

- (BOOL)ios7OrLater;
- (BOOL)ios8OrLater;
- (BOOL)ios9OrLater;

- (BOOL)iphone4;

- (BOOL)isPush;

- (NSString *)validNickName;

- (double)bootTime;

- (double)freeDiskSpace;

- (double)totalDiskSpace;

- (NSString *)wifiName;

- (NSString *)wifiMac;

- (NSString *)localWiFiIPAddress;

- (NSString *)appList;

// 是否越狱手机
- (BOOL)isModify;

- (BOOL)isSimulator;

- (NSString *)localPhone;

- (NSString *)base3GStation;

// 是否可以打电话
- (BOOL)callPhoneEnable;

// 根据域名获取IP地址   youyouyang.cn--->139.129.209.214
+ (NSArray *)ipAddress:(NSString *)hostName;

@end
