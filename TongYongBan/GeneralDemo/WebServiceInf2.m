//
//  HttpTool.m
//  Schedule
//
//  Created by fhit123 on 15/9/22.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import "WebServiceInf2.h"

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

@implementation WebServiceInf2

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params andBool:(BOOL)isAddHeader success:(HttpSuccess)success failure:(HttpFailure)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.securityPolicy = [WebServiceInf2 customSecurityPolicy];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil, nil];
    
    if (isAddHeader) {
        NSString *dict = [NSString addAFNHeader];
        [manager.requestSerializer setValue:dict forHTTPHeaderField:@"Authorization"];
    }
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSString *result  =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"－－－－%@",error);
    }];
    
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params andBool:(BOOL)isAddHeader success:(HttpSuccess)success failure:(HttpFailure)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.securityPolicy=[WebServiceInf2 customSecurityPolicy];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (isAddHeader) {
        NSString *dict = [NSString addAFNHeader];
        [manager.requestSerializer setValue:dict forHTTPHeaderField:@"Authorization"];
    }
    
    NSLog(@"url:%@", url);
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
} 

+ (void)putWithURL:(NSString *)url params:(NSDictionary *)params andBool:(BOOL)isAddHeader success:(HttpSuccess)success failure:(HttpFailure)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.securityPolicy=[WebServiceInf2 customSecurityPolicy];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    if (isAddHeader) {
        NSString *dict = [NSString addAFNHeader];
        [manager.requestSerializer setValue:dict forHTTPHeaderField:@"Authorization"];
    }
    
    [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}
+ (void)deleteWithURL:(NSString *)url params:(NSDictionary *)params andBool:(BOOL)isAddHeader success:(HttpSuccess)success failure:(HttpFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy=[WebServiceInf2 customSecurityPolicy];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (isAddHeader) {
        NSString *dict = [NSString addAFNHeader];
        [manager.requestSerializer setValue:dict forHTTPHeaderField:@"Authorization"];
    }
    
    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}




+ (void)downloadFileWithNSURL:(NSURL *)url
               savedFolderPath:(NSString*)savedFolderPath
               downloadSuccess:(void (^)(id responseObject))success
               downloadFailure:(void (^)(NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    //远程地址
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        // 给Progress添加监听 KVO
//        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 进度
            if (progress) {
                progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            }
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        NSString *path = [savedFolderPath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@", path);
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //设置下载完成操作
        //         filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        dispatch_async(dispatch_get_main_queue(), ^{
            // 进度
            if (success) {
                success(response);
            }
        });
    }];
    [downloadTask resume];
}


+ (AFSecurityPolicy*) customSecurityPolicy
{
//    // /先导入证书
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"hgcang" ofType:@"cer"];//证书的路径
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    
//    // AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//
//    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//    // 如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
//    
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
//    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
//    //如置为NO，建议自己添加对应域名的校验逻辑。
//    securityPolicy.validatesDomainName = NO;
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    
    
    return securityPolicy;
}


@end
