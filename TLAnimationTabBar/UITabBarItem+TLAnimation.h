//
//  UITabBarItem+TLAnimation.h
//  TabBar
//
//  Created by 故乡的云 on 2019/7/19.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@protocol TLAnimationProtocol;
@interface UITabBarItem (TLAnimation)

@property(nonatomic, strong) id <TLAnimationProtocol>animation;

@end

NS_ASSUME_NONNULL_END
