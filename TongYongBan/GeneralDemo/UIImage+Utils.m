//
//  UIImage+Utils.m
//  CloudInformation
//
//  Created by frank on 2017/4/1.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)


+ (UIImage *)imageUserToCompressForSizeImage:(UIImage *)image newSize:(CGSize)size
{
    
    UIImage *newImage = nil;
    
    CGSize originalSize = image.size;//获取原始图片size
    
    CGFloat originalWidth = originalSize.width;//宽
    
    CGFloat originalHeight = originalSize.height;//高
    
    if ((originalWidth <= size.width) && (originalHeight <= size.height)) {
        
        newImage = image;//宽和高同时小于要压缩的尺寸时返回原尺寸
        
    }
    
    else{
        
        //新图片的宽和高
        
        CGFloat scale = (float)size.width/originalWidth < (float)size.height/originalHeight ? (float)size.width/originalWidth : (float)size.height/originalHeight;
        
        CGSize newImageSize = CGSizeMake(originalWidth*scale , originalHeight*scale );
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImageSize.width , newImageSize.height ), NO, 0);
        
        [image drawInRect:CGRectMake(0, 0, newImageSize.width, newImageSize.height) blendMode:kCGBlendModeNormal alpha:1.0];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        if (newImage == nil) {
            
            NSLog(@"image ");
            
        }
        
        UIGraphicsEndImageContext();
        
    }
    
    return newImage;
    
}

//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+ (UIImage *)clearImage:(BOOL)isMainColor
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(2, 2), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //添加外层半透明效果
    
    if (isMainColor) {
        //主色调
         CGContextSetRGBFillColor(context, 14.0/255.0, 75.0/255.0, 192.0/255.0, 1);
    }else{
        //透明
         CGContextSetRGBFillColor(context, 0, 0, 0, 0);
    }
   
    CGContextAddRect(context, CGRectMake(0, 0, 2, 2));
    CGContextFillPath(context);
    UIImage *clearImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clearImage;
}


@end
