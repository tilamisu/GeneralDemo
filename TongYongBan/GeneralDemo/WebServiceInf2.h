//
//  HttpTool.h
//  Schedule
//
//  Created by fhit123 on 15/9/22.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceInf2 : NSObject

typedef void(^HttpSuccess)(id json);
typedef void(^HttpFailure)(NSError *error);

typedef void(^uploadProgress)(NSProgress *progess);
typedef void(^uploadRP)(NSHTTPURLResponse *response);

typedef void(^requestURL)(id json,NSString *requestURL);

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params andBool:(BOOL)isAddHeader success:(HttpSuccess)success failure:(HttpFailure)failure;

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params andBool:(BOOL)isAddHeader success:(HttpSuccess)success failure:(HttpFailure)failure;

+ (void)putWithURL:(NSString *)url params:(NSDictionary *)params andBool:(BOOL)isAddHeader success:(HttpSuccess)success failure:(HttpFailure)failure;

+ (void)deleteWithURL:(NSString *)url params:(NSDictionary *)params andBool:(BOOL)isAddHeader success:(HttpSuccess)success failure:(HttpFailure)failure;

+ (void)downloadFileWithNSURL:(NSURL *)url
              savedFolderPath:(NSString*)savedFolderPath
              downloadSuccess:(void (^)(id responseObject))success
              downloadFailure:(void (^)(NSError *error))failure
                     progress:(void (^)(float progress))progress;

//导入证书
+ (AFSecurityPolicy*) customSecurityPolicy;

@end
