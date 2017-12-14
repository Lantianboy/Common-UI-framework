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
#import "ZSKTagView.h"


@interface ViewController2 ()<UICollectionViewDataSource,PBFallsLayoutDelegate,UISearchBarDelegate>
{
    UIButton * _btn ;
    
}


@property (nonatomic, weak) UICollectionView * collectionView ;
@property (nonatomic, strong) NSMutableArray * shops ;

@property (nonatomic, strong) UISearchBar * searchBar ;
@property (nonatomic, strong) NSMutableArray * dataSource ;
@property (nonatomic, strong) ZSKTagView * sktagView ;
@property (nonatomic, strong) UIView * bgView ;

@end

@implementation ViewController2

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    //设置关闭抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone] ;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(text:) name:@"test" object:nil] ;
}


- (void)viewWillDisappear:(BOOL)animated
{
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
    NSLog(@"销毁了") ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor orangeColor] ;
    self.navigationController.navigationBar.alpha = 0 ;
    [self setupCollectionView] ;
    [self setupRefresh] ;

   
    
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    _btn.frame = CGRectMake(SCREEN_WIDTH - 50, 350, 50, 50) ;
    _btn.layer.cornerRadius = 25 ;
    _btn.layer.masksToBounds = 25 ;
    _btn.backgroundColor = [UIColor whiteColor] ;
    [_btn setTitle:@"TOP" forState:0] ;
    _btn.hidden = YES ;
    _btn.alpha = 0.7 ;
    [_btn setTitleColor:[UIColor orangeColor] forState:0] ;
    [_btn addTarget:self action:@selector(toping) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:_btn] ;

    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)] ;
    titleView.backgroundColor = [UIColor clearColor] ;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 44)] ;
    self.searchBar.delegate = self ;
    self.searchBar.placeholder = @"请输入关键字" ;
    //键盘确认按钮的名字
    self.searchBar.showsCancelButton = YES ;
    //把默认的灰色背景浮层去掉
    self.searchBar.returnKeyType = UIReturnKeyNext ;
    self.searchBar.backgroundColor = [UIColor clearColor] ;
    self.searchBar.backgroundImage = [UIImage new] ;
    [titleView addSubview:self.searchBar] ;
    self.navigationItem.titleView = titleView ;
    //[self.searchBar becomeFirstResponder] ;
    
    
    
    [self.view addSubview:self.bgView] ;
    [self.view addSubview:self.sktagView] ;
    
    
    //添加监听者 kvo
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil] ;
    
    
}

#pragma mark - 监听属性值发生变化时回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat offset = self.collectionView.contentOffset.y ;
    NSLog(@"%f",offset) ;
    if (offset > 300.0) {
        _btn.hidden = NO ;
    }else{
        _btn.hidden = YES ;
    }
    
}

static NSString *const ID = @"shop";

#pragma  mark - 创建collectionView
- (void)setupCollectionView
{
    PBCollectionViewLayout * fallsLayout = [[PBCollectionViewLayout alloc] init];
    fallsLayout.delegate = self ;
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT - 20, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - 20) collectionViewLayout:fallsLayout] ;
    [self.view addSubview:collectionView] ;
    _collectionView = collectionView ;
    collectionView.dataSource = self ;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PBShopCell class]) bundle:nil] forCellWithReuseIdentifier:ID] ;
    
    
}

#pragma mark - 创建上下拉刷新
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)] ;
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)] ;
    self.collectionView.backgroundColor = [UIColor whiteColor] ;
    [self.collectionView.mj_header beginRefreshing] ;
}

#pragma  mark - 加载下拉数据
- (void)loadNewShops
{
    
    NSString *home = NSHomeDirectory();
    
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    
    // 3.文件路径
    NSString *filepath = [docPath stringByAppendingPathComponent:@"1.plist"];
    
    // 4.读取数据  不明白为什么读取不出来数据
    NSArray *are = [NSArray arrayWithContentsOfFile:filepath];
    
//    NSDictionary * dic=[[NSMutableDictionary alloc]initWithContentsOfFile:filepath ];
    __weak typeof (self) weakSelf = self ;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray * shops = [PBShop mj_keyValuesArrayWithObjectArray:are] ;
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

#pragma mark - 加载上拉数据
- (void)loadMoreShops
{
    __weak typeof (self) weakSelf = self ;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray * shops = [PBShop mj_objectArrayWithFilename:@"pb1.plist"] ;
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
    return self.shops.count ? self.shops.count : 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PBShopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath] ;
//    if (self.shops && self.shops.count >= indexPath.item + 1) {
//        cell.shop = self.shops[indexPath.item] ;
//    }
    
   
    
    //不知道为什么警告nib本地图片加载不出来
    cell.imageView.image = [UIImage imageNamed:@"YangPB"] ;
    cell.imageView.userInteractionEnabled = YES ;
    cell.priceLable.text = @"杨紫曦" ;
    //cell.imageView.backgroundColor = [UIColor redColor] ;
    
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

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
//{
//    NSLog(@"点击了%ldItem",indexPath.row) ;
//    [self.searchBar resignFirstResponder] ;
//    self.sktagView.hidden = YES ;
//    
//}

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array] ;
    }
    return _shops ;
}
#pragma mark - top回到顶层按键方法
- (void)toping
{
    NSIndexPath * top = [NSIndexPath indexPathForRow:0 inSection:0] ;
    [self.collectionView scrollToItemAtIndexPath:top atScrollPosition:UICollectionViewScrollPositionTop animated:YES] ;
}


#pragma mark - 加载SktagView
- (ZSKTagView *)sktagView
{
    if (!_sktagView) {
        _sktagView = [[ZSKTagView alloc] initWithFrame:CGRectMake(10, NAVIGATION_HEIGHT, SCREEN_WIDTH - 20, 200)] ;
        _sktagView.backgroundColor = [UIColor whiteColor] ;
        _sktagView.layer.cornerRadius = 5.98 ;
        _sktagView.hidden = YES ;
    }
    return _sktagView ;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.sktagView.hidden = NO ;
    self.bgView.hidden = NO ;
    return YES ;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder] ;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil] ;
    self.sktagView.hidden = YES ;
    self.bgView.hidden = YES ;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText) ;
    if (searchText.length == 0) {
        self.sktagView.hidden = NO ;
        self.bgView.hidden = NO ;
    }else{
        self.sktagView.hidden = YES ;
        
    }
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.view.bounds] ;
        _bgView.backgroundColor = [UIColor blackColor] ;
        _bgView.alpha = 0.5 ;
        _bgView.hidden = YES ;
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTap:)]] ;
    }
    return _bgView ;
}

- (void)bgViewTap:(UITapGestureRecognizer *)tap
{
    self.sktagView.hidden = YES ;
    [self.searchBar resignFirstResponder] ;
    self.bgView.hidden = YES ;
}

- (void)text:(NSNotification *)notifica
{
    NSLog(@"--%@",notifica.object) ;
    self.searchBar.text = notifica.object ;
    self.sktagView.hidden = YES ;
    self.bgView.hidden = YES ;
}

- (void) searchDisplayControllerWillEndSearch:(UISearchController *)controller;
{
    self.bgView.hidden = NO ;
}


@end
