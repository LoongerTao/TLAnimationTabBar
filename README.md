# TLAnimationTabBar

### 带有动画效果的TabBar：[TLAnimationTabBar](https://github.com/LoongerTao/TLAnimationTabBar) 
####  1. 特点
- 模仿https://github.com/Ramotion/animated-tab-bar项目的动画效果
- 使用简单、无耦合
- 无需自定义控件，适配系统自带的UITabBarItem
- 支持自定义动画拓展

#### 2. 效果图如下

- ![效果.gif](https://upload-images.jianshu.io/upload_images/3333500-166134560f01ccda.gif?imageMogr2/auto-orient/strip)

#### 3. 使用（支持Pod）
- i. 按照正常流程`创建TabbarViewController的ChildViewController`及`对应的UITabBarItem`
- ii. `给创建好的UITabBarItem`设置动画属性[`这一步是重点`]
```objc
@implementation TLTabBarController

- (void)viewDidLoad {
[super viewDidLoad]；

// 创建TabbarViewController的ChildViewController
// 系统自带的item
[self addChildViewController:childViewController2(UITabBarSystemItemDownloads, 0)];
[self addChildViewController:childViewController2(UITabBarSystemItemFavorites, 1)];
[self addChildViewController:childViewController2(UITabBarSystemItemBookmarks, 2)];

// 自定义图片和标题的item
[self addObjectChildViewController:childViewController(@"Drop", @"drop", 3)];
[self addChildViewController:childViewController(@"Tools", @"Tools_00028", 4)];
}

UIViewController *childViewController (NSString *title, NSString *imgName, NSUInteger tag) {
ViewController *vc = [[ViewController alloc] init];
vc.view.backgroundColor = [UIColor whiteColor];
vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imgName] tag:tag];

//  vc.tabBarItem设置动画属性（重点）
setAnimation(vc.tabBarItem, tag);
return vc;
}

UIViewController *childViewController2 (UITabBarSystemItem systemItem, NSUInteger tag) {
ViewController *vc = [[ViewController alloc] init];
vc.view.backgroundColor = [UIColor whiteColor];
vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:systemItem tag:tag];

//  vc.tabBarItem设置动画属性（重点）
setAnimation(vc.tabBarItem, tag);

return vc;
}
```

- iii. 动画的创建（`So easy!`）
```objc
// 给UITabBarItem设置对应的动画
void setAnimation(UITabBarItem *item, NSInteger index) {
item.animation = @[
bounceAnimation(), rotationAnimation(), transitionAniamtion(),
fumeAnimation(), frameAnimation()
][index];
}

// 以下都创建动画
// 创建弹性动画
TLBounceAnimation *bounceAnimation(){
TLBounceAnimation *anm = [TLBounceAnimation new];
return anm;
}

// 创建旋转动画
TLRotationAnimation *rotationAnimation(){
TLRotationAnimation *anm = [TLRotationAnimation new];
return anm;
}

// 创建转场动画
TLTransitionAniamtion *transitionAniamtion(){
TLTransitionAniamtion *anm = [TLTransitionAniamtion new];
anm.direction = 1; // 1~6，代表不同的动画方向
anm.disableDeselectAnimation = NO; // 撤销选中是否禁播动画
return anm;
}

// 创建模拟烟雾升起的动画
TLFumeAnimation *fumeAnimation(){
TLFumeAnimation *anm = [TLFumeAnimation new];
return anm;
}

// 创建图片贞动画
TLFrameAnimation *frameAnimation(){
TLFrameAnimation *anm = [TLFrameAnimation new];
anm.images = imgs();
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
```

#### pod支持
##### 1. 版本 
```
pod 'TLAnimationTabBar', '~> 1.0.0'
```

##### 2. CocoaPods获取不到最新的`TLAnimationTabBar`版本问题
这可能是本地的CocoaPods仓库列表没有更新导致的。

1. 运行以下命令更新本地的CocoaPods仓库列表：
``` pod repo update ```

2. 然后通过以下命令查询
``` pod search TLAnimationTabBar ```

3. 如果仍然查询不到最新版本，可以删除本地仓库重新安装
```sudo rm -rf ~/.cocoapods/repos/master pod setup```

#### 实现原理
- 、、、待续
