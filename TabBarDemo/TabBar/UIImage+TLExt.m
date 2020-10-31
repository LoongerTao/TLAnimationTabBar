//
//  UIImage+TLExt.m
//  TabBar
//
//  Created by 故乡的云 on 2020/10/30.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import "UIImage+TLExt.h"



@implementation UIImage (TLExt)
/**
 *  返回一张指定size的指定颜色的纯色图片
 */
+ (UIImage *)tl_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (size.width <= 0  ) {
        size = CGSizeMake(3, 3);
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
