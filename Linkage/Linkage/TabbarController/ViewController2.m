//
//  ViewController2.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/6.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ViewController2.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "PBCollectionViewLayout.h"
#import "PBShop.h"
#import "PBShopCell.h"

@interface ViewController2 ()<UICollectionViewDataSource,PBFallsLayoutDelegate>

@property (nonatomic, weak) UICollectionView * collectionView ;
@property (nonatomic, strong) NSMutableArray * shops ;

@end

@implementation ViewController2

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    //设置关闭抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone] ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor orangeColor] ;
    self.navigationController.navigationBar.alpha = 0 ;
    [self setupCollectionView] ;
    [self setupRefresh] ;

    
    
}
static NSString *const ID = @"shop";

#pragma  mark - 创建collectionView
- (void)setupCollectionView
{
    PBCollectionViewLayout * fallsLayout = [[PBCollectionViewLayout alloc] init];
    fallsLayout.delegate = self ;
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:fallsLayout] ;
    [self.view addSubview:collectionView] ;
    _collectionView = collectionView ;
    self.collectionView.backgroundColor = [UIColor redColor] ;
    collectionView.dataSource = self ;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PBShopCell class]) bundle:nil] forCellWithReuseIdentifier:ID] ;
    
}

#pragma mark - 创建上下拉刷新
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)] ;
    self.collectionView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)] ;
    self.collectionView.backgroundColor = [UIColor whiteColor] ;
    [self.collectionView.mj_header beginRefreshing] ;
}

#pragma  mark - 加载下拉数据
- (void)loadNewShops
{
    __weak typeof (self) weakSelf = self ;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray * shops = [PBShop mj_objectArrayWithFilename:@"1.plist"] ;
        [weakSelf.shops removeAllObjects] ;
        NSLog(@"下拉了") ;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData] ;
            [weakSelf.shops addObjectsFromArray:shops] ;
            [weakSelf.collectionView.mj_header endRefreshing] ;
            [weakSelf.collectionView reloadData] ;
        }) ;
    }) ;
}

#pragma mark - 加载下拉数据
- (void)loadMoreShops
{
    __weak typeof (self) weakSelf = self ;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray * shops = [PBShop mj_objectArrayWithFilename:@"1.plist"] ;
        NSLog(@"上拉了") ;
        [weakSelf.shops addObjectsFromArray:shops] ;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView.mj_footer endRefreshing] ;
            [weakSelf.collectionView reloadData] ;
        }) ;
    }) ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.mj_footer.hidden = self.shops.count == 0 ;
    return self.shops.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PBShopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath] ;
    if (self.shops && self.shops.count >= indexPath.item + 1) cell.shop = self.shops[indexPath.item] ;
    
    return cell ;
}

- (CGFloat)columnMarginInFallsLayout:(PBCollectionViewLayout *)fallsLayout
{
    return 5 ;
}

- (CGFloat)rowMarginInFallsLayout:(PBCollectionViewLayout *)fallsLayout
{
    return 5 ;
}

- (CGFloat)columnCountInFallsLayout:(PBCollectionViewLayout *)fallsLayout
{
    return 3 ;
}

- (UIEdgeInsets)edgeInsetsInFallsLayout:(PBCollectionViewLayout *)fallsLayout
{
    return UIEdgeInsetsMake(20, 10, 20, 10) ;
}

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array] ;
    }
    return _shops ;
}





@end
