//
//  PBCollectionViewLayout.h
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/9.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PBCollectionViewLayout ;

@protocol PBFallsLayoutDelegate <NSObject>

/// 列数
- (CGFloat)columnCountInFallsLayout:(PBCollectionViewLayout *)fallsLayout;
/// 列间距
- (CGFloat)columnMarginInFallsLayout:(PBCollectionViewLayout *)fallsLayout;
/// 行间距
- (CGFloat)rowMarginInFallsLayout:(PBCollectionViewLayout *)fallsLayout;
/// collectionView边距
- (UIEdgeInsets)edgeInsetsInFallsLayout:(PBCollectionViewLayout *)fallsLayout;


@end

@interface PBCollectionViewLayout : UICollectionViewLayout
@property (nonatomic, weak) id<PBFallsLayoutDelegate> delegate;

@end
