//
//  UITabBar+TLAnimation.h
//  TabBar
//
//  Created by 故乡的云 on 2019/7/19.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (TLAnimation)
@property(nonatomic, strong, readonly) NSArray *btns;
@property(nonatomic, assign, readonly) NSUInteger selectedIndex;

/** Tips:
 * 如有需要，子类中可以`- (void)tl_didAddSubview:(UIView *)subview`代替`
 * - (void)didAddSubview:(UIView *)subview`方法
 
- (void)didAddSubview:(UIView *)subview;
 
 */

@end

NS_ASSUME_NONNULL_END
