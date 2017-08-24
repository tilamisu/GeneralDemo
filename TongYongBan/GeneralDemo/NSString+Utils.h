//
//  NSString+Utils.h
//  CloudInformation
//
//  Created by frank on 2017/3/24.
//  Copyright © 2017年 frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

//获取文件大小
+(long long) fileSizeAtPath:(NSString*)filePath;

//url含有特殊字符
- (NSString *)URLEncodedString;

//SHA1编码
+  (NSString *)HMacHashWithKey:(NSString *)key data:(NSString *)data;

//生成当前时间错

+ (NSString *)getNowGMTDate;

//根据域名 动态获取ip地址
+ (NSString*)getIPWithHostName:(const NSString*)hostName;

/**
 *  汉字的拼音
 *
 *  @return 拼音
 */
- (NSString *)pinyin;

//构造请求头
+ (NSString *)addAFNHeader;

//编码
+(NSString*)base64Encode:(NSString *)string;

//解码
+ (NSData *)base64DecodedString:(NSString *)string;

+ (BOOL)saveDataLocation:(NSDictionary *)dict andFileName:(NSString *)filename
;//存储

+ (NSDictionary *)loadDataFromLocation:(NSString *)fileN
;//获取

+ (NSString *)getDBPath:(NSString *)filename;


@end
