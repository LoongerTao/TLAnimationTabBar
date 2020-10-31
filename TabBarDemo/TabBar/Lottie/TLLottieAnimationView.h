//
//  TLLottieAnimationView.h
//  TabBar
//
//  Created by Gxdy on 2020/9/10.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLLottieAnimationView : UIView

+ (instancetype)viewWithAnimationNamed:(NSString *)animationName;

- (void)playWithCompletion:(void (^)(BOOL animationFinished))completion;

- (void)playWithAnimationNamed:(nonnull NSString *)animationName
                    completion:(void (^)(BOOL animationFinished))completion;

- (void)playWithAnimationNamed:(nonnull NSString *)animationName
                  fromProgress:(CGFloat)fromStartProgress
                    toProgress:(CGFloat)toEndProgress
                animationSpeed:(CGFloat)speed
                    completion:(void (^)(BOOL animationFinished))completion;

- (void)pause;

- (void)stop;
@end

NS_ASSUME_NONNULL_END
