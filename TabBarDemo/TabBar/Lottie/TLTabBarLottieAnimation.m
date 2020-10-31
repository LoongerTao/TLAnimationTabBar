//
//  TLTabBarLottieAnimation.m
//  TabBar
//
//  Created by Gxdy on 2020/9/10.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import "TLTabBarLottieAnimation.h"
#import "TLLottieAnimationView.h"

@implementation TLTabBarLottieAnimation

+ (instancetype)animationWithAnimationName:(NSString *_Nonnull)animationName {
    return [self animationWithSelectedAnimationName:animationName deselectedAnimationName:nil];
}

+ (instancetype)animationWithAnimationName:(NSString *_Nonnull)animationName lottieSize:(CGSize)size {
    TLTabBarLottieAnimation *animtion = [self animationWithSelectedAnimationName:animationName
                                                         deselectedAnimationName:nil];
    animtion.size = size;
    return animtion;
}

+ (instancetype)animationWithSelectedAnimationName:(NSString *_Nonnull)selectedAnimationName
                           deselectedAnimationName:(NSString *_Nullable)desselectedAnimationName {
    return [self animationWithSelectedAnimationNameOfLight:selectedAnimationName
                               selectedAnimationNameOfDark:selectedAnimationName
                            deselectedAnimationNameOfLight:desselectedAnimationName
                             deselectedAnimationNameOfDark:desselectedAnimationName];
}

+ (instancetype)animationWithSelectedAnimationNameOfLight:(NSString *_Nonnull)selectedAnimationNameOfLight
                              selectedAnimationNameOfDark:(NSString *_Nullable)selectedAnimationNameOfDark
                           deselectedAnimationNameOfLight:(NSString *_Nullable)deselectedAnimationNameOfLight
                            deselectedAnimationNameOfDark:(NSString *_Nullable)deselectedAnimationNameOfDark {
    TLTabBarLottieAnimation *animtion = [[self alloc] init];
    animtion.size = CGSizeMake(25, 25);
    animtion.selectedAnimationSpeed = 1;
    animtion.deselectedAnimationSpeed = 2;
    animtion.selectedBeginProgress = 0;
    animtion.selectedEndProgress = 1;
    animtion.deselectedBeginProgress = 1;
    animtion.deselectedEndProgress = 0;
    animtion.selectedAnimationName = selectedAnimationNameOfLight;
    animtion.selectedAnimationNameOfDark = selectedAnimationNameOfDark;
    animtion.deselectedAnimationName = deselectedAnimationNameOfDark;
    animtion.deselectedAnimationNameOfDark = deselectedAnimationNameOfDark;
    return animtion;
}

/**
 UITabBarItem选中动画, UITabBarItem 被选中时调用
 
 @param button              UITabBarItem 的按钮: 真实类型UITabBarButton
 @param imageView       tabBarButton的_info（imageView）属性
 @param textLabel       tabBarButton的_label属性
 */
- (void)playSelectAnimationWhitTabBarButton:(UIView *)button
                            buttonImageView:(UIImageView *)imageView
                            buttonTextLabel:(UILabel *)textLabel {
    NSString *animationName = [self animationNameOfSelect];
    [self playAnimationWithName:animationName
                   fromProgress:_selectedBeginProgress
                     toProgress:_selectedEndProgress
                 animationSpeed:_selectedAnimationSpeed
                    inSuperView:textLabel ? imageView : button];
}


/**
 UITabBarItem撤销选中动画, UITabBarItem 被选中时调用
 
 @param button              UITabBarItem 的按钮: 真实类型UITabBarButton
 @param imageView        tabBarButton的_info（imageView）属性
 @param textLabel        tabBarButton的_label属性
 */
- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel {
    NSString *animationName = [self animationNameOfDeselect];
    [self playAnimationWithName:animationName
                   fromProgress:_deselectedBeginProgress
                     toProgress:_deselectedEndProgress
                 animationSpeed:_deselectedAnimationSpeed
                    inSuperView:textLabel ? imageView : button];
}

/**
 UITabBarItem进行动画预置, UITabBarItem 被添加到tabbar上时调用
 
 @param button               UITabBarItem 的按钮: 真实类型UITabBarButton
 @param imageView        tabBarButton的_info（imageView）属性
 @param textLabel        tabBarButton的_label属性
 @param isSelected      UITabBarItem是否被选中
 */
- (void)presetAnimationWhitTabBarButton:(UIView *)button
                        buttonImageView:(UIImageView *)imageView
                        buttonTextLabel:(UILabel *)textLabel
                             isSelected:(BOOL)isSelected {
    NSString *animationName = isSelected ? [self animationNameOfSelect] : [self animationNameOfDeselect];
    [self playAnimationWithName:animationName ? : [self animationNameOfSelect]
                   fromProgress:animationName ? 1: 0
                     toProgress:animationName ? 1: 0
                 animationSpeed:isSelected ? _selectedAnimationSpeed : _deselectedAnimationSpeed
                    inSuperView:(!textLabel || !imageView) ? button : imageView];
}

- (void)playAnimationWithName:(NSString *)animationName
                 fromProgress:(CGFloat)fromStartProgress
                   toProgress:(CGFloat)toEndProgress
               animationSpeed:(CGFloat)speed
                  inSuperView:(UIView *)superView {
    NSInteger tag = 10;
    TLLottieAnimationView *animationView = [superView viewWithTag:tag];
   
    if (animationView) {
        [animationView playWithAnimationNamed:animationName
                                 fromProgress:fromStartProgress
                                   toProgress:toEndProgress
                               animationSpeed:speed
                                   completion:^(BOOL animationFinished) {
            // ...
        }];
        
    }else {
        animationView = [TLLottieAnimationView viewWithAnimationNamed:animationName];
        animationView.tag = tag;
        [superView addSubview:animationView];
        [animationView playWithAnimationNamed:animationName
                                 fromProgress:fromStartProgress
                                   toProgress:toEndProgress
                               animationSpeed:speed
                                   completion:^(BOOL animationFinished) {
            // ...
        }];
        if (self.size.width) {
            animationView.frame = CGRectMake(0, 0, _size.width, _size.height);
        }else {
            animationView.frame = superView.bounds;
        }
        animationView.center = CGPointMake(CGRectGetMidX(superView.bounds), CGRectGetMidY(superView.bounds));
    }
}



- (NSString *)animationNameOfSelect {
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
            return self.selectedAnimationNameOfDark ? : self.selectedAnimationName;
        }else {
            return self.selectedAnimationName;
        }
    }
    
    return self.selectedAnimationName;
}

- (NSString *)animationNameOfDeselect {
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
            return self.deselectedAnimationNameOfDark ? : self.deselectedAnimationName;
        }else {
            return self.deselectedAnimationName;
        }
    }
    
    return self.deselectedAnimationName;
}
@end
