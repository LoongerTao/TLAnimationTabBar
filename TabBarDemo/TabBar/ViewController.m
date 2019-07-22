//
//  ViewController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/7/18.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "ViewController.h"
#import "TLAnimationTabBar.h"

@interface ViewController ()
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = self.view.bounds.size.width;
    CGFloat y = self.view.bounds.size.height - 200;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, w, 40)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_titleLabel];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _titleLabel.text = NSStringFromClass([self.tabBarItem.animation class]);
}

@end
