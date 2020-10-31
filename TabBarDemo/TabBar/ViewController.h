//
//  ViewController.h
//  TabBar
//
//  Created by 故乡的云 on 2019/7/18.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
/// 是否是Lottie动画
@property(nonatomic, assign) BOOL isLottie;
/// 对tab bar item 动画的简单描述
@property(nonatomic, copy) NSString *desc;
@end

