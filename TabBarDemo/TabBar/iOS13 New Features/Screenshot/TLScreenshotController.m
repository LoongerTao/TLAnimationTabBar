//
//  TLScreenshotController.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/16.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLScreenshotController.h"

@interface TLScreenshotController ()<UIScreenshotServiceDelegate>

@end

@implementation TLScreenshotController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"reuseIdentifier"];
    self.tableView.rowHeight = 70;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    UIImage *img = [UIImage imageNamed:@"screenshot"];
    UIImageView *header = [[UIImageView alloc] initWithImage:img];
    header.contentMode = UIViewContentModeCenter;
    header.frame = CGRectMake(0, 0, self.view.bounds.size.width, 500);
    self.tableView.tableHeaderView = header;
    
    // 设置UIScreenshotService代理
    UIScreenshotService *screenshotService = [UIApplication sharedApplication].keyWindow.windowScene.screenshotService;
    screenshotService.delegate = self;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"yanhua"];
    cell.textLabel.text = [NSString stringWithFormat:@"Table View Cell For Row At [%zi, %zi]", indexPath.section, indexPath.row];
    return cell;
}

// MARK: - UIScreenshotServiceDelegate
- (void)screenshotService:(UIScreenshotService *)screenshotService generatePDFRepresentationWithCompletion:(void (^)(NSData * _Nullable, NSInteger, CGRect))completionHandler {
    
    // 临时更改self.tableView.frame的frame，保证tableView能够完整的渲染出来
    CGRect frame = self.tableView.frame;
    CGRect toframe = frame;
    toframe.size = self.tableView.contentSize;
    self.tableView.frame = toframe;
    
    // 将table view 渲染成PDF,参考：
    // https://stackoverflow.com/questions/5443166/how-to-convert-uiview-to-pdf-within-ios/6566696#6566696
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, self.tableView.frame, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    [self.tableView.layer renderInContext:pdfContext];

    UIGraphicsEndPDFContext();
    
    // 恢复tableView frame
    self.tableView.frame = frame;

    // 输入PDF
    completionHandler(pdfData, 1, self.tableView.bounds);
}


@end
