//
//  TLMenusTestController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/17.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLMenusTestController.h"
#import "TLCollectionCell.h"
#import "TLLineLayout.h"



@interface TLMenusTestController ()<
UITableViewDelegate,UITableViewDataSource,
UICollectionViewDelegate, UICollectionViewDataSource
>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *items;
@property(nonatomic, weak) NSIndexPath *indexPath;
@end

@implementation TLMenusTestController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.items = @[
        @"airplayaudio",@"arkit",@"airplayvideo",@"icloud",@"livephoto.play",
        @"wind",@"snow",@"tornado",@"share",@"book",@"safari"
    ];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
    
    [self.collectionView registerClass:[TLCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];
}

// MARK: - lazy
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

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        TLLineLayout *layout = [[TLLineLayout alloc] init];
        
        CGRect tbFrame = self.tableView.frame;
        CGRect frame = CGRectOffset(tbFrame, 0, CGRectGetHeight(tbFrame));
        frame.size.height = 200;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView = collectionView;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor systemBackgroundColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:collectionView];
    }
    
    return _collectionView;
}


// MARK: - Table view data source & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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

- (nullable UITargetedPreview *)tableView:(UITableView *)tableView previewForDismissingContextMenuWithConfiguration:(UIContextMenuConfiguration *)configuration
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.indexPath];   
    return [[UITargetedPreview alloc] initWithView:cell.imageView];
}

// MARK: - Collection view data source and delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TLCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    NSString *name = [NSString stringWithFormat:@"%zi", indexPath.row % 6 + 1];
    cell.imageView.image = [UIImage imageNamed:name];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = [NSString stringWithFormat:@"%zi", indexPath.row % 6 + 1];
    CGSize size = [UIImage imageNamed:name].size;
    return CGSizeMake(size.width * 0.35, size.height * 0.35);
}

- (nullable UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point
{
    self.indexPath = indexPath;
    return [self contextMenuConfiguration];
}


- (nullable UITargetedPreview *)collectionView:(UICollectionView *)collectionView previewForHighlightingContextMenuWithConfiguration:(UIContextMenuConfiguration *)configuration {
    TLCollectionCell *cell = (TLCollectionCell *)[collectionView cellForItemAtIndexPath:self.indexPath];
    if (cell == nil) {
        return nil;
    }
    if (self.indexPath.row < 2) {
        return [[UITargetedPreview alloc] initWithView:cell.imageView];
    }
    return [[UITargetedPreview alloc] initWithView:cell];
}

- (nullable UITargetedPreview *)collectionView:(UICollectionView *)collectionView previewForDismissingContextMenuWithConfiguration:(UIContextMenuConfiguration *)configuration {
    
    TLCollectionCell *cell = (TLCollectionCell *)[collectionView cellForItemAtIndexPath:self.indexPath];
   
    return [[UITargetedPreview alloc] initWithView:cell.imageView];
}


//- (void)collectionView:(UICollectionView *)collectionView willPerformPreviewActionForMenuWithConfiguration:(UIContextMenuConfiguration *)configuration animator:(id<UIContextMenuInteractionCommitAnimating>)animator

// MARK: - Other method
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



