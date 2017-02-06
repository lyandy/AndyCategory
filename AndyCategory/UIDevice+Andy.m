//
//  UIDevice+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/5.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "UIDevice+Andy.h"
#import "NSString+Andy.h"
#import "sys/utsname.h"
#import  <CFNetwork/CFNetwork.h>
#import  <sys/stat.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <sys/param.h>
#include <sys/mount.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <netdb.h>
#import  <AdSupport/ASIdentifierManager.h>
#import  <SystemConfiguration/CaptiveNetwork.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#import  <dlfcn.h>

#define Valid(a) ((a == nil || [a isKindOfClass:[NSNull class]] || ([a respondsToSelector:@selector(isEqualToString:)] && ([a isEqualToString:@"<null>"] || [a isEqualToString:@"(null)"] || [a isEqualToString:@"null"]))) ? @"" : a)

#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])
#define USER_APP_PATH                 @"/User/Applications/"
#define CYDIA_APP_PATH                "/Applications/Cydia.app"

const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

char* printEnv(void)
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s", env);
    return env;
}

@implementation UIDevice (Andy)

+ (NSString *)andy_deviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

+ (NSString *)andy_deviceName
{
    char *typeSpecifier = "hw.machine";
    
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *name = malloc(size);
    sysctlbyname(typeSpecifier, name, &size, NULL, 0);
    
    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    
    free(name);
    
    return machine;
}

+ (NSString *)andy_deviceType
{
    char *typeSpecifier = "hw.machine";
    
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *name = malloc(size);
    sysctlbyname(typeSpecifier, name, &size, NULL, 0);
    
    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    
    free(name);
    
    // http://stackoverflow.com/questions/11197509/ios-how-to-get-device-make-and-model
    // http://stackoverflow.com/questions/19584208/identify-new-iphone-model-on-xcode-5-5c-5s
    
    if( [machine isEqualToString:@"i386"] || [machine isEqualToString:@"x86_64"] ) machine = @"ios_Simulator";
    
    else if( [machine isEqualToString:@"iPhone1,1"] ) machine = @"iPhone_1G";
    
    else if( [machine isEqualToString:@"iPhone1,2"] ) machine = @"iPhone_3G";
    else if( [machine isEqualToString:@"iPhone2,1"] ) machine = @"iPhone_3GS";
    
    else if( [machine isEqualToString:@"iPhone3,1"] ) machine = @"iPhone_4"; // (GSM)
    else if( [machine isEqualToString:@"iPhone3,3"] ) machine = @"iPhone_4"; // (CDMA/Verizon/Sprint)
    else if( [machine isEqualToString:@"iPhone4,1"] ) machine = @"iPhone_4S";
    
    else if( [machine isEqualToString:@"iPhone5,1"] ) machine = @"iPhone_5"; // (model A1428, AT&T/Canada)
    else if( [machine isEqualToString:@"iPhone5,2"] ) machine = @"iPhone_5"; // (model A1429, everything else)
    else if( [machine isEqualToString:@"iPhone5,3"] ) machine = @"iPhone_5C"; // (model A1456, A1532 | GSM)
    else if( [machine isEqualToString:@"iPhone5,4"] ) machine = @"iPhone_5C"; // (model A1507, A1516, A1526 (China), A1529 | Global)
    else if( [machine isEqualToString:@"iPhone6,1"] ) machine = @"iPhone_5S"; // (model A1433, A1533 | GSM)
    else if( [machine isEqualToString:@"iPhone6,2"] ) machine = @"iPhone_5S"; // (model A1457, A1518, A1528 (China), A1530 | Global)
    else if( [machine isEqualToString:@"iPhone6,2"] ) machine = @"iPhone_5S"; // (model A1457, A1518, A1528 (China), A1530 | Global)
    
    else if( [machine isEqualToString:@"iPhone7,1"] ) machine = @"iPhone_6Plus";
    else if( [machine isEqualToString:@"iPhone7,2"] ) machine = @"iPhone_6";
    
    else if( [machine isEqualToString:@"iPhone8,1"] ) machine = @"iPhone_6S";
    else if( [machine isEqualToString:@"iPhone8,2"] ) machine = @"iPhone_6SPlus";
    
    else if( [machine isEqualToString:@"iPhone8,4"] ) machine = @"iPhone_SE";
    
    else if( [machine isEqualToString:@"iPod1,1"] ) machine = @"iPod_Touch_1G";
    else if( [machine isEqualToString:@"iPod2,1"] ) machine = @"iPod_Touch_2G";
    else if( [machine isEqualToString:@"iPod3,1"] ) machine = @"iPod_Touch_3G";
    else if( [machine isEqualToString:@"iPod4,1"] ) machine = @"iPod_Touch_4G";
    
    else if( [machine isEqualToString:@"iPad1,1"] ) machine = @"iPad_1";
    else if( [machine isEqualToString:@"iPad2,1"] ) machine = @"iPad_2";
    
    return Valid(machine);
}

