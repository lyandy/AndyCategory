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

static NSDictionary * s_unicodeToCheatCodes = nil;
static NSDictionary * s_cheatCodesToUnicode = nil;

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
    CC_MD5(str, (unsigned int)strlen(str), result);
    
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
- (NSString *)andy_sha1HexDigest
{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x", digest[i]];
    }
    return ret;
}

// UTF-8转码
- (NSString *)andy_UTF8String
{
    return [NSString stringWithString:[self stringByRemovingPercentEncoding]];
}

//判断是否为整形
+(BOOL)andy_isValidPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
+(BOOL)andy_isValidPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
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
    if (self.length <= 0)
    {
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
- (NSString *)andy_standardPhone
{
    NSInteger position = 3;
    
    NSMutableString *tmp = [NSMutableString stringWithFormat:@"%@", self];
    [tmp replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, tmp.length)];
    
    while (1)
    {
        if (tmp.length > position)
        {
            [tmp insertString:@" " atIndex:position];
            position += 5;
        }
        else
        {
            break;
        }
    }
    
    return tmp;
}

// 格式化手机号
- (NSString *)andy_standardTele
{
    if (self.length < 8)
    {
        return self;
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:self];
    [string insertString:@"-" atIndex:3];
    [string insertString:@"-" atIndex:7];
    return string;
}

// 手机号****处理
- (NSString *)andy_securitPhone
{
    if (self.length != 11)
    {
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
    if (result && result.length > 0)
    {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++)
        {
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
    for (i=0; i < [self length] / 2; i++)
    {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data andy_aes256_decrypt:key];
    if (result && result.length > 0)
    {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

//- (NSString *)andy_mimeType
//{
//    if (![[NSFileManager defaultManager] fileExistsAtPath:self]) {
//        return nil;
//    }
//    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge  CFStringRef)[self pathExtension], NULL);
//    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
//    CFRelease(UTI);
//    if (!MIMEType) {
//        return @"application/octet-stream";
//    }
//    return (__bridge NSString *)MIMEType;
//}

- (NSString *)andy_mimeType2
{
    NSURLResponse *response = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:self]];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

- (NSString *)andy_pinyin
{
    return [self pinyinWithTone:NO];
}

- (NSString *)andy_pinyinAndTone
{
    return [self pinyinWithTone:YES];
}

- (NSString *)pinyinWithTone:(BOOL)tone
{
    NSMutableString *string = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)string,NULL,kCFStringTransformMandarinLatin,NO);
    if (!tone)
    {
        CFStringTransform((__bridge CFMutableStringRef)string,NULL,kCFStringTransformStripDiacritics,NO);
    }
    return [[NSString alloc] initWithString:string];
}

- (NSString *)andy_base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] andy_base64EncodedString];
}

+ (NSString *)andy_stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [NSData andy_dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)andy_stringByURLEncode {
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
         - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
         - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
         - parameter string: The string to be percent-escaped.
         - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < self.length) {
            NSUInteger length = MIN(self.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [self substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)andy_stringByURLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)andy_stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return self;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

//判断空字符串
+ (BOOL)andy_isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)andy_stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


