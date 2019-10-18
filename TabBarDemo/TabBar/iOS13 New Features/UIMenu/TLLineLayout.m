//
//  TLLineLayout.m
//  TabBar
//
//  Created by 故乡的云 on 2019/10/18.
//  Copyright © 2019 故乡的云. All rights reserved.
//

#import "TLLineLayout.h"

@implementation TLLineLayout
- (instancetype)init {
    if (self = [super init]) {
        self.minimumLineSpacing = 30;
        self.minimumInteritemSpacing = 50;
        CGFloat inset = 50;
        self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

#pragma mark - 重写父类方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}


/**
 *  布局显示rect范围内的元素属性，要实现父类的该方法
 *
 *  @param rect 显示区域
 *
 *  @return 元素属性数组
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    
    NSArray *attrs = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    // 修改item的形变属性
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5; // 当前屏幕显示区域的中心点x
    CGFloat itemCenterX = 0; // item 的中心x
    CGFloat d = 0; // item 的中心x到屏幕显示中心的距离
    CGFloat scale = 1.0;
    
    for (UICollectionViewLayoutAttributes *itme in attrs) {
        itemCenterX = itme.center.x;
        d = centerX - itemCenterX;
        scale = 1.4 - ABS(d) / self.collectionView.bounds.size.width;
        itme.transform3D = CATransform3DMakeScale(scale, scale, scale);
    }
    
    return attrs;
}

/**
 *  确定滚动结束的最终停止偏移量
 *
 *  @param proposedContentOffset 预计结束时的偏移量
 *  @param velocity              滚动速度
 *
 *  @return 最终偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;

    // 获取最终显示items的属性
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5; // 最终屏幕显示区域的中心点x
    CGFloat itemCenterX = 0; // item 的中心x
    CGFloat minD = MAXFLOAT; // item 的中心x到屏幕显示中心的最小距离
    
    for (UICollectionViewLayoutAttributes *itme in attrs) {
        itemCenterX = itme.center.x;
        minD = ABS(minD) > ABS(centerX - itemCenterX) ? centerX - itemCenterX : minD;
    }

    return CGPointMake(proposedContentOffset.x - minD, 0);
}

@end
