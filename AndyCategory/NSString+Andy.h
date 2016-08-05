//
//  NSString+Andy.h
//  AndyCategory_Test
//
//  Created by 李扬 on 16/8/4.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Andy)

//对比两个字符串内容是否一致
- (BOOL)andy_equals:(NSString*) string;

//判断字符串是否以指定的前缀开头
- (BOOL)andy_startsWith:(NSString*)prefix;

//判断字符串是否以指定的后缀结束
- (BOOL)andy_endsWith:(NSString*)suffix;

//转换成大写
- (NSString *)andy_toLowerCase;

//转换成小写
- (NSString *)andy_toUpperCase;

//截取字符串前后空格
- (NSString *)andy_trim;

//用指定分隔符将字符串分割成数组
- (NSArray *)andy_split:(NSString*) separator;

//用指定字符串替换原字符串
- (NSString *)andy_replaceAll:(NSString*)oldStr with:(NSString*)newStr;

//从指定的开始位置和结束位置开始截取字符串
- (NSString *)andy_substringFromIndex:(int)begin toIndex:(int)end;

/**
 *  md5加密
 */
- (NSString*)andy_md5HexDigest;

- (NSString *)andy_UTF8String;

//正则ip地址
- (BOOL)andy_isValidIPAdddress;

// 正则匹配邮箱号
- (BOOL)andy_isValidMailInput;
// 正则匹配手机号
- (BOOL)andy_isValidTelNumber;
// 正则匹配用户密码6-18位数字和字母组合
- (BOOL)andy_isValidPassword;
// 正则匹配用户姓名,20位的中文或英文
- (BOOL)andy_isValidUserName;
// 正则匹配用户身份证号
- (BOOL)andy_isValidUserIdCard;
// 正则匹员工号,12位的数字
- (BOOL)andy_isValidEmployeeNumber;
// 正则匹配URL
- (BOOL)andy_isValidURL;
// 正则匹配昵称
- (BOOL)andy_isValidNickname;
// 正则只能输入数字和字母
- (BOOL)andy_isValidOnlyCharAndNumber;
// 车牌号验证
- (BOOL)andy_isValidCarNumber;


/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)andy_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (NSString *)andy_aes256_encrypt:(NSString *)key;
- (NSString *)andy_aes256_decrypt:(NSString *)key;


@end
