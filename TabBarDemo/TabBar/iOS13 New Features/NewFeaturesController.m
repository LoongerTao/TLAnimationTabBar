//
//  NewFeaturesController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/16.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "NewFeaturesController.h"
#import "TLScreenshotController.h"
#import "SFSymbolController.h"
#import "TLMenusController.h"
#import "TLBarsAppearanceController.h"

@interface NewFeaturesController ()
@property(nonatomic, strong) NSArray *items;
@end

@implementation NewFeaturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 60;
    
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemClose target:self action:@selector(back)];
    

    self.items = @[
        @{
            @"title": @"系统截图时将页面生成PDF(截长图)",
            @"cls": [TLScreenshotController class]
        },
        @{
            @"title": @"SF Symbol 简单应用",
            @"cls": [SFSymbolController class]
        },
        @{
            @"title": @"Menus",
            @"cls": [TLMenusController class]
        },
        @{
            @"title": @"Bars Appearance",
            @"cls": [TLBarsAppearanceController class]
        }
    ];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


// MARK: - table view data source & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.items[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [self.items[indexPath.row][@"cls"] new];
    vc.title = self.items[indexPath.row][@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}


// MARK: - Actions
- (void)testSnapshot {
    
}

- (void)testTabBarAppearance {
    
}

- (void)testUIMenu {
    
}
@end
