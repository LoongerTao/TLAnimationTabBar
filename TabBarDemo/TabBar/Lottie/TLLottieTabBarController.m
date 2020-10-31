//
//  TLLottieTabBarController.m
//  TabBar
//
//  Created by 故乡的云 on 2020/10/30.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import "TLLottieTabBarController.h"
#import "ViewController.h"
#import "TLAnimationTabBar.h"
#import "TLTabBarLottieAnimation.h"
#import "UIImage+TLExt.h"

@interface TLLottieTabBarController ()

@end

@implementation TLLottieTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewControllerWithTitle:nil desc:@"无标题，标题内嵌到Lottie中" tag:0];
    [self addChildViewControllerWithTitle:@"Title" desc:@"标题无动画，图片有动画" tag:1];
    [self addChildViewControllerWithTitle:@"Reverse" desc:@"撤销选中时进行动画反转" tag:2];
    [self addChildViewControllerWithTitle:@"Normal" desc:@"选中和撤销选都有动画" tag:3];
    [self addChildViewControllerWithTitle:@"Light&Dark" desc:@"适配黑暗模式的动画" tag:4];
    
    self.tabBar.tintColor = [UIColor colorWithRed:0.68627451 green:0.321568627 blue:0.870588235 alpha:1];
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = [UIColor colorWithRed:0.086 green:0.098 blue:0.129 alpha:1];
    } else {
        // Fallback on earlier versions
    }
}

- (UIImage *)transparentImageWithSize:(CGSize)size {
    return [UIImage tl_imageWithColor:[UIColor colorWithWhite:0 alpha:0.0] size:size];
}

// MARK: - UITabBarItem创建函数
- (void)addChildViewControllerWithTitle:(NSString *)title desc:(NSString *)desc tag:(NSInteger)tag{
    ViewController *vc = [[ViewController alloc] init];
    vc.isLottie = YES;
    vc.desc = desc;
    vc.view.backgroundColor = [UIColor whiteColor];
    if (tag == 0) {
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:tag];
    }else {
        /// 图片的大小决定了tabBarItem imageView的大小（官方建议大小（25，25）），所以在此处设置一张透明图片来控制imageView的大小
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                      image:[self transparentImageWithSize:CGSizeMake(25, 25)]
                                                        tag:tag];
    }
    [self addChildViewController:vc];
    
    TLTabBarLottieAnimation *anim = nil;
    if (tag == 0) {
        anim = [TLTabBarLottieAnimation animationWithAnimationName:@"1" lottieSize:CGSizeMake(58, 36)];
    }else if (tag == 1) {
        anim = [TLTabBarLottieAnimation animationWithSelectedAnimationName:@"2"
                                                                      deselectedAnimationName:nil];
    }else if (tag == 2) {
        anim = [TLTabBarLottieAnimation animationWithSelectedAnimationName:@"3"
                                                                      deselectedAnimationName:nil];
    }else if (tag == 3) {
        anim = [TLTabBarLottieAnimation animationWithSelectedAnimationName:@"4"
                                                                      deselectedAnimationName:@"4"];
        anim.deselectedAnimationSpeed = 2;
    }else if (tag == 4) {
        anim = [TLTabBarLottieAnimation animationWithSelectedAnimationNameOfLight:@"5"
                                                      selectedAnimationNameOfDark:@"5dark"
                                                   deselectedAnimationNameOfLight:nil
                                                    deselectedAnimationNameOfDark:nil];
    }
    vc.tabBarItem.animation = anim;
}

// MARK: - 给UITabBarItem绑定动画


// MARK: - UITabBarItemDelegate 监听TabBarItem点击事件
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // TabBarItem被点击时会被调用
    NSLog(@"%s",__func__);
}
@end




