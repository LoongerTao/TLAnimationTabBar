//
//  TLTabBarAnimation.h
//  TabBar
//
//  Copyright © 2019 故乡的云. All rights reserved.
//
//  动画是从https://github.com/Ramotion/animated-tab-bar项目转换而来


#import "TLAnimationProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/** 弹性动画 */
@interface TLBounceAnimation : NSObject <TLAnimationProtocol>
@end

/** 仿烟动画 */
@interface TLFumeAnimation : NSObject <TLAnimationProtocol>
@end

/** 旋转动画 */
@interface TLRotationAnimation : NSObject <TLAnimationProtocol>
@end

/** 贞动画 */
@interface TLFrameAnimation : NSObject <TLAnimationProtocol>
@property(nonatomic, strong) NSArray <CIImage *>*images;
@end


/** 转场动画 */
@interface TLTransitionAniamtion : NSObject <TLAnimationProtocol>
/** direction 翻转方向, 取值1-6，默认1
 * UIViewAnimationOptionTransitionFlipFromLeft    = 1,
 * UIViewAnimationOptionTransitionFlipFromRight   = 2,
 * UIViewAnimationOptionTransitionFlipFromTop     = 3,
 * UIViewAnimationOptionTransitionFlipFromBottom  = 4,
 * UIViewAnimationOptionTransitionCurlUp          = 5,
 * UIViewAnimationOptionTransitionCurlDown        = 6,
 */
@property(nonatomic, assign) NSUInteger direction;
/// 不播放撤销选择动画， default ： NO
@property(nonatomic, assign) BOOL disableDeselectAnimation;
@end

NS_ASSUME_NONNULL_END
