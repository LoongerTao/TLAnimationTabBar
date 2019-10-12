//
//  UITabBar+TLAnimation.h
//  TabBar
//
//  Created by 故乡的云 on 2019/7/19.
//  Copyright © 2019 故乡的云. All rights reserved.
//
//  如果是深度自定义 TabBarItem 请自行修改UITabBar+TLAnimation.m中的方法进行适配

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (TLAnimation)

@property(nonatomic, strong, readonly) NSArray *btns;
@property(nonatomic, assign, readonly) NSUInteger selectedIndex;

/** Tips1:
 * 如有需要，子类中可以`- (void)tl_didAddSubview:(UIView *)subview`代替`
 * - (void)didAddSubview:(UIView *)subview`方法
 
- (void)didAddSubview:(UIView *)subview;
 
 */

/** Tips2:
 * 如需要监听TabBarItem的点击事件，可在UITabBarController的子类(UITabBar实例的默认代理)中实现UITabBar的代理方法
 * `- tabBar: didSelectItem:`
 */

@end

NS_ASSUME_NONNULL_END
