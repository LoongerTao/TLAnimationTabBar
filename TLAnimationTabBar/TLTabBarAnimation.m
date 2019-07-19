//
//  TLTabBarAnimation.m
//  TabBar
//
//  Created by 故乡的云 on 2019/7/19.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLTabBarAnimation.h"

#define kDuration  0.5f
#define  kAnimationKeyPathScale @"transform.scale"
#define  kAnimationKeyPathRotation @"transform.rotation"
#define  kAnimationKeyPathKeyFrame @"contents"
#define  kAnimationKeyPathPositionY @"position.y"
#define  kAnimationKeyPathOpacity @"opacity"

/// 创建CAKeyframeAnimation动画
CAKeyframeAnimation * createAnimation(NSString *keyPath, NSArray *values, CGFloat duration) {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.values = values;
    animation.duration = kDuration;
    animation.calculationMode = @"cubic";
    
    return animation;
}

/// 播放贞动画
void playFrameAnimation(UIImageView *icon, NSArray <CIImage *>*images) {
    CAKeyframeAnimation *animation = createAnimation(kAnimationKeyPathKeyFrame, images, kDuration);
    animation.calculationMode = @"discrete";
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [icon.layer addAnimation:animation forKey:nil];
}

/// 反转数组
NSArray *reversedArray(NSArray *arr) {
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSInteger i = arr.count-1; i >= 0; i--) {
        [temp addObject:arr[i]];
    }
    return [temp copy];
}


// MARK: - TLBounceAnimation 弹性动画
@implementation TLBounceAnimation

- (void)playSelectAnimationWhitTabBarButton:(UIView *)button
                            buttonImageView:(UIImageView *)imageView
                            buttonTextLabel:(UILabel *)textLabel
{
    CAKeyframeAnimation *bounceAnimation = createAnimation(kAnimationKeyPathScale, @[@1.0, @0.85, @1.15, @0.95, @1.02, @1.0], kDuration);
    [imageView.layer addAnimation:bounceAnimation forKey:nil];
}


- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel
{
    
}

@end


// MARK: - TLFumeAnimation 仿烟动画
@implementation TLFumeAnimation

- (void)playSelectAnimationWhitTabBarButton:(UIView *)button
                            buttonImageView:(UIImageView *)imageView
                            buttonTextLabel:(UILabel *)textLabel
{
    playMoveIconAnimation(imageView, @[@(imageView.center.y), @(imageView.center.y + 4.0)]);
    playSelectLabelAnimation(textLabel);
}


- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel
{
    playMoveIconAnimation(imageView,@[@(imageView.center.y + 4.0), @(imageView.center.y)]);
    playDeselectLabelAnimation(textLabel);
}

void playMoveIconAnimation(UIImageView *icon, NSArray *values) {
    
    CAKeyframeAnimation *animation = createAnimation(kAnimationKeyPathPositionY, values, kDuration / 2);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [icon.layer addAnimation:animation forKey:nil];
}

void playSelectLabelAnimation(UILabel *textLabel) {
    
    CAKeyframeAnimation *animation = createAnimation(kAnimationKeyPathPositionY, @[@(textLabel.center.y) , @(textLabel.center.y - 60.0)], kDuration);
    animation.fillMode = kCAFillModeRemoved;
    [textLabel.layer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation *scaleAnimation = createAnimation(kAnimationKeyPathScale, @[@1.0, @2.0], kDuration);
    scaleAnimation.fillMode = kCAFillModeRemoved;
    [textLabel.layer addAnimation:scaleAnimation forKey:nil];
    
    CAKeyframeAnimation * opacityAnimation = createAnimation(kAnimationKeyPathOpacity,@[@1.0, @0.0], kDuration);
    [textLabel.layer addAnimation:opacityAnimation forKey:nil];
    textLabel.alpha = 0;
}


void playDeselectLabelAnimation(UILabel *textLabel) {
    
    CAKeyframeAnimation *animation = createAnimation(kAnimationKeyPathPositionY, @[@(textLabel.center.y + 15), @(textLabel.center.y)], kDuration);
    [textLabel.layer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation * opacityAnimation = createAnimation(kAnimationKeyPathOpacity,@[@0.0, @1.0], kDuration);
    [textLabel.layer addAnimation:opacityAnimation forKey:nil];
    textLabel.alpha = 1;
}

@end


// MARK: - TLRotationAnimation 旋转动画
@implementation TLRotationAnimation

- (void)playSelectAnimationWhitTabBarButton:(UIView *)button
                            buttonImageView:(UIImageView *)imageView
                            buttonTextLabel:(UILabel *)textLabel
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:kAnimationKeyPathRotation];
    rotateAnimation.fromValue = @0.0;
    rotateAnimation.toValue = @(-M_PI * 2);
    rotateAnimation.duration = kDuration;
    
    [imageView.layer addAnimation:rotateAnimation forKey:nil];
}


- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel
{
    
}

@end



// MARK: - TLFrameAnimation Frame动画
@implementation TLFrameAnimation

- (void)playSelectAnimationWhitTabBarButton:(UIView *)button
                            buttonImageView:(UIImageView *)imageView
                            buttonTextLabel:(UILabel *)textLabel
{
    if (self.images.count > 0) {
        playFrameAnimation(imageView, self.images);
    }
}


- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel
{
    if (self.images.count > 0) {
        playFrameAnimation(imageView, reversedArray(self.images));
    }
}

@end



// MARK: - TLTransitionAniamtion 翻转动画
@implementation TLTransitionAniamtion
- (void)playSelectAnimationWhitTabBarButton:(UIView *)button
                            buttonImageView:(UIImageView *)imageView
                            buttonTextLabel:(UILabel *)textLabel
{
    if(self.direction <= 0) self.direction = 1;
    if(self.direction > 6) self.direction = 6;
    NSUInteger opts = [@[@1, @2, @6, @7, @3, @4][self.direction - 1] integerValue] << 20;
    [UIView transitionWithView:imageView duration:kDuration options:opts animations:nil completion:nil];
}

- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel
{
    if(_disableDeselectAnimation) return;
    
    NSUInteger index = self.direction % 2 == 0 ? self.direction - 1 : self.direction + 1;
    NSUInteger opts = [@[@1, @2, @6, @7, @3, @4][index - 1] integerValue] << 20;
    [UIView transitionWithView:imageView duration:kDuration options:opts animations:nil completion:nil];
}


@end