+ (void)initializeEmojiCheatCodes
{
    NSDictionary *forwardMap = @{
                                 @"😄": @":smile:",
                                 @"😆": @[@":laughing:", @":D"],
                                 @"😊": @":blush:",
                                 @"😃": @[@":smiley:", @":)", @":-)"],
                                 @"☺": @":relaxed:",
                                 @"😏": @":smirk:",
                                 @"😞": @[@":disappointed:", @":("],
                                 @"😍": @":heart_eyes:",
                                 @"😘": @":kissing_heart:",
                                 @"😚": @":kissing_closed_eyes:",
                                 @"😳": @":flushed:",
                                 @"😥": @":relieved:",
                                 @"😌": @":satisfied:",
                                 @"😁": @":grin:",
                                 @"😉": @[@":wink:", @";)", @";-)"],
                                 @"😜": @[@":wink2:", @":P"],
                                 @"😝": @":stuck_out_tongue_closed_eyes:",
                                 @"😀": @":grinning:",
                                 @"😗": @":kissing:",
                                 @"😙": @":kissing_smiling_eyes:",
                                 @"😛": @":stuck_out_tongue:",
                                 @"😴": @":sleeping:",
                                 @"😟": @":worried:",
                                 @"😦": @":frowning:",
                                 @"😧": @":anguished:",
                                 @"😮": @[@":open_mouth:", @":o"],
                                 @"😬": @":grimacing:",
                                 @"😕": @":confused:",
                                 @"😯": @":hushed:",
                                 @"😑": @":expressionless:",
                                 @"😒": @":unamused:",
                                 @"😅": @":sweat_smile:",
                                 @"😓": @":sweat:",
                                 @"😩": @":weary:",
                                 @"😔": @":pensive:",
                                 @"😞": @":dissapointed:",
                                 @"😖": @":confounded:",
                                 @"😨": @":fearful:",
                                 @"😰": @":cold_sweat:",
                                 @"😣": @":persevere:",
                                 @"😢": @":cry:",
                                 @"😭": @":sob:",
                                 @"😂": @":joy:",
                                 @"😲": @":astonished:",
                                 @"😱": @":scream:",
                                 @"😫": @":tired_face:",
                                 @"😠": @":angry:",
                                 @"😡": @":rage:",
                                 @"😤": @":triumph:",
                                 @"😪": @":sleepy:",
                                 @"😋": @":yum:",
                                 @"😷": @":mask:",
                                 @"😎": @":sunglasses:",
                                 @"😵": @":dizzy_face:",
                                 @"👿": @":imp:",
                                 @"😈": @":smiling_imp:",
                                 @"😐": @":neutral_face:",
                                 @"😶": @":no_mouth:",
                                 @"😇": @":innocent:",
                                 @"👽": @":alien:",
                                 @"💛": @":yellow_heart:",
                                 @"💙": @":blue_heart:",
                                 @"💜": @":purple_heart:",
                                 @"❤": @":heart:",
                                 @"💚": @":green_heart:",
                                 @"💔": @":broken_heart:",
                                 @"💓": @":heartbeat:",
                                 @"💗": @":heartpulse:",
                                 @"💕": @":two_hearts:",
                                 @"💞": @":revolving_hearts:",
                                 @"💘": @":cupid:",
                                 @"💖": @":sparkling_heart:",
                                 @"✨": @":sparkles:",
                                 @"⭐️": @":star:",
                                 @"🌟": @":star2:",
                                 @"💫": @":dizzy:",
                                 @"💥": @":boom:",
                                 @"💢": @":anger:",
                                 @"❗": @":exclamation:",
                                 @"❓": @":question:",
                                 @"❕": @":grey_exclamation:",
                                 @"❔": @":grey_question:",
                                 @"💤": @":zzz:",
                                 @"💨": @":dash:",
                                 @"💦": @":sweat_drops:",
                                 @"🎶": @":notes:",
                                 @"🎵": @":musical_note:",
                                 @"🔥": @":fire:",
                                 @"💩": @[@":poop:", @":hankey:", @":shit:"],
                                 @"👍": @[@":+1:", @":thumbsup:"],
                                 @"👎": @[@":-1:", @":thumbsdown:"],
                                 @"👌": @":ok_hand:",
                                 @"👊": @":punch:",
                                 @"✊": @":fist:",
                                 @"✌": @":v:",
                                 @"👋": @":wave:",
                                 @"✋": @":hand:",
                                 @"👐": @":open_hands:",
                                 @"☝": @":point_up:",
                                 @"👇": @":point_down:",
                                 @"👈": @":point_left:",
                                 @"👉": @":point_right:",
                                 @"🙌": @":raised_hands:",
                                 @"🙏": @":pray:",
                                 @"👆": @":point_up_2:",
                                 @"👏": @":clap:",
                                 @"💪": @":muscle:",
                                 @"🚶": @":walking:",
                                 @"🏃": @":runner:",
                                 @"👫": @":couple:",
                                 @"👪": @":family:",
                                 @"👬": @":two_men_holding_hands:",
                                 @"👭": @":two_women_holding_hands:",
                                 @"💃": @":dancer:",
                                 @"👯": @":dancers:",
                                 @"🙆": @":ok_woman:",
                                 @"🙅": @":no_good:",
                                 @"💁": @":information_desk_person:",
                                 @"🙋": @":raised_hand:",
                                 @"👰": @":bride_with_veil:",
                                 @"🙎": @":person_with_pouting_face:",
                                 @"🙍": @":person_frowning:",
                                 @"🙇": @":bow:",
                                 @"💏": @":couplekiss:",
                                 @"💑": @":couple_with_heart:",
                                 @"💆": @":massage:",
                                 @"💇": @":haircut:",
                                 @"💅": @":nail_care:",
                                 @"👦": @":boy:",
                                 @"👧": @":girl:",
                                 @"👩": @":woman:",
                                 @"👨": @":man:",
                                 @"👶": @":baby:",
                                 @"👵": @":older_woman:",
                                 @"👴": @":older_man:",
                                 @"👱": @":person_with_blond_hair:",
                                 @"👲": @":man_with_gua_pi_mao:",
                                 @"👳": @":man_with_turban:",
                                 @"👷": @":construction_worker:",
                                 @"👮": @":cop:",
                                 @"👼": @":angel:",
                                 @"👸": @":princess:",
                                 @"😺": @":smiley_cat:",
                                 @"😸": @":smile_cat:",
                                 @"😻": @":heart_eyes_cat:",
                                 @"😽": @":kissing_cat:",
                                 @"😼": @":smirk_cat:",
                                 @"🙀": @":scream_cat:",
                                 @"😿": @":crying_cat_face:",
                                 @"😹": @":joy_cat:",
                                 @"😾": @":pouting_cat:",
                                 @"👹": @":japanese_ogre:",
                                 @"👺": @":japanese_goblin:",
                                 @"🙈": @":see_no_evil:",
                                 @"🙉": @":hear_no_evil:",
                                 @"🙊": @":speak_no_evil:",
                                 @"💂": @":guardsman:",
                                 @"💀": @":skull:",
                                 @"👣": @":feet:",
                                 @"👄": @":lips:",
                                 @"💋": @":kiss:",
                                 @"💧": @":droplet:",
                                 @"👂": @":ear:",
                                 @"👀": @":eyes:",
                                 @"👃": @":nose:",
                                 @"👅": @":tongue:",
                                 @"💌": @":love_letter:",
                                 @"👤": @":bust_in_silhouette:",
                                 @"👥": @":busts_in_silhouette:",
                                 @"💬": @":speech_balloon:",
                                 @"💭": @":thought_balloon:",
                                 @"☀": @":sunny:",
                                 @"☔": @":umbrella:",
                                 @"☁": @":cloud:",
                                 @"❄": @":snowflake:",
                                 @"⛄": @":snowman:",
                                 @"⚡": @":zap:",
                                 @"🌀": @":cyclone:",
                                 @"🌁": @":foggy:",
                                 @"🌊": @":ocean:",
                                 @"🐱": @":cat:",
                                 @"🐶": @":dog:",
                                 @"🐭": @":mouse:",
                                 @"🐹": @":hamster:",
                                 @"🐰": @":rabbit:",
                                 @"🐺": @":wolf:",
                                 @"🐸": @":frog:",
                                 @"🐯": @":tiger:",
                                 @"🐨": @":koala:",
                                 @"🐻": @":bear:",
                                 @"🐷": @":pig:",
                                 @"🐽": @":pig_nose:",
                                 @"🐮": @":cow:",
                                 @"🐗": @":boar:",
                                 @"🐵": @":monkey_face:",
                                 @"🐒": @":monkey:",
                                 @"🐴": @":horse:",
                                 @"🐎": @":racehorse:",
                                 @"🐫": @":camel:",
                                 @"🐑": @":sheep:",
                                 @"🐘": @":elephant:",
                                 @"🐼": @":panda_face:",
                                 @"🐍": @":snake:",
                                 @"🐦": @":bird:",
                                 @"🐤": @":baby_chick:",
                                 @"🐥": @":hatched_chick:",
                                 @"🐣": @":hatching_chick:",
                                 @"🐔": @":chicken:",
                                 @"🐧": @":penguin:",
                                 @"🐢": @":turtle:",
                                 @"🐛": @":bug:",
                                 @"🐝": @":honeybee:",
                                 @"🐜": @":ant:",
                                 @"🐞": @":beetle:",
                                 @"🐌": @":snail:",
                                 @"🐙": @":octopus:",
                                 @"🐠": @":tropical_fish:",
                                 @"🐟": @":fish:",
                                 @"🐳": @":whale:",
                                 @"🐋": @":whale2:",
                                 @"🐬": @":dolphin:",
                                 @"🐄": @":cow2:",
                                 @"🐏": @":ram:",
                                 @"🐀": @":rat:",
                                 @"🐃": @":water_buffalo:",
                                 @"🐅": @":tiger2:",
                                 @"🐇": @":rabbit2:",
                                 @"🐉": @":dragon:",
                                 @"🐐": @":goat:",
                                 @"🐓": @":rooster:",
                                 @"🐕": @":dog2:",
                                 @"🐖": @":pig2:",
                                 @"🐁": @":mouse2:",
                                 @"🐂": @":ox:",
                                 @"🐲": @":dragon_face:",
                                 @"🐡": @":blowfish:",
                                 @"🐊": @":crocodile:",
                                 @"🐪": @":dromedary_camel:",
                                 @"🐆": @":leopard:",
                                 @"🐈": @":cat2:",
                                 @"🐩": @":poodle:",
                                 @"🐾": @":paw_prints:",
                                 @"💐": @":bouquet:",
                                 @"🌸": @":cherry_blossom:",
                                 @"🌷": @":tulip:",
                                 @"🍀": @":four_leaf_clover:",
                                 @"🌹": @":rose:",
                                 @"🌻": @":sunflower:",
                                 @"🌺": @":hibiscus:",
                                 @"🍁": @":maple_leaf:",
                                 @"🍃": @":leaves:",
                                 @"🍂": @":fallen_leaf:",
                                 @"🌿": @":herb:",
                                 @"🍄": @":mushroom:",
                                 @"🌵": @":cactus:",
                                 @"🌴": @":palm_tree:",
                                 @"🌲": @":evergreen_tree:",
                                 @"🌳": @":deciduous_tree:",
                                 @"🌰": @":chestnut:",
                                 @"🌱": @":seedling:",
                                 @"🌼": @":blossum:",
                                 @"🌾": @":ear_of_rice:",
                                 @"🐚": @":shell:",
                                 @"🌐": @":globe_with_meridians:",
                                 @"🌞": @":sun_with_face:",
                                 @"🌝": @":full_moon_with_face:",
                                 @"🌚": @":new_moon_with_face:",
                                 @"🌑": @":new_moon:",
                                 @"🌒": @":waxing_crescent_moon:",
                                 @"🌓": @":first_quarter_moon:",
                                 @"🌔": @":waxing_gibbous_moon:",
                                 @"🌕": @":full_moon:",
                                 @"🌖": @":waning_gibbous_moon:",
                                 @"🌗": @":last_quarter_moon:",
                                 @"🌘": @":waning_crescent_moon:",
                                 @"🌜": @":last_quarter_moon_with_face:",
                                 @"🌛": @":first_quarter_moon_with_face:",
                                 @"🌙": @":moon:",
                                 @"🌍": @":earth_africa:",
                                 @"🌎": @":earth_americas:",
                                 @"🌏": @":earth_asia:",
                                 @"🌋": @":volcano:",
                                 @"🌌": @":milky_way:",
                                 @"⛅": @":partly_sunny:",
                                 @"🎍": @":bamboo:",
                                 @"💝": @":gift_heart:",
                                 @"🎎": @":dolls:",
                                 @"🎒": @":school_satchel:",
                                 @"🎓": @":mortar_board:",
                                 @"🎏": @":flags:",
                                 @"🎆": @":fireworks:",
                                 @"🎇": @":sparkler:",
                                 @"🎐": @":wind_chime:",
                                 @"🎑": @":rice_scene:",
                                 @"🎃": @":jack_o_lantern:",
                                 @"👻": @":ghost:",
                                 @"🎅": @":santa:",
                                 @"🎱": @":8ball:",
                                 @"⏰": @":alarm_clock:",
                                 @"🍎": @":apple:",
                                 @"🎨": @":art:",
                                 @"🍼": @":baby_bottle:",
                                 @"🎈": @":balloon:",
                                 @"🍌": @":banana:",
                                 @"📊": @":bar_chart:",
                                 @"⚾": @":baseball:",
                                 @"🏀": @":basketball:",
                                 @"🛀": @":bath:",
                                 @"🛁": @":bathtub:",
                                 @"🔋": @":battery:",
                                 @"🍺": @":beer:",
                                 @"🍻": @":beers:",
                                 @"🔔": @":bell:",
                                 @"🍱": @":bento:",
                                 @"🚴": @":bicyclist:",
                                 @"👙": @":bikini:",
                                 @"🎂": @":birthday:",
                                 @"🃏": @":black_joker:",
                                 @"✒": @":black_nib:",
                                 @"📘": @":blue_book:",
                                 @"💣": @":bomb:",
                                 @"🔖": @":bookmark:",
                                 @"📑": @":bookmark_tabs:",
                                 @"📚": @":books:",
                                 @"👢": @":boot:",
                                 @"🎳": @":bowling:",
                                 @"🍞": @":bread:",
                                 @"💼": @":briefcase:",
                                 @"💡": @":bulb:",
                                 @"🍰": @":cake:",
                                 @"📆": @":calendar:",
                                 @"📲": @":calling:",
                                 @"📷": @":camera:",
                                 @"🍬": @":candy:",
                                 @"📇": @":card_index:",
                                 @"💿": @":cd:",
                                 @"📉": @":chart_with_downwards_trend:",
                                 @"📈": @":chart_with_upwards_trend:",
                                 @"🍒": @":cherries:",
                                 @"🍫": @":chocolate_bar:",
                                 @"🎄": @":christmas_tree:",
                                 @"🎬": @":clapper:",
                                 @"📋": @":clipboard:",
                                 @"📕": @":closed_book:",
                                 @"🔐": @":closed_lock_with_key:",
                                 @"🌂": @":closed_umbrella:",
                                 @"♣": @":clubs:",
                                 @"🍸": @":cocktail:",
                                 @"☕": @":coffee:",
                                 @"💻": @":computer:",
                                 @"🎊": @":confetti_ball:",
                                 @"🍪": @":cookie:",
                                 @"🌽": @":corn:",
                                 @"💳": @":credit_card:",
                                 @"👑": @":crown:",
                                 @"🔮": @":crystal_ball:",
                                 @"🍛": @":curry:",
                                 @"🍮": @":custard:",
                                 @"🍡": @":dango:",
                                 @"🎯": @":dart:",
                                 @"📅": @":date:",
                                 @"♦": @":diamonds:",
                                 @"💵": @":dollar:",
                                 @"🚪": @":door:",
                                 @"🍩": @":doughnut:",
                                 @"👗": @":dress:",
                                 @"📀": @":dvd:",
                                 @"📧": @":e-mail:",
                                 @"🍳": @":egg:",
                                 @"🍆": @":eggplant:",
                                 @"🔌": @":electric_plug:",
                                 @"✉": @":email:",
                                 @"💶": @":euro:",
                                 @"👓": @":eyeglasses:",
                                 @"📠": @":fax:",
                                 @"📁": @":file_folder:",
                                 @"🍥": @":fish_cake:",
                                 @"🎣": @":fishing_pole_and_fish:",
                                 @"🔦": @":flashlight:",
                                 @"💾": @":floppy_disk:",
                                 @"🎴": @":flower_playing_cards:",
                                 @"🏈": @":football:",
                                 @"🍴": @":fork_and_knife:",
                                 @"🍤": @":fried_shrimp:",
                                 @"🍟": @":fries:",
                                 @"🎲": @":game_die:",
                                 @"💎": @":gem:",
                                 @"🎁": @":gift:",
                                 @"⛳": @":golf:",
                                 @"🍇": @":grapes:",
                                 @"🍏": @":green_apple:",
                                 @"📗": @":green_book:",
                                 @"🎸": @":guitar:",
                                 @"🔫": @":gun:",
                                 @"🍔": @":hamburger:",
                                 @"🔨": @":hammer:",
                                 @"👜": @":handbag:",
                                 @"🎧": @":headphones:",
                                 @"♥": @":hearts:",
                                 @"🔆": @":high_brightness:",
                                 @"👠": @":high_heel:",
                                 @"🔪": @":hocho:",
                                 @"🍯": @":honey_pot:",
                                 @"🏇": @":horse_racing:",
                                 @"⌛": @":hourglass:",
                                 @"⏳": @":hourglass_flowing_sand:",
                                 @"🍨": @":ice_cream:",
                                 @"🍦": @":icecream:",
                                 @"📥": @":inbox_tray:",
                                 @"📨": @":incoming_envelope:",
                                 @"📱": @":iphone:",
                                 @"🏮": @":izakaya_lantern:",
                                 @"👖": @":jeans:",
                                 @"🔑": @":key:",
                                 @"👘": @":kimono:",
                                 @"📒": @":ledger:",
                                 @"🍋": @":lemon:",
                                 @"💄": @":lipstick:",
                                 @"🔒": @":lock:",
                                 @"🔏": @":lock_with_ink_pen:",
                                 @"🍭": @":lollipop:",
                                 @"➿": @":loop:",
                                 @"📢": @":loudspeaker:",
                                 @"🔅": @":low_brightness:",
                                 @"🔍": @":mag:",
                                 @"🔎": @":mag_right:",
                                 @"🀄": @":mahjong:",
                                 @"📫": @":mailbox:",
                                 @"📪": @":mailbox_closed:",
                                 @"📬": @":mailbox_with_mail:",
                                 @"📭": @":mailbox_with_no_mail:",
                                 @"👞": @":mans_shoe:",
                                 @"🍖": @":meat_on_bone:",
                                 @"📣": @":mega:",
                                 @"🍈": @":melon:",
                                 @"📝": @":memo:",
                                 @"🎤": @":microphone:",
                                 @"🔬": @":microscope:",
                                 @"💽": @":minidisc:",
                                 @"💸": @":money_with_wings:",
                                 @"💰": @":moneybag:",
                                 @"🚵": @":mountain_bicyclist:",
                                 @"🎥": @":movie_camera:",
                                 @"🎹": @":musical_keyboard:",
                                 @"🎼": @":musical_score:",
                                 @"🔇": @":mute:",
                                 @"📛": @":name_badge:",
                                 @"👔": @":necktie:",
                                 @"📰": @":newspaper:",
                                 @"🔕": @":no_bell:",
                                 @"📓": @":notebook:",
                                 @"📔": @":notebook_with_decorative_cover:",
                                 @"🔩": @":nut_and_bolt:",
                                 @"🍢": @":oden:",
                                 @"📂": @":open_file_folder:",
                                 @"📙": @":orange_book:",
                                 @"📤": @":outbox_tray:",
                                 @"📄": @":page_facing_up:",
                                 @"📃": @":page_with_curl:",
                                 @"📟": @":pager:",
                                 @"📎": @":paperclip:",
                                 @"🍑": @":peach:",
                                 @"🍐": @":pear:",
                                 @"✏": @":pencil2:",
                                 @"☎": @":phone:",
                                 @"💊": @":pill:",
                                 @"🍍": @":pineapple:",
                                 @"🍕": @":pizza:",
                                 @"📯": @":postal_horn:",
                                 @"📮": @":postbox:",
                                 @"👝": @":pouch:",
                                 @"🍗": @":poultry_leg:",
                                 @"💷": @":pound:",
                                 @"👛": @":purse:",
                                 @"📌": @":pushpin:",
                                 @"📻": @":radio:",
                                 @"🍜": @":ramen:",
                                 @"🎀": @":ribbon:",
                                 @"🍚": @":rice:",
                                 @"🍙": @":rice_ball:",
                                 @"🍘": @":rice_cracker:",
                                 @"💍": @":ring:",
                                 @"🏉": @":rugby_football:",
                                 @"🎽": @":running_shirt_with_sash:",
                                 @"🍶": @":sake:",
                                 @"👡": @":sandal:",
                                 @"📡": @":satellite:",
                                 @"🎷": @":saxophone:",
                                 @"✂": @":scissors:",
                                 @"📜": @":scroll:",
                                 @"💺": @":seat:",
                                 @"🍧": @":shaved_ice:",
                                 @"👕": @":shirt:",
                                 @"🚿": @":shower:",
                                 @"🎿": @":ski:",
                                 @"🚬": @":smoking:",
                                 @"🏂": @":snowboarder:",
                                 @"⚽": @":soccer:",
                                 @"🔉": @":sound:",
                                 @"👾": @":space_invader:",
                                 @"♠": @":spades:",
                                 @"🍝": @":spaghetti:",
                                 @"🔊": @":speaker:",
                                 @"🍲": @":stew:",
                                 @"📏": @":straight_ruler:",
                                 @"🍓": @":strawberry:",
                                 @"🏄": @":surfer:",
                                 @"🍣": @":sushi:",
                                 @"🍠": @":sweet_potato:",
                                 @"🏊": @":swimmer:",
                                 @"💉": @":syringe:",
                                 @"🎉": @":tada:",
                                 @"🎋": @":tanabata_tree:",
                                 @"🍊": @":tangerine:",
                                 @"🍵": @":tea:",
                                 @"📞": @":telephone_receiver:",
                                 @"🔭": @":telescope:",
                                 @"🎾": @":tennis:",
                                 @"🚽": @":toilet:",
                                 @"🍅": @":tomato:",
                                 @"🎩": @":tophat:",
                                 @"📐": @":triangular_ruler:",
                                 @"🏆": @":trophy:",
                                 @"🍹": @":tropical_drink:",
                                 @"🎺": @":trumpet:",
                                 @"📺": @":tv:",
                                 @"🔓": @":unlock:",
                                 @"📼": @":vhs:",
                                 @"📹": @":video_camera:",
                                 @"🎮": @":video_game:",
                                 @"🎻": @":violin:",
                                 @"⌚": @":watch:",
                                 @"🍉": @":watermelon:",
                                 @"🍷": @":wine_glass:",
                                 @"👚": @":womans_clothes:",
                                 @"👒": @":womans_hat:",
                                 @"🔧": @":wrench:",
                                 @"💴": @":yen:",
                                 @"🚡": @":aerial_tramway:",
                                 @"✈": @":airplane:",
                                 @"🚑": @":ambulance:",
                                 @"⚓": @":anchor:",
                                 @"🚛": @":articulated_lorry:",
                                 @"🏧": @":atm:",
                                 @"🏦": @":bank:",
                                 @"💈": @":barber:",
                                 @"🔰": @":beginner:",
                                 @"🚲": @":bike:",
                                 @"🚙": @":blue_car:",
                                 @"⛵": @":boat:",
                                 @"🌉": @":bridge_at_night:",
                                 @"🚅": @":bullettrain_front:",
                                 @"🚄": @":bullettrain_side:",
                                 @"🚌": @":bus:",
                                 @"🚏": @":busstop:",
                                 @"🚗": @":car:",
                                 @"🎠": @":carousel_horse:",
                                 @"🏁": @":checkered_flag:",
                                 @"⛪": @":church:",
                                 @"🎪": @":circus_tent:",
                                 @"🌇": @":city_sunrise:",
                                 @"🌆": @":city_sunset:",
                                 @"🚧": @":construction:",
                                 @"🏪": @":convenience_store:",
                                 @"🎌": @":crossed_flags:",
                                 @"🏬": @":department_store:",
                                 @"🏰": @":european_castle:",
                                 @"🏤": @":european_post_office:",
                                 @"🏭": @":factory:",
                                 @"🎡": @":ferris_wheel:",
                                 @"🚒": @":fire_engine:",
                                 @"⛲": @":fountain:",
                                 @"⛽": @":fuelpump:",
                                 @"🚁": @":helicopter:",
                                 @"🏥": @":hospital:",
                                 @"🏨": @":hotel:",
                                 @"♨": @":hotsprings:",
                                 @"🏠": @":house:",
                                 @"🏡": @":house_with_garden:",
                                 @"🗾": @":japan:",
                                 @"🏯": @":japanese_castle:",
                                 @"🚈": @":light_rail:",
                                 @"🏩": @":love_hotel:",
                                 @"🚐": @":minibus:",
                                 @"🚝": @":monorail:",
                                 @"🗻": @":mount_fuji:",
                                 @"🚠": @":mountain_cableway:",
                                 @"🚞": @":mountain_railway:",
                                 @"🗿": @":moyai:",
                                 @"🏢": @":office:",
                                 @"🚘": @":oncoming_automobile:",
                                 @"🚍": @":oncoming_bus:",
                                 @"🚔": @":oncoming_police_car:",
                                 @"🚖": @":oncoming_taxi:",
                                 @"🎭": @":performing_arts:",
                                 @"🚓": @":police_car:",
                                 @"🏣": @":post_office:",
                                 @"🚃": @":railway_car:",
                                 @"🌈": @":rainbow:",
                                 @"🚀": @":rocket:",
                                 @"🎢": @":roller_coaster:",
                                 @"🚨": @":rotating_light:",
                                 @"📍": @":round_pushpin:",
                                 @"🚣": @":rowboat:",
                                 @"🏫": @":school:",
                                 @"🚢": @":ship:",
                                 @"🎰": @":slot_machine:",
                                 @"🚤": @":speedboat:",
                                 @"🌠": @":stars:",
                                 @"🌃": @":city-night:",
                                 @"🚉": @":station:",
                                 @"🗽": @":statue_of_liberty:",
                                 @"🚂": @":steam_locomotive:",
                                 @"🌅": @":sunrise:",
                                 @"🌄": @":sunrise_over_mountains:",
                                 @"🚟": @":suspension_railway:",
                                 @"🚕": @":taxi:",
                                 @"⛺": @":tent:",
                                 @"🎫": @":ticket:",
                                 @"🗼": @":tokyo_tower:",
                                 @"🚜": @":tractor:",
                                 @"🚥": @":traffic_light:",
                                 @"🚆": @":train2:",
                                 @"🚊": @":tram:",
                                 @"🚩": @":triangular_flag_on_post:",
                                 @"🚎": @":trolleybus:",
                                 @"🚚": @":truck:",
                                 @"🚦": @":vertical_traffic_light:",
                                 @"⚠": @":warning:",
                                 @"💒": @":wedding:",
                                 @"🇯🇵": @":jp:",
                                 @"🇰🇷": @":kr:",
                                 @"🇨🇳": @":cn:",
                                 @"🇺🇸": @":us:",
                                 @"🇫🇷": @":fr:",
                                 @"🇪🇸": @":es:",
                                 @"🇮🇹": @":it:",
                                 @"🇷🇺": @":ru:",
                                 @"🇬🇧": @":gb:",
                                 @"🇩🇪": @":de:",
                                 @"💯": @":100:",
                                 @"🔢": @":1234:",
                                 @"🅰": @":a:",
                                 @"🆎": @":ab:",
                                 @"🔤": @":abc:",
                                 @"🔡": @":abcd:",
                                 @"🉑": @":accept:",
                                 @"♒": @":aquarius:",
                                 @"♈": @":aries:",
                                 @"◀": @":arrow_backward:",
                                 @"⏬": @":arrow_double_down:",
                                 @"⏫": @":arrow_double_up:",
                                 @"⬇": @":arrow_down:",
                                 @"🔽": @":arrow_down_small:",
                                 @"▶": @":arrow_forward:",
                                 @"⤵": @":arrow_heading_down:",
                                 @"⤴": @":arrow_heading_up:",
                                 @"⬅": @":arrow_left:",
                                 @"↙": @":arrow_lower_left:",
                                 @"↘": @":arrow_lower_right:",
                                 @"➡": @":arrow_right:",
                                 @"↪": @":arrow_right_hook:",
                                 @"⬆": @":arrow_up:",
                                 @"↕": @":arrow_up_down:",
                                 @"🔼": @":arrow_up_small:",
                                 @"↖": @":arrow_upper_left:",
                                 @"↗": @":arrow_upper_right:",
                                 @"🔃": @":arrows_clockwise:",
                                 @"🔄": @":arrows_counterclockwise:",
                                 @"🅱": @":b:",
                                 @"🚼": @":baby_symbol:",
                                 @"🛄": @":baggage_claim:",
                                 @"☑": @":ballot_box_with_check:",
                                 @"‼": @":bangbang:",
                                 @"⚫": @":black_circle:",
                                 @"🔲": @":black_square_button:",
                                 @"♋": @":cancer:",
                                 @"🔠": @":capital_abcd:",
                                 @"♑": @":capricorn:",
                                 @"💹": @":chart:",
                                 @"🚸": @":children_crossing:",
                                 @"🎦": @":cinema:",
                                 @"🆑": @":cl:",
                                 @"🕐": @":clock1:",
                                 @"🕙": @":clock10:",
                                 @"🕥": @":clock1030:",
                                 @"🕚": @":clock11:",
                                 @"🕦": @":clock1130:",
                                 @"🕛": @":clock12:",
                                 @"🕧": @":clock1230:",
                                 @"🕜": @":clock130:",
                                 @"🕑": @":clock2:",
                                 @"🕝": @":clock230:",
                                 @"🕒": @":clock3:",
                                 @"🕞": @":clock330:",
                                 @"🕓": @":clock4:",
                                 @"🕟": @":clock430:",
                                 @"🕔": @":clock5:",
                                 @"🕠": @":clock530:",
                                 @"🕕": @":clock6:",
                                 @"🕡": @":clock630:",
                                 @"🕖": @":clock7:",
                                 @"🕢": @":clock730:",
                                 @"🕗": @":clock8:",
                                 @"🕣": @":clock830:",
                                 @"🕘": @":clock9:",
                                 @"🕤": @":clock930:",
                                 @"㊗": @":congratulations:",
                                 @"🆒": @":cool:",
                                 @"©": @":copyright:",
                                 @"➰": @":curly_loop:",
                                 @"💱": @":currency_exchange:",
                                 @"🛃": @":customs:",
                                 @"💠": @":diamond_shape_with_a_dot_inside:",
                                 @"🚯": @":do_not_litter:",
                                 @"8⃣": @":eight:",
                                 @"✴": @":eight_pointed_black_star:",
                                 @"✳": @":eight_spoked_asterisk:",
                                 @"🔚": @":end:",
                                 @"⏩": @":fast_forward:",
                                 @"5⃣": @":five:",
                                 @"4⃣": @":four:",
                                 @"🆓": @":free:",
                                 @"♊": @":gemini:",
                                 @"#⃣": @":hash:",
                                 @"💟": @":heart_decoration:",
                                 @"✔": @":heavy_check_mark:",
                                 @"➗": @":heavy_division_sign:",
                                 @"💲": @":heavy_dollar_sign:",
                                 @"➖": @":heavy_minus_sign:",
                                 @"✖": @":heavy_multiplication_x:",
                                 @"➕": @":heavy_plus_sign:",
                                 @"🆔": @":id:",
                                 @"🉐": @":ideograph_advantage:",
                                 @"ℹ": @":information_source:",
                                 @"⁉": @":interrobang:",
                                 @"🔟": @":keycap_ten:",
                                 @"🈁": @":koko:",
                                 @"🔵": @":large_blue_circle:",
                                 @"🔷": @":large_blue_diamond:",
                                 @"🔶": @":large_orange_diamond:",
                                 @"🛅": @":left_luggage:",
                                 @"↔": @":left_right_arrow:",
                                 @"↩": @":leftwards_arrow_with_hook:",
                                 @"♌": @":leo:",
                                 @"♎": @":libra:",
                                 @"🔗": @":link:",
                                 @"Ⓜ": @":m:",
                                 @"🚹": @":mens:",
                                 @"🚇": @":metro:",
                                 @"📴": @":mobile_phone_off:",
                                 @"❎": @":negative_squared_cross_mark:",
                                 @"🆕": @":new:",
                                 @"🆖": @":ng:",
                                 @"9⃣": @":nine:",
                                 @"🚳": @":no_bicycles:",
                                 @"⛔": @":no_entry:",
                                 @"🚫": @":no_entry_sign:",
                                 @"📵": @":no_mobile_phones:",
                                 @"🚷": @":no_pedestrians:",
                                 @"🚭": @":no_smoking:",
                                 @"🚱": @":non-potable_water:",
                                 @"⭕": @":o:",
                                 @"🅾": @":o2:",
                                 @"🆗": @":ok:",
                                 @"🔛": @":on:",
                                 @"1⃣": @":one:",
                                 @"⛎": @":ophiuchus:",
                                 @"🅿": @":parking:",
                                 @"〽": @":part_alternation_mark:",
                                 @"🛂": @":passport_control:",
                                 @"♓": @":pisces:",
                                 @"🚰": @":potable_water:",
                                 @"🚮": @":put_litter_in_its_place:",
                                 @"🔘": @":radio_button:",
                                 @"♻": @":recycle:",
                                 @"🔴": @":red_circle:",
                                 @"®": @":registered:",
                                 @"🔁": @":repeat:",
                                 @"🔂": @":repeat_one:",
                                 @"🚻": @":restroom:",
                                 @"⏪": @":rewind:",
                                 @"🈂": @":sa:",
                                 @"♐": @":sagittarius:",
                                 @"♏": @":scorpius:",
                                 @"㊙": @":secret:",
                                 @"7⃣": @":seven:",
                                 @"📶": @":signal_strength:",
                                 @"6⃣": @":six:",
                                 @"🔯": @":six_pointed_star:",
                                 @"🔹": @":small_blue_diamond:",
                                 @"🔸": @":small_orange_diamond:",
                                 @"🔺": @":small_red_triangle:",
                                 @"🔻": @":small_red_triangle_down:",
                                 @"🔜": @":soon:",
                                 @"🆘": @":sos:",
                                 @"🔣": @":symbols:",
                                 @"♉": @":taurus:",
                                 @"3⃣": @":three:",
                                 @"™": @":tm:",
                                 @"🔝": @":top:",
                                 @"🔱": @":trident:",
                                 @"🔀": @":twisted_rightwards_arrows:",
                                 @"2⃣": @":two:",
                                 @"🈹": @":u5272:",
                                 @"🈴": @":u5408:",
                                 @"🈺": @":u55b6:",
                                 @"🈯": @":u6307:",
                                 @"🈷": @":u6708:",
                                 @"🈶": @":u6709:",
                                 @"🈵": @":u6e80:",
                                 @"🈚": @":u7121:",
                                 @"🈸": @":u7533:",
                                 @"🈲": @":u7981:",
                                 @"🈳": @":u7a7a:",
                                 @"🔞": @":underage:",
                                 @"🆙": @":up:",
                                 @"📳": @":vibration_mode:",
                                 @"♍": @":virgo:",
                                 @"🆚": @":vs:",
                                 @"〰": @":wavy_dash:",
                                 @"🚾": @":wc:",
                                 @"♿": @":wheelchair:",
                                 @"✅": @":white_check_mark:",
                                 @"⚪": @":white_circle:",
                                 @"💮": @":white_flower:",
                                 @"🔳": @":white_square_button:",
                                 @"🚺": @":womens:",
                                 @"❌": @":x:",
                                 @"0⃣": @":zero:",
                                 @"🙃": @":topple:",
                                 
                                 //update new in iOS 9.3
                                 @"🙂": @"",
                                 @"🤑": @"",
                                 @"🤓": @"",
                                 @"🤗": @"",
                                 @"🙄": @"",
                                 @"🤔": @"",
                                 @"🙁": @"",
                                 @"☹️": @"",
                                 @"🤐": @"",
                                 @"🤒": @"",
                                 @"🤕": @"",
                                 @"🤖": @"",
                                 @"🖕": @"",
                                 @"🖐": @"",
                                 @"🤘": @"",
                                 @"🖖": @"",
                                 @"👁": @"",
                                 @"🗣": @"",
                                 @"🕵": @"",
                                 @"⛑": @"",
                                 @"🕶": @"",
                                 @"🦁": @"",
                                 @"🦄": @"",
                                 @"🕷": @"",
                                 @"🦂": @"",
                                 @"🦀": @"",
                                 @"🦃": @"",
                                 @"🕊": @"",
                                 @"🐿": @"",
                                 @"☘": @"",
                                 @"🕸": @"",
                                 @"🌤": @"",
                                 @"⭐": @"",
                                 @"🌥": @"",
                                 @"🌦": @"",
                                 @"🌧": @"",
                                 @"⛈": @"",
                                 @"🌩": @"",
                                 @"🌨": @"",
                                 @"🌪": @"",
                                 @"🌫": @"",
                                 @"🌶": @"",
                                 @"🧀": @"",
                                 @"🌭": @"",
                                 @"🌮": @"",
                                 @"🌯": @"",
                                 @"🍿": @"",
                                 @"🍾": @"",
                                 @"🏌": @"",
                                 @"🏓": @"",
                                 @"🏸": @"",
                                 @"🏒": @"",
                                 @"🏑": @"",
                                 @"🏏": @"",
                                 @"⛷": @"",
                                 @"⛸": @"",
                                 @"🏹": @"",
                                 @"⛹": @"",
                                 @"🏋": @"",
                                 @"🕴": @"",
                                 @"🏅": @"",
                                 @"🎖": @"",
                                 @"🎗": @"",
                                 @"🏵": @"",
                                 @"🎟": @"",
                                 @"👟": @"",
                                 @"🌬": @"",
                                 @"🍽": @"",
                                 @"🏐": @"",
                                 @"🏎": @"",
                                 @"🏍": @"",
                                 @"🚋": @"",
                                 @"🛫": @"",
                                 @"🛬": @"",
                                 @"⛴": @"",
                                 @"🛳": @"",
                                 @"🛰": @"",
                                 @"🏗": @"",
                                 @"⛰": @"",
                                 @"🏔": @"",
                                 @"🏕": @"",
                                 @"🏞": @"",
                                 @"🛣": @"",
                                 @"🛤": @"",
                                 @"🏜": @"",
                                 @"🏖": @"",
                                 @"🏝": @"",
                                 @"🏙": @"",
                                 @"🏘": @"",
                                 @"🏟": @"",
                                 @"🏚": @"",
                                 @"🏛": @"",
                                 @"🕌": @"",
                                 @"🕍": @"",
                                 @"🕋": @"",
                                 @"⛩": @"",
                                 @"⌨": @"",
                                 @"🖥": @"",
                                 @"🖨": @"",
                                 @"🖱": @"",
                                 @"🖲": @"",
                                 @"🕹": @"",
                                 @"🗜": @"",
                                 @"📸": @"",
                                 @"🎞": @"",
                                 @"🎙": @"",
                                 @"🎚": @"",
                                 @"🎛": @"",
                                 @"⏱": @"",
                                 @"⏲": @"",
                                 @"🕰": @"",
                                 @"🕯": @"",
                                 @"🗑": @"",
                                 @"🛢": @"",
                                 @"⚒": @"",
                                 @"🛠": @"",
                                 @"⛏": @"",
                                 @"⛓": @"",
                                 @"🗡": @"",
                                 @"⚔": @"",
                                 @"🛡": @"",
                                 @"☠": @"",
                                 @"⚰": @"",
                                 @"⚱": @"",
                                 @"🏺": @"",
                                 @"📿": @"",
                                 @"⚗": @"",
                                 @"🕳": @"",
                                 @"🌡": @"",
                                 @"🏷": @"",
                                 @"🗝": @"",
                                 @"🛋": @"",
                                 @"🛌": @"",
                                 @"🛏": @"",
                                 @"🛎": @"",
                                 @"🖼": @"",
                                 @"🗺": @"",
                                 @"⛱": @"",
                                 @"🛍": @"",
                                 @"📩": @"",
                                 @"📦": @"",
                                 @"🗓": @"",
                                 @"🗃": @"",
                                 @"🗳": @"",
                                 @"🗄": @"",
                                 @"🗒": @"",
                                 @"🗂": @"",
                                 @"🗞": @"",
                                 @"📖": @"",
                                 @"🖇": @"",
                                 @"🏳": @"",
                                 @"🏴": @"",
                                 @"🖊": @"",
                                 @"🖋": @"",
                                 @"🖍": @"",
                                 @"🖌": @"",
                                 @"☮": @"",
                                 @"✝": @"",
                                 @"☪": @"",
                                 @"🕉": @"",
                                 @"☸": @"",
                                 @"✡": @"",
                                 @"🕎": @"",
                                 @"☯": @"",
                                 @"☦": @"",
                                 @"🛐": @"",
                                 @"⚛": @"",
                                 @"⚜": @"",
                                 @"0️⃣": @"",
                                 @"1️⃣": @"",
                                 @"2️⃣": @"",
                                 @"3️⃣": @"",
                                 @"4️⃣": @"",
                                 @"5️⃣": @"",
                                 @"6️⃣": @"",
                                 @"7️⃣": @"",
                                 @"8️⃣": @"",
                                 @"9️⃣": @"",
                                 @"⏸": @"",
                                 @"⏯": @"",
                                 @"⏹": @"",
                                 @"⏺": @"",
                                 @"⏭": @"",
                                 @"⏮": @"",
                                 @"#️⃣": @"",
                                 @"*️⃣": @"",
                                 @"🔙": @"",
                                 @"⬛": @"",
                                 @"⬜": @"",
                                 @"🔈": @"",
                                 @"🗨": @"",
                                 @"🗯": @"",
                                 @"🇭🇰": @"",
                                 @"🇲🇴": @"",
                                 @"🇦🇱": @"",
                                 @"🇩🇿": @"",
                                 @"🇦🇫": @"",
                                 @"🇦🇷": @"",
                                 @"🇦🇪": @"",
                                 @"🇦🇼": @"",
                                 @"🇴🇲": @"",
                                 @"🇦🇿": @"",
                                 @"🇪🇬": @"",
                                 @"🇪🇹": @"",
                                 @"🇮🇪": @"",
                                 @"🇪🇪": @"",
                                 @"🇦🇩": @"",
                                 @"🇦🇴": @"",
                                 @"🇦🇮": @"",
                                 @"🇦🇬": @"",
                                 @"🇦🇹": @"",
                                 @"🇦🇽": @"",
                                 @"🇦🇺": @"",
                                 @"🇧🇧": @"",
                                 @"🇵🇬": @"",
                                 @"🇵🇰": @"",
                                 @"🇵🇾": @"",
                                 @"🇸🇧": @"",
                                 @"🇧🇭": @"",
                                 @"🇵🇦": @"",
                                 @"🇧🇾": @"",
                                 @"🇧🇷": @"",
                                 @"🇧🇲": @"",
                                 @"🇬🇲": @"",
                                 @"🇲🇵": @"",
                                 @"": @"",//国旗的有待更新。敬请期待哦
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"": @"",
                                 @"\U0000200D": @"",//特殊处理,👩‍❤️‍👩这个女女以及其他男男等特殊emoji
                                 
                                 
                                 //by Vbon haha 对于肤色的特殊处理！
                                 //here is emoji color unicode sinces iOS8.3
                                 //default is not containt color unicode which look like yellow color sinces iOS8.3
                                 //Before iOS8.3 emoji is no color unicode containt and look like white color.
                                 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.3 ? @"🏻" : @""): @":skinColor1:",//white             --> Unicode: U+1F3FB
                                 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.3 ? @"🏼" : @""): @":skinColor2:",//white&littleBrown --> Unicode: U+1F3FC
                                 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.3 ? @"🏽" : @""): @":skinColor3:",//white&deepBrown   --> Unicode: U+1F3FD
                                 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.3 ? @"🏾" : @""): @":skinColor4:",//brown             --> Unicode: U+1F3FE
                                 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.3 ? @"🏿" : @""): @":skinColor5:" //black             --> Unicode: U+1F3FF
                                 };
    
    NSMutableDictionary *reversedMap = [NSMutableDictionary dictionaryWithCapacity:[forwardMap count]];
    [forwardMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            for (NSString *object in obj) {
                [reversedMap setObject:key forKey:object];
            }
        } else {
            [reversedMap setObject:key forKey:obj];
        }
    }];
    
    @synchronized(self) {
        s_unicodeToCheatCodes = forwardMap;
        s_cheatCodesToUnicode = [reversedMap copy];
    }
}

