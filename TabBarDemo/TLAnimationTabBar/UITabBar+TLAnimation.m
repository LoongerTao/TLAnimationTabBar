//
//  UITabBar+TLAnimation.m
//  TabBar
//
//  Created by 故乡的云 on 2019/7/19.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "UITabBar+TLAnimation.h"
#import "UITabBarItem+TLAnimation.h"
#import "TLAnimationProtocol.h"
#import <objc/runtime.h>

@implementation UITabBar (TLAnimation)

// MARK: - 方法交换
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        
        Method method1 = class_getInstanceMethod(cls, @selector(setSelectedItem:));
        Method method2 = class_getInstanceMethod(cls, @selector(tl_setSelectedItem:));
        method_exchangeImplementations(method1, method2);
    });
}

- (void)didAddSubview:(UIView *)subview {
    if ([self isMemberOfClass:[UITabBar class] ]) {
        if (self.btns == nil) {
            self.btns = @[];
            self.selectedIndex = 0;
        }
        if ([subview isMemberOfClass:NSClassFromString(@"UITabBarButton")]) {
            NSMutableArray *temp = [NSMutableArray arrayWithArray:self.btns];
            [temp addObject:subview];
            self.btns = temp;
        }
    }
    
    // 使用方法交换时出现错误，用此方法替代
    SEL sel = NSSelectorFromString(@"tl_didAddSubview:");
    if([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:subview afterDelay:0];
    }
}

/// UITabBarItem选中监听
- (void)tl_setSelectedItem:(UITabBarItem *)selectedItem {
    NSUInteger index = [self.items indexOfObject:selectedItem];
    NSUInteger sIdx = self.selectedIndex;
    if (sIdx != index && self.btns.count > index) {
        // 撤销选中动画
        id deselectAnimation = self.items[sIdx].animation;
        if (deselectAnimation) {
            [deselectAnimation playDeselectAnimationWhitTabBarButton:self.btns[sIdx]
                                                     buttonImageView:imageView(self.btns[sIdx])
                                                     buttonTextLabel:textLabel(self.btns[sIdx])];
        }
        
        // 选中动画
        id selectAnimation = self.items[index].animation;
        if (selectAnimation) {
            [selectAnimation playSelectAnimationWhitTabBarButton:self.btns[index]
                                                 buttonImageView:imageView(self.btns[index])
                                                 buttonTextLabel:textLabel(self.btns[index])];
        }
        
        NSLog(@"selectAnimation: %@     deselectAnimation: %@",[selectAnimation class], [deselectAnimation class]);
        
        self.selectedIndex = index;
    }
    [self tl_setSelectedItem:selectedItem];
}

// MARK: - 关联属性
- (void)setBtns:(NSArray *)btns {
    objc_setAssociatedObject(self, @selector(btns), btns, OBJC_ASSOCIATION_RETAIN);
}

- (NSArray *)btns {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    objc_setAssociatedObject(self, @selector(selectedIndex), @(selectedIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)selectedIndex {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}


// MARK: - Functions
UILabel *textLabel(UIView *btn) {
    if ([btn isMemberOfClass:NSClassFromString(@"UITabBarButton")]) {
        return [btn valueForKeyPath:@"_label"];
    }
    return nil;
}

UIImageView *imageView(UIView *btn) {
    if ([btn isMemberOfClass:NSClassFromString(@"UITabBarButton")]) {
        return [btn valueForKeyPath:@"_info"];
    }
    return nil;
}

@end




