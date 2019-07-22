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

@optional
/**
 UITabBarItem撤销选中动画, UITabBarItem 被选中时调用
 
 - parameter button:         UITabBarItem 的按钮: 真实类型UITabBarButton
 - parameter imageView:      tabBarButton的_info（imageView）属性
 - parameter textLabel:      tabBarButton的_label属性
 */
- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel;

/** 选中当前Item时，上一个被选中的item的索引 小于当前选中的 item */
@property(nonatomic, assign, getter=isFromLeft) BOOL fromLeft;
/** 撤销选中当前Item时，下一个被选中的item的索引 大于当前选中的 item */
@property(nonatomic, assign, getter=isToRight) BOOL toRight;
@end

NS_ASSUME_NONNULL_END