//字符转emoji
- (NSString *)andy_stringByReplacingEmojiCheatCodesWithUnicode
{
    if (!s_cheatCodesToUnicode) {
        [NSString initializeEmojiCheatCodes];
    }
    
    if ([self rangeOfString:@":"].location != NSNotFound) {
        __block NSMutableString *newText = [NSMutableString stringWithString:self];
        [s_cheatCodesToUnicode enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            [newText replaceOccurrencesOfString:key withString:obj options:NSLiteralSearch range:NSMakeRange(0, newText.length)];
        }];
        
        if ([self rangeOfString:@":"].location != NSNotFound) {//替换
            NSString *regex = @":[^:]+:";
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:nil];
            newText = (NSMutableString *)[regularExpression stringByReplacingMatchesInString:newText options:0 range:NSMakeRange(0, newText.length) withTemplate:@""];
        }
        
        
        return newText;
    }
    
    return self;
}

//emoji转字符
- (NSString *)andy_stringByReplacingEmojiUnicodeWithCheatCodes
{
    if (!s_cheatCodesToUnicode) {
        [NSString initializeEmojiCheatCodes];
    }
    
    if (self.length) {
        __block NSMutableString *newText = [NSMutableString stringWithString:self];
        [s_unicodeToCheatCodes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *string = ([obj isKindOfClass:[NSArray class]] ? [obj firstObject] : obj);
            [newText replaceOccurrencesOfString:key withString:string options:NSLiteralSearch range:NSMakeRange(0, newText.length)];
        }];
        
        return newText;
    }
    return self;
}

