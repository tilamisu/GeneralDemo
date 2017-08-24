//
//  NSObject+JSContextTracker.m
//  CloudInformation
//
//  Created by frank on 2017/5/18.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "NSObject+JSContextTracker.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation NSObject (JSContextTracker)

- (void)webView:(id)unused didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)alsoUnused {
    if (!ctx)
        return;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LLCreatJSContex" object:ctx];
}

@end

//SGM7150DMAA
//LSGPC52H8GF126642
//161583279
//6225768760961456
