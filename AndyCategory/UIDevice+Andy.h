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

- (NSString *)andy_deviceName;

- (NSString *)andy_deviceType;

- (NSString *)andy_uuid;

- (BOOL)andy_touchIdEnable;

- (BOOL)andy_ios7OrLater;
- (BOOL)andy_ios8OrLater;
- (BOOL)andy_ios9OrLater;

- (BOOL)andy_iphone4;

- (BOOL)andy_isPush;

- (NSString *)andy_validNickName;

- (double)andy_bootTime;

- (double)andy_freeDiskSpace;

- (double)andy_totalDiskSpace;

- (NSString *)andy_wifiName;

- (NSString *)andy_wifiMac;

- (NSString *)andy_localWiFiIPAddress;

- (NSString *)andy_appList;

// 是否越狱手机
- (BOOL)andy_isModify;

- (BOOL)andy_isSimulator;

- (NSString *)andy_localPhone;

- (NSString *)andy_base3GStation;

// 是否可以打电话
- (BOOL)andy_callPhoneEnable;

// 根据域名获取IP地址   youyouyang.cn--->139.129.209.214
+ (NSArray *)andy_ipAddress:(NSString *)hostName;

@end
