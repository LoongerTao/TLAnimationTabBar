//
//  TLCollectionCell.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/17.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLCollectionCell.h"

@implementation TLCollectionCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.contentView.bounds;
    self.imageView.frame = rect;
    self.textLabel.frame = CGRectMake(0, rect.size.height - 30, rect.size.width, 30);
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        _imageView = imgView;
        imgView.layer.cornerRadius = 6;
        imgView.layer.masksToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:imgView];
    }
    return  _imageView;
}

- (UILabel *)textLabel {
    if (_textLabel == nil) {
        UILabel *textLabel = [[UILabel alloc] init];
        _textLabel = textLabel;
        textLabel.textColor = [UIColor labelColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont italicSystemFontOfSize:14];
        [self.contentView addSubview: textLabel];
    }
    return  _textLabel;
}
@end
