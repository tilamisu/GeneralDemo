//
//  DateManger.h
//  CloudInformation
//
//  Created by frank on 2017/3/28.
//  Copyright © 2017年 frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManger : NSObject



+ (instancetype)shareDataManger;

- (void)ClearData;

@end
