//
//  TLMenusController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/17.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLMenusController.h"
#import "TLScreenshotController.h"
#import "TLMenusTestController.h"

@interface TLMenusController () <UIContextMenuInteractionDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImg;
@property (weak, nonatomic) IBOutlet UISwitch *isSyncShowSubMenus;
@property (weak, nonatomic) IBOutlet UISegmentedControl *preViewSgmt;
@property (weak, nonatomic) IBOutlet UISwitch *isShowDismissPreview;

@end

@implementation TLMenusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    
    // 给imgView添加一个上下文菜单交互
    UIContextMenuInteraction *interaction = [[UIContextMenuInteraction alloc] initWithDelegate:self];
    [_imgView addInteraction:interaction];
}

- (IBAction)useOftableViewAndCollectionView:(id)sender {
    TLMenusTestController *vc = [TLMenusTestController new];
    vc.title = @"UITableView and UICollectionView";
    [self.navigationController pushViewController:vc animated:YES];
}


// MARK: - UIContextMenuInteractionDelegate
// MARK: 必须实现的代理方法
/// 交互开始时调用，用来返回预览控制器或操作菜单（UIMenu）,location: 用户触摸的坐标（在imgView中的位置）
- (nullable UIContextMenuConfiguration *)contextMenuInteraction:(UIContextMenuInteraction *)interaction configurationForMenuAtLocation:(CGPoint)location
{
    
    // 预览控制器提供者
    UIContextMenuContentPreviewProvider previewProvider = nil;
    if (self.preViewSgmt.selectedSegmentIndex == 2) {
        previewProvider = ^UIViewController * _Nullable{
            return [TLScreenshotController new];
        };
    }
    
    // 菜单栏提供者
    UIContextMenuActionProvider actionProvider = ^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
        
        // 创建子菜单
        UIAction *copyAction =
        [UIAction actionWithTitle:@"Copy"
                            image:[UIImage systemImageNamed:@"doc.on.doc"]
                       identifier:nil
                          handler:^(__kindof UIAction * _Nonnull action) {
            NSLog(@"%s", __func__);
        }];
        UIAction *duplicateAction =
        [UIAction actionWithTitle:@"Duplicate"
                            image:[UIImage systemImageNamed:@"plus.square.on.square"]
                       identifier:nil
                          handler:^(__kindof UIAction * _Nonnull action) {
            NSLog(@"%s", __func__);
        }];
                
        UIMenu *edit;
        if (self.isSyncShowSubMenus.on) {
            // options <= UIMenuOptionsDisplayInline 黑色样式，自动展开子菜单
            // options >= UIMenuOptionsDestructive 红色样式，不展开子菜单
            edit = [UIMenu menuWithTitle:@"Edit"
                                   image:[UIImage systemImageNamed:@"pencil.and.outline"]
                              identifier:@"edit"
                                 options:UIMenuOptionsDisplayInline
                                children:@[copyAction,duplicateAction]];
        }else {
            // 黑色样式、不展开子菜单
            edit = [UIMenu menuWithTitle:@"Edit" children:@[copyAction,duplicateAction]];
        }
        
        
        // 主菜单
        UIAction *shareAction = [UIAction
                                 actionWithTitle:@"Share"
                                 image:[UIImage systemImageNamed:@"square.and.arrow.up"]
                                 identifier:@""
                                 handler:^(__kindof UIAction * _Nonnull action) {
            NSLog(@"%s", __func__);
        }];
        UIAction *deleteAction = [UIAction
                                  actionWithTitle:@"Delete"
                                  image:[UIImage systemImageNamed:@"trash"]
                                  identifier:@""
                                  handler:^(__kindof UIAction * _Nonnull action) {
            NSLog(@"%s", __func__);
        }];
        deleteAction.attributes = UIMenuElementAttributesDestructive;
        
        return [UIMenu menuWithTitle:@"" children:@[edit,shareAction,deleteAction]];
    };
    
    return [UIContextMenuConfiguration configurationWithIdentifier:@"menus"
                                                   previewProvider:previewProvider
                                                    actionProvider:actionProvider];
}


// MARK: 可选代理方法
/// 返回触发菜单后，要显示的预览目标视图，默认(不实现或返回nil)为触发菜单的视图(imgView)
- (nullable UITargetedPreview *)contextMenuInteraction:(UIContextMenuInteraction *)interaction previewForHighlightingMenuWithConfiguration:(UIContextMenuConfiguration *)configuration
{
    
    if (self.preViewSgmt.selectedSegmentIndex == 1) {
        return [[UITargetedPreview alloc] initWithView:self.previewImg]; // 显示previewImg
    }
    
    return nil; // 显示imgView
}


/// 返回dismiss时的预览目标视图
- (nullable UITargetedPreview *)contextMenuInteraction:(UIContextMenuInteraction *)interaction previewForDismissingMenuWithConfiguration:(UIContextMenuConfiguration *)configuration
{
    if (self.isShowDismissPreview.on) {
        return [[UITargetedPreview alloc] initWithView: self.previewImg];
    }
    
    return nil;
}

// MARK: Menu Life Cycle Observer
/// 当交互将要“提交”,以响应用户点击 "预览" 时调用。
- (void)contextMenuInteraction:(UIContextMenuInteraction *)interaction willPerformPreviewActionForMenuWithConfiguration:(UIContextMenuConfiguration *)configuration animator:(id<UIContextMenuInteractionCommitAnimating>)animator
{
    NSLog(@"willPerformPreviewAction");
}

/// 将要显示菜单时调用(先调用后显示)
- (void)contextMenuInteraction:(UIContextMenuInteraction *)interaction willDisplayMenuForConfiguration:(UIContextMenuConfiguration *)configuration animator:(nullable id<UIContextMenuInteractionAnimating>)animator
{
    NSLog(@"willDisplayMenu");
}

/// 交互即将结束时调用（隐藏菜单前调用）
- (void)contextMenuInteraction:(UIContextMenuInteraction *)interaction willEndForConfiguration:(UIContextMenuConfiguration *)configuration animator:(nullable id<UIContextMenuInteractionAnimating>)animator
{
    NSLog(@"willEnd");
}

@end
