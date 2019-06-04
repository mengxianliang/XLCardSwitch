//
//  XLCardSwitchFlowLayout.m
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLCardSwitchFlowLayout.h"

//居中卡片宽度与据屏幕宽度比例
static float CardWidthScale = 0.7f;
static float CardHeightScale = 0.8f;

@implementation XLCardSwitchFlowLayout

//初始化方法
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake([self insetY], [self insetX], [self insetY], [self insetX]);
    self.itemSize = CGSizeMake([self itemWidth], [self itemHeight]);
    self.minimumLineSpacing = 5;
}

//设置缩放动画
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //获取cell的布局
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //最大移动距离，计算范围是移动出屏幕前的距离
    CGFloat maxApart = (self.collectionView.bounds.size.width + [self itemWidth])/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in attributesArr) {
        //获取cell中心和屏幕中心的距离
        CGFloat apart = fabs(attributes.center.x - centerX);
        //移动进度 -1~0~1
        CGFloat progress = apart/maxApart;
        //在屏幕外的cell不处理
        if (fabs(progress) > 1) {continue;}
        //根据余弦函数，弧度在 -π/4 到 π/4,即 scale在 √2/2~1~√2/2 间变化
        CGFloat scale = fabs(cos(progress * M_PI/4));
        //缩放大小
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
        //更新中间位
        if (apart <= [self itemWidth]/2.0f) {
            self.centerBlock(attributes.indexPath);
        }
    }
    return attributesArr;
}

#pragma mark -
#pragma mark 配置方法
//卡片宽度
- (CGFloat)itemWidth {
    return self.collectionView.bounds.size.width * CardWidthScale;
}

- (CGFloat)itemHeight {
    return self.collectionView.bounds.size.height * CardHeightScale;
}

//设置左右缩进
- (CGFloat)insetX {
    CGFloat insetX = (self.collectionView.bounds.size.width - [self itemWidth])/2.0f;
    return insetX;
}

- (CGFloat)insetY {
    CGFloat insetY = (self.collectionView.bounds.size.height - [self itemHeight])/2.0f;
    return insetY;
}

//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

@end
