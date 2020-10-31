//
//  ViewController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/7/18.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "ViewController.h"
#import "TLAnimationTabBar.h"
#import "NewFeaturesController.h"
#import "TLLottieTabBarController.h"

@interface ViewController ()
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = self.view.bounds.size.width;
    CGFloat y = self.view.bounds.size.height - (self.isLottie ? 260 : 200);
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, w, 40)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:24];
    _titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_titleLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [btn setTitle:@"探究 iOS 13 新特性" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor systemTealColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(iOS13NewFeatures) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.center = CGPointMake(CGRectGetMidX(self.view.bounds), 400);
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, y-30, w, 30)];
    if (!self.isLottie) {
        [btn setTitle:@"Lottie Tab Bar" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor systemTealColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(lottieTabBar) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self resetTitle];
}

- (void)resetTitle {
    if (self.desc) {
        _titleLabel.text = self.desc;
    }else {
        _titleLabel.text = NSStringFromClass([self.tabBarItem.animation class]);
    }
}

// MARK: - Actions
- (void)lottieTabBar {
    TLLottieTabBarController *tb = [[TLLottieTabBarController alloc] init];
    tb.view.bounds = [UIScreen mainScreen].bounds;
    [self presentViewController:tb animated:YES completion:^{
        
    }];
}

// MARK: - 探究 iOS 13 新特性
- (void)iOS13NewFeatures {
    if (@available(iOS 13.0, *)) {
        NewFeaturesController *rootVc = [NewFeaturesController new];
        //    rootVc.modalPresentationStyle = UIModalPresentationFullScreen;
        rootVc.navigationItem.title = @"探究 iOS 13 新特性";

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
    }else {
        if (![_titleLabel.textColor isEqual:[UIColor redColor]]) {
            _titleLabel.textColor = [UIColor redColor];
            _titleLabel.font = [UIFont systemFontOfSize:14];
            _titleLabel.text = @"后续操作只支持此 iOS 13及以上版本";
            [self performSelector:@selector(resetTitle) withObject:nil afterDelay:2];
        }
    }
}


@end
