//
//  TLTabBarLottieAnimation.h
//  TabBar
//
//  Created by Gxdy on 2020/9/10.
//  Copyright © 2020 故乡的云. All rights reserved.
//
// Ps: 当image或title为空时，lottie动画添加到tabbar item的button上，否则添加到imageView上

#import "TLAnimationProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLTabBarLottieAnimation : NSObject <TLAnimationProtocol>

// MARK: - 重要属性
/// 选中动画名称（亮色模式/通用）
@property(nonatomic, copy) NSString *selectedAnimationName;
/// 选中动画名称（暗色模式）
@property(nonatomic, copy) NSString *selectedAnimationNameOfDark;
/// 选中动画名称（亮色模式/通用）
@property(nonatomic, copy) NSString *deselectedAnimationName;
/// 选中动画名称（暗色模式）
@property(nonatomic, copy) NSString *deselectedAnimationNameOfDark;
/// Lottie View的size，默认 （25， 25）
@property(nonatomic, assign) CGSize size;

// MARK: - 次要属性
/// 选中时动画播放速度，默认1
@property(nonatomic, assign) CGFloat selectedAnimationSpeed;
/// 撤销选中动画播放速度,  默认2
@property(nonatomic, assign) CGFloat deselectedAnimationSpeed;
/// 选中动画播放开始播放进度,  默认0
@property(nonatomic, assign) CGFloat selectedBeginProgress;
/// 选中动画播放结束播放进度,  默认1
@property(nonatomic, assign) CGFloat selectedEndProgress;
/// 撤销选中动画播放开始播放进度,  默认1
@property(nonatomic, assign) CGFloat deselectedBeginProgress;
/// 撤销选中动画播放结束播放进度,  默认0
@property(nonatomic, assign) CGFloat deselectedEndProgress;

/// 创建Lottie动画对象
/// @param animationName 通用动画名称
+ (instancetype)animationWithAnimationName:(NSString *_Nonnull)animationName;

/// 创建Lottie动画对象
/// @param animationName 通用动画名称
/// @param size lottie view的size
+ (instancetype)animationWithAnimationName:(NSString *_Nonnull)animationName lottieSize:(CGSize)size;
                           

/// 创建Lottie动画对象
/// @param selectedAnimationName 选中动画名称
/// @param deselectedAnimationName 撤销选中动画名称
+ (instancetype)animationWithSelectedAnimationName:(NSString *_Nonnull)selectedAnimationName
                           deselectedAnimationName:(NSString *_Nullable)deselectedAnimationName;

/// 创建Lottie动画对象
/// @param selectedAnimationNameOfLight 选中动画名称（亮色模式）
/// @param selectedAnimationNameOfDark 选中动画名称（暗色模式）
/// @param deselectedAnimationNameOfLight 撤销选中动画名称（亮色模式）
/// @param deselectedAnimationNameOfDark 撤销动画名称（暗色模式）
+ (instancetype)animationWithSelectedAnimationNameOfLight:(NSString *_Nonnull)selectedAnimationNameOfLight
                              selectedAnimationNameOfDark:(NSString *_Nullable)selectedAnimationNameOfDark
                           deselectedAnimationNameOfLight:(NSString *_Nullable)deselectedAnimationNameOfLight
                            deselectedAnimationNameOfDark:(NSString *_Nullable)deselectedAnimationNameOfDark;
@end

NS_ASSUME_NONNULL_END