+ (NSString *)andy_uuid
{
    //参考 http://www.jianshu.com/p/f1b59dfb482f
    return Valid([[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]);
}

+ (BOOL)andy_touchIdEnable
{
    BOOL deviceEnable = NO;
    
    NSString *device = [self andy_deviceName];
    NSMutableString *first = [NSMutableString stringWithString:Valid([device componentsSeparatedByString:@","].firstObject)];
    NSRange range = [first rangeOfString:@"iPhone"];
    if (range.length > 0 && range.location != NSNotFound) {
        [first replaceOccurrencesOfString:@"iPhone" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, first.length)];
        if (first.integerValue >= 6)
        {
            deviceEnable = YES;
        }
    }
    
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && deviceEnable;
}

+ (BOOL)andy_ios7OrLater
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO;
}

+ (BOOL)andy_ios8OrLater
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO;
}

+ (BOOL)andy_ios9OrLater
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO;
}

+ (BOOL)andy_iphone4
{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320*2, 480*2), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)andy_isPush
{
    if ([self andy_ios8OrLater])
    {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    } else {
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        UIUserNotificationType type = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
#else
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
#endif
        
        if (UIUserNotificationTypeNone == type)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}

+ (NSString *)andy_validNickName
{
    NSMutableString *nickName = [[NSMutableString alloc] andy_safe_initWithString:[[UIDevice currentDevice] name]];
    [nickName replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, nickName.length)];
    
    return Valid([nickName andy_safe_substringToIndex:10]);
}


// 获取是否是iPhone
+ (double)andy_isIPhone
{
    static BOOL __isIPhone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __isIPhone = [[self currentDevice].model rangeOfString:@"iPhone"].location != NSNotFound;
    });
    return __isIPhone;
}


+ (double)andy_bootTime
{
    // NSProcessInfo用于获取当前正在执行的进程信息，包括设备的名称，操作系统版本，进程标识符，进程环境，参数等信息。systemUptime属性返回系统自启动时的累计时间，可以用来精确处理涉及到需要考察时间段的场景（如果直接使用系统时间的差值可能会因为用户修改系统时间而出错）。
    return [[NSDate date] timeIntervalSince1970] - [[NSProcessInfo processInfo] systemUptime];
}

+ (double)andy_freeDiskSpace
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0)
    {
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace;
}

+ (double)andy_totalDiskSpace
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    struct statfs tStats;
    statfs([paths.lastObject cStringUsingEncoding:NSUTF8StringEncoding], &tStats);
    float totalSpace = (float)(tStats.f_blocks * tStats.f_bsize);
    
    return totalSpace;
}

+ (NSString *)andy_wifiName
{
    return [self andy_wifi:(__bridge NSString *)kCNNetworkInfoKeySSID];
}

+ (NSString *)andy_wifiMac
{
    return [self andy_wifi:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
}

+ (NSString *)andy_wifi:(NSString *)key
{
    NSString *wifi = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces)
    {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef)
        {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifi = [networkInfo objectForKey:key];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifi;
}

// 参考 http://www.jianshu.com/p/a6bab07c4062

// en0（Wifi）、pdp_ip0（移动网络）的ip地址
+ (NSString *)andy_localWiFiIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL)
        {
            // the second test keeps from picking up the loopback address
            if ((cursor->ifa_addr->sa_family == AF_INET || cursor->ifa_addr->sa_family == AF_INET6) && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])
                {
                    //如果是IPV4地址，直接转化
                    if (cursor->ifa_addr->sa_family == AF_INET)
                    {
                        // Get NSString from C String
                        return [UIDevice andy_formatIPV4Address:((struct sockaddr_in *)cursor->ifa_addr)->sin_addr];
                    }
                    
                    //如果是IPV6地址
                    else if (cursor->ifa_addr->sa_family == AF_INET6)
                    {
                        return [UIDevice andy_formatIPV6Address:((struct sockaddr_in6 *)cursor->ifa_addr)->sin6_addr];
                    }
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}

