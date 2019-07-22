# TLAnimationTabBar

####  1. 特点
- 模仿https://github.com/Ramotion/animated-tab-bar项目的动画效果
- 使用简单、耦合小
- 无需自定义控件，适配系统自带的UITabBarItem
- 支持自定义动画拓展

#### 2. 效果图如下

![效果.gif](https://upload-images.jianshu.io/upload_images/3333500-3eb2e6e9aef759c6.gif?imageMogr2/auto-orient/strip)

#### 3. pod支持
###### 1. 版本 
```
pod 'TLAnimationTabBar', '~> 1.0.0'
```

###### 2. CocoaPods获取不到最新的`TLAnimationTabBar`版本问题
这可能是本地的CocoaPods仓库列表没有更新导致的。

1. 运行以下命令更新本地的CocoaPods仓库列表：
``` pod repo update ```

2. 然后通过以下命令查询
``` pod search TLAnimationTabBar ```

3. 如果仍然查询不到最新版本，可以删除本地仓库重新安装
```sudo rm -rf ~/.cocoapods/repos/master pod setup```

#### 3. 架构原理与使用
1. 文件组成及作用
    - `TLAnimationTabBar.h` 对外头文件
        - `UITabBar+TLAnimation`  监听TabBarItem的切换，并自带播放动画
        - `UITabBarItem+TLAnimation` 给TabBarItem绑定一个动画属性
        - `TLTabBarAnimation` 动画类的集合，所有动画都遵守`TLAnimationProtocol`协议，为TabBarItem提供动画实例
2. 简单实现思路
- 不破坏`UITabBar和UITabBarItem的原生态`，保持完美兼容。不采用自定义组件，将动画独立化，以降低耦合度
- 通过遍历TabBar的subViews，获取到UITabBarItem中没有暴露在外的`UITabBarButton`按钮属性，然后给其绑定一个动画（直接给这个按钮赋予动画效果）
```objc
@interface UITabBarItem (TLAnimation)
/// 通过分类给TabBarItem绑定一个动画属性
@property(nonatomic, strong) id <TLAnimationProtocol>animation;

@end
```
- 动画实例需要遵守`TLAnimationProtocol协议`，根据协议定制动画，以保证调度统一。协议中将动画细化到`UITabBarButton`或者其subView（imageView和Label）

3. 使用
因为实在原生组件的基础上进行动画植入，所以只需要个每个UITabBarItem的实例赋予一个动画属性即可
```objc
    // 创建TabBarViewController的Child View Controller
    ViewController *vc = [[ViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imgName] tag:tag];


    // 创建动画
    TLFumeAnimation *anm = [TLFumeAnimation new];

    // 设置动画属性（重点）
    vc.tabBarItem.animation = anm;
```
