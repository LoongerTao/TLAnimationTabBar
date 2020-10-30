//
//  TLTabBarController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/7/18.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLTabBarController.h"
#import "ViewController.h"
#import "TLAnimationTabBar.h"

@interface TLTabBarController ()

@end

@implementation TLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setCls:(Class)cls {
    _cls = cls;
    
    [self addChildViewController:childViewController(@"Pin", @"icon_pin_00160", 0, cls)];
    [self addChildViewController:childViewController(@"User", @"user_00084", 1, cls)];
    [self addChildViewController:childViewController2(UITabBarSystemItemBookmarks, 2, cls)];
    [self addChildViewController:childViewController(@"Drop", @"drop", 3, cls)];
    [self addChildViewController:childViewController(@"Tools", @"Tools_00028", 4, cls)];
    
    self.tabBar.tintColor = [UIColor colorWithRed:234/255.0 green:111/255.0 blue:90/255.0 alpha:1];
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = [UIColor colorWithRed:124/255.0 green:99/255.0 blue:86/255.0 alpha:1];
    } else {
        // Fallback on earlier versions
    }
}

// MARK: - UITabBarItem创建函数
/// 自定义样式UITabBarItem
UIViewController *childViewController (NSString *title, NSString *imgName, NSUInteger tag, Class cls) {
    ViewController *vc = [[cls alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imgName] tag:tag];
    
    setAnimation(vc.tabBarItem, tag);
    return vc;
}

/// 系统样式UITabBarItem
UIViewController *childViewController2 (UITabBarSystemItem systemItem, NSUInteger tag, Class cls) {
    ViewController *vc = [[cls alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:systemItem tag:tag];
    
    setAnimation(vc.tabBarItem, tag);
    
    return vc;
}

// MARK: - 给UITabBarItem绑定动画
/// 给UITabBarItem绑定动画
void setAnimation(UITabBarItem *item, NSInteger index) {
     item.animation = @[
                       bounceAnimation(), rotationAnimation(), transitionAniamtion(),
                       fumeAnimation(), frameAnimation()
                       ][index];
}


// MARK: - 创建动画函数
TLBounceAnimation *bounceAnimation(){
    TLBounceAnimation *anm = [TLBounceAnimation new];
    anm.isPlayFireworksAnimation = YES;
    return anm;
}

TLRotationAnimation *rotationAnimation(){
    TLRotationAnimation *anm = [TLRotationAnimation new];
    return anm;
}

TLTransitionAniamtion *transitionAniamtion(){
    TLTransitionAniamtion *anm = [TLTransitionAniamtion new];
    anm.direction = 1; // 1~6
    anm.disableDeselectAnimation = NO;
    return anm;
}

TLFumeAnimation *fumeAnimation(){
    TLFumeAnimation *anm = [TLFumeAnimation new];
    return anm;
}

TLFrameAnimation *frameAnimation(){
    TLFrameAnimation *anm = [TLFrameAnimation new];
    anm.images = imgs();
    anm.isPlayFireworksAnimation = YES;
    return anm;
}

NSArray *imgs (){
    NSMutableArray *temp = [NSMutableArray array];
    for (NSInteger i = 28 ; i <= 65; i++) {
        NSString *imgName = [NSString stringWithFormat:@"Tools_000%zi", i];
        CGImageRef img = [UIImage imageNamed:imgName].CGImage;
        [temp addObject:(__bridge id _Nonnull)(img)];
    }
    return temp;
}

// MARK: - UITabBarItemDelegate 监听TabBarItem点击事件
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // TabBarItem被点击时会被调用
    NSLog(@"%s",__func__);
}
@end




