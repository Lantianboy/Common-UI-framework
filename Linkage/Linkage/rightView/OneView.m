//
//  OneView.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/10/26.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "OneView.h"
#import "OneCollectionViewCell.h"
@interface OneView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView * collectionView ;

@end

@implementation OneView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame ;
        [self.collectionView registerClass:[OneCollectionViewCell class] forCellWithReuseIdentifier:@"cell"] ;
        [self addSubview:self.collectionView] ;
        self.collectionView.backgroundColor = [UIColor whiteColor] ;
    }
    return self ;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray ;
    [self.collectionView reloadData] ;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new] ;
        layout.minimumInteritemSpacing = 0 ;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical ;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout] ;
        _collectionView.dataSource = self ;
        _collectionView.delegate = self ;
        
    }
    return _collectionView ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count ;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = (self.frame.size.width - 5.0) / 3.0 ;
    CGFloat cellHeight = cellWidth + 20 ;
    return CGSizeMake(cellWidth, cellHeight) ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10 ;
}

- (UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    OneCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] ;
    cell.titleLable.text = [_dataArray objectAtIndex:indexPath.row] ;
    
    return cell ;
}









@end
