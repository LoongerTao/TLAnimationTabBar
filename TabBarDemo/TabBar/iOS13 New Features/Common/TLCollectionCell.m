//
//  TLCollectionCell.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/17.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLCollectionCell.h"

@implementation TLCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textLabel.textColor = [UIColor labelColor];
}

@end