- (CGSize)andy_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    return ([self andy_sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping]);
}

- (CGSize)andy_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSInteger)lineBreakMode
{
    return ([self andy_sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:lineBreakMode]);
}

- (CGSize)andy_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return ([self andy_sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping]);
}

- (CGSize)andy_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSInteger)lineBreakMode
{
#ifdef __IPHONE_7_0
    return ([self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size);
#else
    return ([self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreak]);
#endif
}


@end

@implementation NSString (ParametersSafe)

- (instancetype)andy_safe_initWithString:(NSString *)aString
{
    if (aString == nil || [aString isKindOfClass:[NSNull class]])
    {
        return [self initWithString:@""];
    }
    
    return [self initWithString:aString];
}

- (NSString *)andy_safe_substringToIndex:(NSInteger)to
{
    if (to <= 0)
    {
        return @"";
    }
    
    if (to >= self.length)
    {
        return self;
    }
    
    return [self substringToIndex:to];
}

- (NSString *)andy_safe_substringFromIndex:(NSInteger)from
{
    if (from <= 0)
    {
        return self;
    }
    
    if (from >= self.length)
    {
        return @"";
    }
    
    return [self substringFromIndex:from];
}

@end

@implementation NSAttributedString (Andy)

- (NSAttributedString *)andy_adjustlineSpace:(float)space
{
    NSMutableAttributedString *attribute  = [[NSMutableAttributedString alloc]initWithAttributedString:self];//创建一个可变属性文本对象
    NSMutableParagraphStyle *paragraph =[[NSMutableParagraphStyle alloc]init];//创建一个段落对象
    [paragraph setLineSpacing:space];//设置段落属性
    [paragraph setLineBreakMode:NSLineBreakByTruncatingTail];
    [attribute addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, self.length)];//为属性文本添加属性
    return attribute;
}

@end
