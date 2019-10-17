//
//  SFSymbolController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/17.
//  Copyright © 2019 故乡的云. All rights reserved.
//
/* 参考
https://developer.apple.com/videos/play/wwdc2019/206/
https://developer.apple.com/documentation/xcode/creating_custom_symbol_images_for_your_app?language=objc
 */


#import "SFSymbolController.h"

@interface SFSymbolController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fillSgmt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSgmt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sizeSgmt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scaleSgmt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *weightSgmt;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation SFSymbolController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setImage];
}

- (IBAction)updateImage:(id)sender {
    
    [self setImage];
}

- (void)setImage {
    
    // fill
    NSString *imgName = self.fillSgmt.selectedSegmentIndex == 0 ? @"sun.dust" : @"sun.dust.fill";
    UIImage *image = [UIImage systemImageNamed:imgName];
    
    self.imageView.image = image;
    [self.btn setImage:image forState:UIControlStateNormal];
    
    
    // tintColor
    UIColor *tintColor = [UIColor systemGreenColor];
    if (self.colorSgmt.selectedSegmentIndex == 1) {
        tintColor = [UIColor systemOrangeColor];
    }else if (self.colorSgmt.selectedSegmentIndex == 2) {
        tintColor = [UIColor systemPinkColor];
    }else if (self.colorSgmt.selectedSegmentIndex == 3) {
        tintColor = [UIColor systemGreenColor];
    }
    self.imageView.tintColor = tintColor;
    self.btn.tintColor = tintColor;
    
    
    // UIImageSymbolConfiguration
    CGFloat size = [[self.sizeSgmt titleForSegmentAtIndex:self.sizeSgmt.selectedSegmentIndex] floatValue];
    UIImageSymbolScale scale = self.scaleSgmt.selectedSegmentIndex;
    UIImageSymbolWeight weight = self.weightSgmt.selectedSegmentIndex;
    UIImageSymbolConfiguration *cfg = [UIImageSymbolConfiguration configurationWithPointSize:size weight:weight scale:scale];
    
    self.imageView.preferredSymbolConfiguration = cfg;
    [self.btn setPreferredSymbolConfiguration:cfg forImageInState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont systemFontOfSize:size];
    self.btn.titleLabel.font = [UIFont systemFontOfSize:size];
}

@end
