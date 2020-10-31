//
//  UIImage+TLExt.h
//  TabBar
//
//  Created by 故乡的云 on 2020/10/30.
//  Copyright © 2020 故乡的云. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (TLExt)
/// 返回一张指定size的指定颜色的纯色图片
+ (UIImage *)tl_imageWithColor:(UIColor *)color size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
