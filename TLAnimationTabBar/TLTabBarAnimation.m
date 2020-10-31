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

// MARK: - 功能函数
/// 反转数组
NSArray *tl_reversedArray(NSArray *arr) {
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSInteger i = arr.count-1; i >= 0; i--) {
        [temp addObject:arr[i]];
    }
    return [temp copy];
}

/// 创建CAKeyframeAnimation动画
CAKeyframeAnimation *tl_createAnimation(NSString *keyPath, NSArray *values, CGFloat duration) {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.values = values;
    animation.duration = kDuration;
    animation.calculationMode = @"cubic";
    
    return animation;
}

/// 播放贞动画
void tl_playFrameAnimation(UIImageView *icon, NSArray <CIImage *>*images) {
    CAKeyframeAnimation *animation = tl_createAnimation(kAnimationKeyPathKeyFrame, images, kDuration);
    animation.calculationMode = @"discrete";
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [icon.layer addAnimation:animation forKey:nil];
}

/// 植入烟花动画，并播放
void tl_playFireworksAnimation(UIView *view, UIImage *img, CGFloat scale, CGFloat scaleRange) {
    BOOL __block clipsToBounds = view.clipsToBounds;
    view.clipsToBounds = NO;
    
    CGPoint center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    explosionCell.lifetime = 0.7;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 0;
    explosionCell.velocity = 40.00;
    explosionCell.velocityRange = 10.00;
    explosionCell.contents = (id)[img CGImage];
    explosionCell.scale = scale;
    explosionCell.scaleRange = scaleRange;
    
    CAEmitterLayer __block *explosionLayer = [CAEmitterLayer layer];
    explosionLayer.name = @"emitterLayer";
    explosionLayer.emitterShape = kCAEmitterLayerCircle;
    explosionLayer.emitterMode = kCAEmitterLayerOutline;
    explosionLayer.emitterSize = CGSizeMake(25, 0);
    explosionLayer.emitterCells = @[explosionCell];
    explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    explosionLayer.masksToBounds = NO;
    explosionLayer.seed = 1366128504;
    explosionLayer.emitterPosition = center;
    [view.layer addSublayer:explosionLayer];
    
    CAEmitterCell *chargeCell = [CAEmitterCell emitterCell];
    chargeCell.name = @"charge";
    chargeCell.alphaRange = 0.20;
    chargeCell.alphaSpeed = -1.0;
    chargeCell.lifetime = 0.3;
    chargeCell.lifetimeRange = 0.1;
    chargeCell.birthRate = 0;
    chargeCell.velocity = -40.0;
    chargeCell.velocityRange = 0.00;
    chargeCell.contents = (id)[img CGImage];
    chargeCell.scale = scale;
    chargeCell.scaleRange = scaleRange;
    
    CAEmitterLayer __block *chargeLayer = [CAEmitterLayer layer];
    chargeLayer.name = @"emitterLayer";
    chargeLayer.emitterShape = kCAEmitterLayerCircle;
    chargeLayer.emitterMode = kCAEmitterLayerOutline;
    chargeLayer.emitterSize = CGSizeMake(25, 0);
    chargeLayer.emitterCells = @[chargeCell];
    chargeLayer.renderMode = kCAEmitterLayerOldestFirst;
    chargeLayer.masksToBounds = NO;
    chargeLayer.seed = 1366128504;
    chargeLayer.emitterPosition = center;
    [view.layer addSublayer:chargeLayer];
    
    chargeLayer.beginTime = CACurrentMediaTime();
    [chargeLayer setValue:@100 forKeyPath:@"emitterCells.charge.birthRate"];
    
    NSTimeInterval time = kDuration * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time), dispatch_get_main_queue(), ^{
        [chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
        [chargeLayer removeFromSuperlayer];
        
        explosionLayer.beginTime = CACurrentMediaTime();
        [explosionLayer setValue:@300 forKeyPath:@"emitterCells.explosion.birthRate"];

        NSTimeInterval time = 0.3 * NSEC_PER_SEC;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time), dispatch_get_main_queue(), ^{
            [explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
            [explosionLayer removeFromSuperlayer];
            view.clipsToBounds = clipsToBounds;
        });
    });
}





// MARK: - TLBounceAnimation 弹性动画
@implementation TLBounceAnimation

- (void)playSelectAnimationWhitTabBarButton:(UIView *)button
                            buttonImageView:(UIImageView *)imageView
                            buttonTextLabel:(UILabel *)textLabel
{
    CAKeyframeAnimation *bounceAnimation = tl_createAnimation(kAnimationKeyPathScale, @[@1.0, @0.85, @1.15, @0.95, @1.02, @1.0], kDuration);
    [imageView.layer addAnimation:bounceAnimation forKey:nil];
    
    if(_isPlayFireworksAnimation) {
        UIImage *img = [UIImage imageNamed:@"yanhua"];
        tl_playFireworksAnimation(imageView, img, 0.08, 0.03);
    }
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
    
    CAKeyframeAnimation *animation = tl_createAnimation(kAnimationKeyPathPositionY, values, kDuration / 2);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [icon.layer addAnimation:animation forKey:nil];
}

void playSelectLabelAnimation(UILabel *textLabel) {
    
    CAKeyframeAnimation *animation = tl_createAnimation(kAnimationKeyPathPositionY, @[@(textLabel.center.y) , @(textLabel.center.y - 60.0)], kDuration);
    animation.fillMode = kCAFillModeRemoved;
    [textLabel.layer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation *scaleAnimation = tl_createAnimation(kAnimationKeyPathScale, @[@1.0, @2.0], kDuration);
    scaleAnimation.fillMode = kCAFillModeRemoved;
    [textLabel.layer addAnimation:scaleAnimation forKey:nil];
    
    CAKeyframeAnimation * opacityAnimation = tl_createAnimation(kAnimationKeyPathOpacity,@[@1.0, @0.0], kDuration);
    [textLabel.layer addAnimation:opacityAnimation forKey:nil];
    textLabel.alpha = 0;
}


void playDeselectLabelAnimation(UILabel *textLabel) {
    
    CAKeyframeAnimation *animation = tl_createAnimation(kAnimationKeyPathPositionY, @[@(textLabel.center.y + 15), @(textLabel.center.y)], kDuration);
    [textLabel.layer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation * opacityAnimation = tl_createAnimation(kAnimationKeyPathOpacity,@[@0.0, @1.0], kDuration);
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
        tl_playFrameAnimation(imageView, self.images);
        if(_isPlayFireworksAnimation) {
            UIImage *img = [UIImage imageNamed:@"yanhua"];
            tl_playFireworksAnimation(imageView, img, 0.08, 0.03);
        }
    }
}


- (void)playDeselectAnimationWhitTabBarButton:(UIView *)button
                              buttonImageView:(UIImageView *)imageView
                              buttonTextLabel:(UILabel *)textLabel
{
    if (self.images.count > 0) {
        tl_playFrameAnimation(imageView, tl_reversedArray(self.images));
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




