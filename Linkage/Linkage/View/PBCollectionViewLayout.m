//
//  PBCollectionViewLayout.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/9.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "PBCollectionViewLayout.h"

@interface PBCollectionViewLayout()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray; ///< 所有的cell的布局
@property (nonatomic, strong) NSMutableArray *columnHeights;                                  ///< 每一列的高度
@property (nonatomic, assign) NSInteger noneDoubleTime;                                       ///< 没有生成大尺寸次数
@property (nonatomic, assign) NSInteger lastDoubleIndex;                                      ///< 最后一次大尺寸的列数
@property (nonatomic, assign) NSInteger lastFixIndex;                                         ///< 最后一次对齐矫正列数

- (CGFloat)columnCount;     ///< 列数
- (CGFloat)columnMargin;    ///< 列边距
- (CGFloat)rowMargin;       ///< 行边距
- (UIEdgeInsets)edgeInsets; ///< collectionView边距

@end


@implementation PBCollectionViewLayout

#pragma mark - 默认参数
static const CGFloat JKRDefaultColumnCount = 3;                           ///< 默认列数
static const CGFloat JKRDefaultColumnMargin = 10;                         ///< 默认列边距
static const CGFloat JKRDefaultRowMargin = 10;                            ///< 默认行边距
static const UIEdgeInsets JKRDefaultUIEdgeInsets = {10, 10, 10, 10};      ///< 默认collectionView边距

#pragma mark - 布局计算
//collectionView 首次布局和重新布局之后会调用
//并不是每次滑动都调用 只有在数据变化时才才调用
- (void)prepareLayout
{
    //重写必须调用super方法
    [super prepareLayout] ;
    
    //判断如果有50个cell (首次刷新) 重新计算
    if ([self.collectionView numberOfItemsInSection:0] == 50) {
        [self.attrsArray removeAllObjects] ;
        [self.columnHeights removeAllObjects] ;
    }
}

















@end
