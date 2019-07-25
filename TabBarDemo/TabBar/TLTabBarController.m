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
//    [self addChildViewController:childViewController2(UITabBarSystemItemDownloads, 0)];
//    [self addChildViewController:childViewController2(UITabBarSystemItemFavorites, 1)];
    
    [self addChildViewController:childViewController(@"Pin", @"icon_pin_00160", 0)];
    [self addChildViewController:childViewController(@"User", @"user_00084", 1)];
    [self addChildViewController:childViewController2(UITabBarSystemItemBookmarks, 2)];
    [self addChildViewController:childViewController(@"Drop", @"drop", 3)];
    [self addChildViewController:childViewController(@"Tools", @"Tools_00028", 4)];
    
    self.tabBar.tintColor = [UIColor colorWithRed:234/255.0 green:111/255.0 blue:90/255.0 alpha:1];
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = [UIColor colorWithRed:124/255.0 green:99/255.0 blue:86/255.0 alpha:1];
    } else {
        // Fallback on earlier versions
    }
}


UIViewController *childViewController (NSString *title, NSString *imgName, NSUInteger tag) {
    ViewController *vc = [[ViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imgName] tag:tag];
    
    setAnimation(vc.tabBarItem, tag);
    return vc;
}

UIViewController *childViewController2 (UITabBarSystemItem systemItem, NSUInteger tag) {
    ViewController *vc = [[ViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:systemItem tag:tag];
    
    setAnimation(vc.tabBarItem, tag);
    
    return vc;
}


void setAnimation(UITabBarItem *item, NSInteger index) {
     item.animation = @[
                       bounceAnimation(), rotationAnimation(), transitionAniamtion(),
                       fumeAnimation(), frameAnimation()
                       ][index];
}

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

@end




