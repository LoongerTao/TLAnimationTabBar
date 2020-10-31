//
//  AppDelegate.m
//  TabBar
//
//  Created by 故乡的云 on 2019/7/18.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "AppDelegate.h"
#import "TLTabBarController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    TLTabBarController *tb = [[TLTabBarController alloc] init];
    tb.view.bounds = [UIScreen mainScreen].bounds;
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = tb;
    self.window = window;
    [window makeKeyAndVisible];
    
    return YES;
}




@end
