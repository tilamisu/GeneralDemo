//
//  UIImage+Utils.h
//  CloudInformation
//
//  Created by frank on 2017/4/1.
//  Copyright © 2017年 frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
//绘制一个像素的透明图片
+ (UIImage *)clearImage:(BOOL)isMainColor;
//尺寸压缩
+ (UIImage *)imageUserToCompressForSizeImage:(UIImage *)image newSize:(CGSize)size;

@end
