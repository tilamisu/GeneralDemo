//
//  DateManger.m
//  CloudInformation
//
//  Created by frank on 2017/3/28.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "DateManger.h"

@implementation DateManger

static  DateManger *dataManger = nil;

+ (instancetype)shareDataManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManger = [[self alloc]init];
    });
    
    return dataManger;
}

- (void)ClearData
{
    
}

@end
