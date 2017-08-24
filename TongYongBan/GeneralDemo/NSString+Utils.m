//
//  NSString+Utils.m
//  CloudInformation
//
//  Created by frank on 2017/3/24.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "NSString+Utils.h"
#import  <netdb.h>
#import <sys/socket.h>
#import <arpa/inet.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Utils)


//获取文件大小
+(long long) fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager =[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil]fileSize];
    }
    
    return 0;
}

//url含有特殊字符
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

//SHA1编码
+  (NSString *)HMacHashWithKey:(NSString *)key data:(NSString *)data{
    
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    //CC_SHA1_DIGEST_LENGTH
    //关键部分
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    //    NSString *result = [[NSString alloc] initWithData:HMAC  encoding:NSUTF8StringEncoding];
    //将加密结果进行一次BASE64编码。
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];
    return hash;
}

//生成GMT时间

+ (NSString *)getNowGMTDate
{
    
//    NSDate *date = [NSDate date];
    
//    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"GMT"];
//    [NSTimeZone setDefaultTimeZone:tzGMT];
//    
//    NSDateFormatter *iosDateFormater=[[NSDateFormatter alloc]init];
//    
////    iosDateFormater.dateFormat=@"EEE, d MMM yyyy HH:mm:ss 'GMT'";
//    iosDateFormater.dateFormat = @"yyyy-MM-dd eeee aa HH:mm:ss";
//    
//    iosDateFormater.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
//    NSString *dateStr = [iosDateFormater stringFromDate:da];
//    return dateStr;
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒//拍摄时间
    
    NSString *result = [NSString stringWithFormat:@"%f",a];
    return result;
}

//根据域名 动态获取ip地址
+ (NSString*)getIPWithHostName:(const NSString*)hostName
{
    const char *hostN= [hostName UTF8String];
    struct hostent* phot;
    
    @try {
        phot = gethostbyname(hostN);
        if (phot == nil) {
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
    
    struct in_addr ip_addr;
    memcpy(&ip_addr, phot->h_addr_list[0], 4);
    char ip[20] = {0};
    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    
    NSString* strIPAddress = [NSString stringWithUTF8String:ip];
    //测试
//    strIPAddress = udpHost;
    
    return strIPAddress;
}


//汉字的拼音
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}


#pragma mark - Base64

// 编码：A => QQ==

//编码
+(NSString*)base64Encode:(NSString *)string{
    //1.将字符串转换成二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //2.利用ios7.0的方法，直接 base64 编码
    
    return [data base64EncodedStringWithOptions:0];
}
//解码
+ (NSData *)base64DecodedString:(NSString *)string
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    return data;
}

+ (NSString *)getDBPath:(NSString *)filename;
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [documentPath stringByAppendingPathComponent:filename];
    return dataPath;
}

+ (BOOL)saveDataLocation:(NSDictionary *)dict andFileName:(NSString *)filename
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"Dict"];
    [archiver finishEncoding];
    
    BOOL flag = [data writeToFile:[NSString getDBPath:filename] atomically:YES];
    return flag;
}

+ (NSDictionary *)loadDataFromLocation:(NSString *)fileN
{
    NSDictionary *respon;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString getDBPath:fileN]]) {
        NSData* data = [[NSMutableData alloc]initWithContentsOfFile:[NSString getDBPath:fileN]];
        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
         respon = [unarchiver decodeObjectForKey:@"Dict"];
        [unarchiver finishDecoding];
    }
    return respon;
}

//获取视图所在的控制器
//- (UIViewController *)findViewController:(UIView *)sourceView
//{
//    id target = sourceView;
//    while (target) {
//        target = ((UIResponder *)target).nextResponder;
//        if ([target isKindOfClass:[UIViewController class]]) {
//            break;
//        }
//    }
//    return target;
//}



@end
