//
//  NSString+Andy.m
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "NSString+Andy.h"
#import "NSData+Andy.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Andy)

// 对比两个字符串内容是否一致
- (BOOL)andy_equals:(NSString *)string
{
    return [self isEqualToString:string];
}

// 判断字符串是否以指定的前缀开头
- (BOOL)andy_startsWith:(NSString *)prefix
{
    return [self hasPrefix:prefix];
}

// 判断字符串是否以指定的后缀结束
- (BOOL)andy_endsWith:(NSString *)suffix
{
    return [self hasSuffix:suffix];
}

// 转换成小写
- (NSString *)andy_toLowerCase
{
    return [self lowercaseString];
}

// 转换成大写
- (NSString *)andy_toUpperCase
{
    return [self uppercaseString];
}

// 截取字符串前后空格
- (NSString *)andy_trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// 用指定分隔符将字符串分割成数组
- (NSArray *)andy_split:(NSString *)separator
{
    return [self componentsSeparatedByString:separator];
}

// 用指定字符串替换原字符串
- (NSString *)andy_replaceAll:(NSString *)oldStr with:(NSString *)newStr
{
    return [self stringByReplacingOccurrencesOfString:oldStr withString:newStr];
}

//从指定的开始位置和结束位置开始截取字符串
- (NSString *)andy_substringFromIndex:(int)begin toIndex:(int)end
{
    if (end <= begin) {
        return @"";
    }
    NSRange range = NSMakeRange(begin, end - begin);
    return [self substringWithRange:range];
}

/**
 *  md5加密
 */
- (NSString *)andy_md5HexDigest
{
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

/**
 *  sha1加密
 */
- (NSString *)andy_sha1HexDigest {
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", digest[i]];
    }
    return ret;
}

// UTF-8转码
- (NSString *)andy_UTF8String
{
    return [NSString stringWithString:[self stringByRemovingPercentEncoding]];
}

// 正则IP地址
- (BOOL)andy_isValidIPAdddress
{
    NSString *emailRegex = @"((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

// 正则匹配邮箱号
- (BOOL)andy_isValidMailInput
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

// 正则匹配手机号
- (BOOL)andy_isValidTelNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,183,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


// 正则匹配用户密码6-18位数字和字母组合
- (BOOL)andy_isValidPassword
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

// 正则匹配用户姓名,20位的中文或英文
- (BOOL)andy_isValidUserName
{
    
    //    NSString *pattern = @"^[A-Za-z0-9]{6,20}+$";
    NSString *pattern = @"^([\u4e00-\u9fa5]+|([a-zA-Z]+\\s?)+)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}


// 正则匹配用户身份证号15或18位
- (BOOL)andy_isValidUserIdCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 正则匹员工号,12位的数字
- (BOOL)andy_isValidEmployeeNumber
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 正则匹配URL
- (BOOL)andy_isValidURL
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 正则匹配昵称
- (BOOL)andy_isValidNickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 正则匹配银行卡号是否正确
- (BOOL)andy_isValidBankNumber
{
    NSString *bankNum=@"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bankNum];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 正则只能输入数字和字母
- (BOOL)andy_isValidOnlyCharAndNumber
{
    NSString *bankNum=@"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bankNum];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 车牌号验证
- (BOOL)andy_isValidCarNumber
{
    NSString *bankNum = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bankNum];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 格式化手机号
- (NSString *)standardPhone {
    NSInteger position = 3;
    
    NSMutableString *tmp = [NSMutableString stringWithFormat:@"%@", self];
    [tmp replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, tmp.length)];
    
    while (1) {
        if (tmp.length > position) {
            [tmp insertString:@" " atIndex:position];
            position += 5;
        } else {
            break;
        }
    }
    
    return tmp;
}

// 格式化手机号
- (NSString *)standardTele
{
    if (self.length < 8) {
        return self;
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:self];
    [string insertString:@"-" atIndex:3];
    [string insertString:@"-" atIndex:7];
    return string;
}

// 手机号****处理
- (NSString *)securitPhone {
    if (self.length != 11) {
        return self;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
}

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)andy_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

// AES加密
- (NSString *)andy_aes256_encrypt:(NSString *)key
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //对数据进行加密
    NSData *result = [data andy_aes256_encrypt:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

// AES解密
- (NSString *)andy_aes256_decrypt:(NSString *)key
{
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data andy_aes256_decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end

@implementation NSString (ParametersSafe)

- (instancetype)safe_initWithString:(NSString *)aString
{
    if (aString == nil || [aString isKindOfClass:[NSNull class]]) {
        return [self initWithString:@""];
    }
    
    return [self initWithString:aString];
}

- (NSString *)safe_substringToIndex:(NSInteger)to
{
    if (to <= 0) {
        return @"";
    }
    
    if (to >= self.length) {
        return self;
    }
    
    return [self substringToIndex:to];
}

- (NSString *)safe_substringFromIndex:(NSInteger)from
{
    if (from <= 0) {
        return self;
    }
    
    if (from >= self.length) {
        return @"";
    }
    
    return [self substringFromIndex:from];
}

@end
