//
//  ViewController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/7/18.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "ViewController.h"
#import "TLTabBarAnimation.h"

@interface ViewController ()
@property(nonatomic, strong) UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(155, 200, 60, 60)];
    [btn setImage:[UIImage imageNamed:@"Tools_00065"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
    btn.clipsToBounds = NO;
    btn.layer.masksToBounds = NO;
    [self.view addSubview:btn];
    _btn = btn;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    playSelectAnimation2(_btn);
    
    if ([self.tabBarController.childViewControllers indexOfObject:self] == 0) {
        self.tabBarItem.badgeValue = @(arc4random_uniform(10) + 1).stringValue;
    }
}

void playSelectAnimation2(UIButton *btn) {

    static NSInteger i = 1;
    TLTransitionAniamtion *anmation = [TLTransitionAniamtion new];
    anmation.direction = i++;
    [anmation playSelectAnimationWhitTabBarButton:btn
                                  buttonImageView:btn.imageView
                                  buttonTextLabel:btn.titleLabel];
//    NSLog(@"i = %zi", anmation.direction);
    if (i == 8) {
        i = 1;
    }
}

@end
