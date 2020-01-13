//
//  TLBarsAppearanceController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/21.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLBarsAppearanceController.h"
#import "TLTabBarAppearanceController.h"
#import "TLTabBarController.h"

@interface TLBarsAppearanceController ()
@property(nonatomic, weak) UINavigationBarAppearance *navBarAppearance;
@end

@implementation TLBarsAppearanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

// MARK: - add sub views (UI)
- (void)setUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    _navBarAppearance = self.navigationController.navigationBar.standardAppearance;
    
    self.navigationItem.rightBarButtonItems = @[
        [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:nil action:nil],
        [[UIBarButtonItem alloc] initWithTitle:@"Button" style:UIBarButtonItemStylePlain target:nil action:nil]
    ];
    
    NSArray *items = @[@"Title",@"Large Title", @"Button", @"Done Button", @"Back Buttom",
                       @"Tab Bar Appearance"];
    [items enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
       UIView *sectionView = [self sectionViewWithTitle:title section:idx];
       [self.view addSubview:sectionView];
    }];
}

- (UIView *)sectionViewWithTitle:(NSString *)title section:(NSInteger)section{
    CGFloat w = self.view.safeAreaLayoutGuide.layoutFrame.size.width;
   
    UIView *sectionView = [[UIView alloc] init];
    sectionView.frame = CGRectMake(14, 120 + section * 85, w - 28, 50);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    label.text = title;
    label.textColor = [UIColor labelColor];
    label.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20];
    [sectionView addSubview:label];
    
    NSArray *colors = @[
        [UIColor systemRedColor],
        [UIColor systemOrangeColor],
        [UIColor systemYellowColor],
        [UIColor systemGreenColor],
        [UIColor systemBlueColor],
        [UIColor systemPurpleColor],
        [UIColor systemGrayColor]
    ];
    
    [colors enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *circleView = [self circleViewWithBackgroundColor:color
                                                         section:section
                                                             row:idx];
        [sectionView addSubview:circleView];
    }];

    return sectionView;
}

- (UIView *)circleViewWithBackgroundColor:(UIColor *)bgColor
                                  section:(NSInteger)section
                                      row:(NSInteger)row
{
    CGFloat WH = 28;
    CGRect frame = CGRectMake((WH + 20) * row, 26, WH, WH);
    UIView *circleView = [[UIView alloc] initWithFrame:frame];
    circleView.layer.cornerRadius = WH * 0.5;
    circleView.backgroundColor = bgColor;
    circleView.clipsToBounds = YES;
    circleView.tag = section;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setNavBarAppearance:)];
    [circleView addGestureRecognizer:tap];
    
    return circleView;
}

// MARK: - set Nav Bar Appearance
- (NSDictionary *)attributesWithColor:(UIColor *)color fontSize:(CGFloat)size{
    return @{
        NSForegroundColorAttributeName: color,
        NSFontAttributeName: [UIFont fontWithName:@"Copperplate-Bold" size:size]
    };
}

- (void)setNavBarAppearance:(UITapGestureRecognizer *)tap {
    NSInteger section = tap.view.tag;
    UIColor *color = tap.view.backgroundColor;
    if (section == 0) {
        [self setNavBarTitleColor:color fontSize:17];
    }else if(section == 1) {
        [self setNavBarLargeTitleColor:color fontSize:28];
    }else if (section == 2) {
        [self setNavBarButtonColor:color fontSize:17];
    }else if (section == 3) {
        [self setNavBarDoneButtonColor:color fontSize:17];
    }else if (section == 4){
        [self setNavBarBackButtonColor:color fontSize:17];
    }else {
        // tab bar
        [self setTabBarAppearanceWithColor:color];
    }
}

- (void)setNavBarTitleColor:(UIColor *)color fontSize:(CGFloat)size{
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    UINavigationBarAppearance *ap = self.navBarAppearance;
    ap.titleTextAttributes = [self attributesWithColor:color fontSize:size];
}

- (void)setNavBarLargeTitleColor:(UIColor *)color fontSize:(CGFloat)size{
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    UINavigationBarAppearance *ap = self.navBarAppearance;
    ap.largeTitleTextAttributes = [self attributesWithColor:color fontSize:size];
}

- (void)setNavBarButtonColor:(UIColor *)color fontSize:(CGFloat)size{
    UINavigationBarAppearance *ap = self.navBarAppearance;
    ap.buttonAppearance.normal.titleTextAttributes = [self attributesWithColor:color fontSize:size];
    ap.buttonAppearance.highlighted.titleTextAttributes = [self attributesWithColor:[UIColor systemTealColor] fontSize:size];
}

- (void)setNavBarDoneButtonColor:(UIColor *)color fontSize:(CGFloat)size{
    UINavigationBarAppearance *ap = self.navBarAppearance;
    ap.doneButtonAppearance.normal.titleTextAttributes = [self attributesWithColor:color fontSize:size];
    ap.doneButtonAppearance.highlighted.titleTextAttributes = [self attributesWithColor:[UIColor systemTealColor] fontSize:size];
}

- (void)setNavBarBackButtonColor:(UIColor *)color fontSize:(CGFloat)size{
    UINavigationBarAppearance *ap = self.navBarAppearance;
    ap.backButtonAppearance.normal.titleTextAttributes = [self attributesWithColor:color fontSize:size];
    ap.backButtonAppearance.highlighted.titleTextAttributes = [self attributesWithColor:[UIColor systemTealColor] fontSize:size];
    self.navigationController.navigationBar.tintColor = color;
}

// MARK: - Tab Bar Appearance
- (void)setTabBarAppearanceWithColor:(UIColor *)color {
    TLTabBarController *tabBarVc = [TLTabBarController new];
    tabBarVc.cls = [TLTabBarAppearanceController class];
    tabBarVc.view.bounds = [UIScreen mainScreen].bounds;
    
    UIColor *selectColor = [UIColor systemPinkColor];
    UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
    UITabBarItemAppearance *stacked = appearance.stackedLayoutAppearance;
    stacked.normal.titleTextAttributes = @{NSForegroundColorAttributeName: color};
    stacked.normal.iconColor = color;
    stacked.selected.titleTextAttributes = @{NSForegroundColorAttributeName: selectColor};
    stacked.selected.iconColor = selectColor;
    appearance.inlineLayoutAppearance = [stacked copy];
    
    [self presentViewController:tabBarVc animated:YES completion:nil];
    tabBarVc.tabBar.standardAppearance = appearance;
}

@end