//for IPV6
+ (NSString *)andy_formatIPV6Address:(struct in6_addr)ipv6Addr
{
    NSString *address = nil;
    
    char dstStr[INET6_ADDRSTRLEN];
    char srcStr[INET6_ADDRSTRLEN];
    memcpy(srcStr, &ipv6Addr, sizeof(struct in6_addr));
    if(inet_ntop(AF_INET6, srcStr, dstStr, INET6_ADDRSTRLEN) != NULL)
    {
        address = [NSString stringWithUTF8String:dstStr];
    }
    
    return address;
}

//for IPV4
+ (NSString *)andy_formatIPV4Address:(struct in_addr)ipv4Addr
{
    NSString *address = nil;
    
    char dstStr[INET_ADDRSTRLEN];
    char srcStr[INET_ADDRSTRLEN];
    memcpy(srcStr, &ipv4Addr, sizeof(struct in_addr));
    if(inet_ntop(AF_INET, srcStr, dstStr, INET_ADDRSTRLEN) != NULL)
    {
        address = [NSString stringWithUTF8String:dstStr];
    }
    
    return address;
}

+ (NSString *)andy_appList
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH])
    {
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APP_PATH error:nil];
        return [applist componentsJoinedByString:@","];
    }
    
    return @"";
}

+ (BOOL)andy_isModify
{
    for (int i = 0; i < ARRAY_SIZE(jailbreak_tool_pathes); i++)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]])
        {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]])
    {
        NSLog(@"The device is jail broken!!");
        return YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH])
    {
        NSLog(@"The device is jail broken!!!");
        return YES;
    }
    
    if (printEnv()) {
        NSLog(@"The device is jail broken!!!!!");
        return YES;
    }
    
    return NO;
}

+ (BOOL)andy_isSimulator
{
    return TARGET_IPHONE_SIMULATOR;
}

+ (NSString *)andy_localPhone
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
}

+ (NSString *)andy_base3GStation
{
    return @""; // 这个后面写吧，太难了
}

+ (BOOL)andy_callPhoneEnable
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    NSRange podRange = [deviceType rangeOfString:@"iPod" options:NSCaseInsensitiveSearch];
    NSRange padRange = [deviceType rangeOfString:@"iPad" options:NSCaseInsensitiveSearch];
    NSRange simulatorRange = [deviceType rangeOfString:@"Simulator" options:NSCaseInsensitiveSearch];
    
    return !(podRange.location != NSNotFound || padRange.location != NSNotFound || simulatorRange.location != NSNotFound);
}

+ (NSArray *)andy_ipAddress:(NSString *)hostName
{
    Boolean result = NO;
    CFHostRef hostRef;
    CFArrayRef addresses = NULL;
    NSMutableArray *ipAddress = [[NSMutableArray alloc] init];
    
    hostRef = CFHostCreateWithName(kCFAllocatorDefault, (__bridge CFStringRef)hostName);

    if (hostRef)
    {
        result = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL); // pass an error instead of NULL here to find out why it failed
        if (result == TRUE)
        {
            addresses = CFHostGetAddressing(hostRef, &result);
        }
    }
    
    if (result == TRUE)
    {
        
        for (int i = 0; i < CFArrayGetCount(addresses); i++)
        {
            
            CFDataRef ref = (CFDataRef) CFArrayGetValueAtIndex(addresses, i);
            struct sockaddr_in* remoteAddr;
            char *ip_address = "";
            remoteAddr = (struct sockaddr_in*) CFDataGetBytePtr(ref);
            if (remoteAddr != NULL)
            {
                ip_address = inet_ntoa(remoteAddr->sin_addr);
            }
            NSString *ip = [NSString stringWithCString:ip_address encoding:NSUTF8StringEncoding];
            [ipAddress addObject:ip];
        }
    }
    
    if (hostRef != NULL)
    {
        CFRelease(hostRef);
    }
    
    return ipAddress;
}

+ (BOOL)andy_isPad {
    static BOOL __isPad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __isPad = [[self currentDevice].model rangeOfString:@"iPad"].location != NSNotFound;
    });
    return __isPad;
}

@end
