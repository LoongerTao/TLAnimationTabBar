//
//  TLMenusTestController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/17.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLMenusTestController.h"


@interface TLMenusTestController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *items;
@property(nonatomic, weak) NSIndexPath *indexPath;
@end

@implementation TLMenusTestController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.items = @[
        @"airplayaudio",@"arkit",@"airplayvideo",@"icloud",@"螺栓水平云",
        @"感叹号",@"脸型",@"icloud和箭头",@"实时摄影",@"笔尖裁剪圆",@"苹果浏览器"
    ];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect frame = self.view.layoutMarginsGuide.layoutFrame;
        frame.size.height *= 0.5f;
        UITableView *tableView = [[UITableView alloc] initWithFrame: frame style:UITableViewStylePlain];
        _tableView = tableView;
        [self.view addSubview:tableView];
        tableView.rowHeight = 60;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return  _tableView;
}

// MARK: - table view data source & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.items[indexPath.row];
    cell.imageView.image = [UIImage systemImageNamed:self.items[indexPath.row]];
    cell.imageView.tintColor = [UIColor systemPinkColor];
    return cell;
}

- (nullable UIContextMenuConfiguration *)tableView:(UITableView *)tableView contextMenuConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point {
    
    self.indexPath = indexPath;
    
    return [self contextMenuConfiguration];
}


- (nullable UITargetedPreview *)tableView:(UITableView *)tableView previewForHighlightingContextMenuWithConfiguration:(UIContextMenuConfiguration *)configuration
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.indexPath];
    if (self.indexPath.row < 2) {
        return [[UITargetedPreview alloc] initWithView:cell.imageView];
    }
    return [[UITargetedPreview alloc] initWithView:cell];
}


- (UIContextMenuConfiguration *)contextMenuConfiguration{
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
                

        UIMenu *edit = [UIMenu menuWithTitle:@"Edit"
                                       image:[UIImage systemImageNamed:@"pencil.and.outline"]
                                  identifier:@"edit"
                                     options:UIMenuOptionsDestructive
                                    children:@[copyAction,duplicateAction]];
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
                                                   previewProvider:nil
                                                    actionProvider:actionProvider];
}
@end
