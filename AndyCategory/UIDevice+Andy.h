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

// 获取设备版本
+ (NSString *)andy_deviceVersion;

// 获取设备名称
+ (NSString *)andy_deviceName;

// 获取设备类型
+ (NSString *)andy_deviceType;

// 获取UUID
+ (NSString *)andy_uuid;

// 判断touchId是否可用
+ (BOOL)andy_touchIdEnable;

// 判断版本
+ (BOOL)andy_ios7OrLater;
+ (BOOL)andy_ios8OrLater;
+ (BOOL)andy_ios9OrLater;

// 判断是否iPhone4
+ (BOOL)andy_iphone4;

// 判断是否打开通知
+ (BOOL)andy_isPush;

// 获取手机名称
+ (NSString *)andy_validNickName;

// 获取开机时间
+ (double)andy_bootTime;

// 获取是否是iPhone
+ (double)andy_isIPhone;

+ (BOOL)andy_isPad;

// 获取可用空间大小
+ (double)andy_freeDiskSpace;

// 获取总空间大小
+ (double)andy_totalDiskSpace;

// 获取wifi名字
+ (NSString *)andy_wifiName;

// 获取wifi物理地址
+ (NSString *)andy_wifiMac;

// 获取wifiIP地址
+ (NSString *)andy_localWiFiIPAddress;

// 获取应用列表
+ (NSString *)andy_appList;

// 是否越狱手机
+ (BOOL)andy_isModify;

// 是否模拟器
+ (BOOL)andy_isSimulator;

// 获取本地手机号
+ (NSString *)andy_localPhone;

// 获取基站名称
+ (NSString *)andy_base3GStation;

// 是否可以打电话
+ (BOOL)andy_callPhoneEnable;

// 根据域名获取IP地址   youyouyang.cn--->139.129.209.214
+ (NSArray *)andy_ipAddress:(NSString *)hostName;

@end
