//
//  TLLottieAnimationView.m
//  TabBar
//
//  Created by Gxdy on 2020/9/10.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import "TLLottieAnimationView.h"
#import <Lottie/Lottie.h>

@interface TLLottieAnimationView ()
/// 动画对象
@property(nonatomic, strong, readonly) LOTAnimationView *animationView;
@end

@implementation TLLottieAnimationView

+ (instancetype)viewWithAnimationNamed:(NSString *)animationName {
    TLLottieAnimationView *view = [[self alloc] init];
    view.userInteractionEnabled = NO;
    [view setupWithAnimationNamed:animationName];
    return view;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    if (self.superview) {
        [self.superview addObserver:self
                         forKeyPath:@"frame"
                            options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial
                            context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        self.center = CGPointMake(CGRectGetMidX(self.superview.bounds), CGRectGetMidY(self.superview.bounds));
        self.animationView.frame = self.bounds;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.animationView.frame = self.bounds;
}

- (void)setupWithAnimationNamed:(NSString *)animationName {
    LOTAnimationView *animation = [LOTAnimationView animationNamed:animationName];
    animation.loopAnimation = NO;
    animation.frame = self.bounds;
    animation.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:animation];
    _animationView = animation;
}

- (void)playWithAnimationNamed:(nonnull NSString *)animationName
                  fromProgress:(CGFloat)fromStartProgress
                    toProgress:(CGFloat)toEndProgress
                animationSpeed:(CGFloat)speed
                    completion:(void (^)(BOOL animationFinished))completion {
    if (self.animationView.isAnimationPlaying) {
        [self.animationView stop];
    }
    
    if (animationName.length && ![self.animationView.animation isEqualToString:animationName]) {
        [self.animationView setAnimationNamed:animationName];
    }
    
    self.animationView.animationSpeed = speed;
    [self.animationView playFromProgress:fromStartProgress
                              toProgress:toEndProgress
                          withCompletion:completion];
}

- (void)playWithAnimationNamed:(nonnull NSString *)animationName
                    completion:(void (^)(BOOL animationFinished))completion {
    [self playWithAnimationNamed:animationName
                    fromProgress:0
                      toProgress:1
                  animationSpeed:1
                      completion:completion];
}

- (void)playWithCompletion:(void (^)(BOOL animationFinished))completion {
    [self playWithAnimationNamed:@"" completion:completion];
}

- (void)pause {
    if (self.animationView.isAnimationPlaying) {
        [self.animationView pause];
    }
}

- (void)stop {
    if (self.animationView.isAnimationPlaying) {
        [self.animationView stop];
    }
}

- (void)removeFromSuperview {
    [self.superview removeObserver:self forKeyPath:@"frame"];
    [super removeFromSuperview];
}

- (void)dealloc {
    [self.superview removeObserver:self forKeyPath:@"frame"];
}
@end
