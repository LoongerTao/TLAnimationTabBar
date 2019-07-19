//
//  TLAnimationProtocol.h
//  TabBar
//
//  Created by 故乡的云 on 2019/7/19.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TLAnimationProtocol <NSObject>
@required
/**
 UITabBarItem选中动画, UITabBarItem 被选中时调用
 
 - parameter button:         UITabBarItem 的按钮: 真实类型UITabBarButton
 - parameter imageView:      tabBarButton的_info（imageView）属性
 - parameter textLabel:      tabBarButton的_label属性
 */
- (void)playSelectAnimationWhitTabBarButton:(UIView *)button
                            buttonImageView:(UIImageView *)imageView
                            buttonTextLabel:(UILabel *)textLabel;

/**
 UITabBarItem撤销选中动画, UITabBarItem 被选中时调用
 
 - parameter button:         UITabBarItem 的按钮: 真实类型UITabBarButton
 - parameter imageView:      tabBarButton的_info（imageView）属性
 - parameter textLabel:      tabBarButton的_label属性
 */
- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel;

@end

NS_ASSUME_NONNULL_END
