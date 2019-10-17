//
//  TLCollectionCell.h
//  TabBar
//
//  Created by 故乡的云 on 2019/10/17.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN API_AVAILABLE(ios(13.0))
@interface TLCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgeView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
