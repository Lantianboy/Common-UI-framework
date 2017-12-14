//
//  ViewController1.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/6.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ViewController1.h"
#import "SYHeaderView.h"
#import "PushViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
@interface ViewController1 ()<UITableViewDelegate,UITableViewDataSource,SYHeaderViewDelgate,UIScrollViewDelegate>

@property(nonatomic, strong) SYHeaderView * headerView ;
@property(nonatomic, strong) UIScrollView * scrollView ;
@property(nonatomic, strong) UITableView * leftTableView ;
@property(nonatomic, strong) NSMutableArray * leftDataArray ;
@property(nonatomic, strong) UITableView * rightTableView ;
@property(nonatomic, strong) NSMutableArray * rightDataArray ;

@property(nonatomic, strong) UITableView * rookieTableView ;
@property(nonatomic, strong) NSMutableArray * rookieDataArray ;

@end

@implementation ViewController1

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    //设置关闭抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone] ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.navigationController.navigationBar.alpha = 1 ;
    
    [self.view addSubview:self.headerView] ;
    [self.view addSubview:self.scrollView] ;
    
   
}

- (SYHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[SYHeaderView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, 40)] ;
        _headerView.delegate = self ;
    }
    return _headerView ;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT + 40, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - 40 - TABBAR_HEIGHT)] ;
        _scrollView.delegate = self ;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, _scrollView.height) ;
        _scrollView.pagingEnabled = YES ;
        _scrollView.bounces = NO ;
        _scrollView.showsHorizontalScrollIndicator = NO ;
        _scrollView.backgroundColor = UIColorFromRGB(0xf1f1f1) ;
        [_scrollView addSubview:self.leftTableView];
        [_scrollView addSubview:self.rightTableView];
        
        [_scrollView addSubview:self.rookieTableView];
    }
    return _scrollView ;
}

#pragma mark - SLInvestmentListHeaderViewDelegate
- (void)didClickButtonAtindex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        self.headerView.selectdIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {  
   
    
    if (tableView == self.leftTableView) {
        return  self.leftDataArray.count ? self.leftDataArray.count : 5 ;
    } else if (tableView == self.rightTableView) {
        return self.rightDataArray.count ? self.rightDataArray.count : 6 ;
    } else {
        return self.rookieDataArray.count ? self.rookieDataArray.count : 7 ;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = @"www" ;
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId] ;
   cell.backgroundColor = indexPath.row % 2 ? [UIColor lightGrayColor] : [UIColor whiteColor] ;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone] ;
    
    NSMutableArray *dataArray;
    if (tableView == self.leftTableView) {
        cellId = leftCellId;
        dataArray = self.leftDataArray;
        cell.textLabel.text = indexPath.row % 2 ? @"你好！" : @"不好！" ;
    } else if (tableView == self.rightTableView) {
        cellId = rightCellId;
        dataArray = self.rightDataArray;
        cell.textLabel.text = indexPath.row % 2 ? @"怎么样？" : @"不怎么样！" ;
        
    } else {
        cellId = rookieCellId;
        dataArray = self.rookieDataArray;
        cell.textLabel.text = indexPath.row % 2 ? @"就这样吧" : @"那怎么吗" ;
    }
    
    return cell ;
    
    
}

static NSString *const leftCellId = @"leftCellId";
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.height) style:UITableViewStylePlain];
        //_leftTableView.backgroundColor = [UIColor redColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 40;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        SLWeakSelf
//        _leftTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf loadDataStart:0 withProductType:@"优选项目"];
//            [weakSelf queryIsCanBuy];
//
//        }];
//        _leftTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf loadDataStart:[[self.leftDataArray.lastObject performSelector:@selector(ROWNUM_)] integerValue] withProductType:@"优选项目"];
//        }];
//
//        [_leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLInvestNewCell class]) bundle:nil] forCellReuseIdentifier:leftCellId];
//        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
//        footerView.backgroundColor = SLBackgroundColor;
//        _leftTableView.tableFooterView = footerView;
    }
    return _leftTableView;
}

static NSString *const rightCellId = @"rightCellId";
- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, _scrollView.height) style:UITableViewStylePlain];
        //_rightTableView.backgroundColor = [UIColor orangeColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 40;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//        SLWeakSelf
//        _rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf loadDataStart:0 withProductType:@"转让专区"];
//            [weakSelf queryIsCanBuy];
//
//        }];
//        _rightTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf loadDataStart:[[self.rightDataArray.lastObject performSelector:@selector(ROWNUM_)] integerValue] withProductType:@"转让专区"];
//        }];
//
//        [_rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLInvestNewCell class]) bundle:nil] forCellReuseIdentifier:rightCellId];
//        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
//        footerView.backgroundColor = SLBackgroundColor;
//        _rightTableView.tableFooterView = footerView;
    }
    return _rightTableView;
}

static NSString *const rookieCellId = @"rookieCellId";
- (UITableView *)rookieTableView {
    if (!_rookieTableView) {
        _rookieTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _scrollView.height) style:UITableViewStylePlain];
        //_rookieTableView.backgroundColor = [UIColor greenColor];
        _rookieTableView.delegate = self;
        _rookieTableView.dataSource = self;
        _rookieTableView.rowHeight = 40;
        _rookieTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
//        SLWeakSelf
//        _rookieTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf loadDataStart:0 withProductType:@"新手专区"];
//            [weakSelf queryIsCanBuy];
//
//        }];
//        _rookieTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf loadDataStart:[[self.rookieDataArray.lastObject performSelector:@selector(ROWNUM_)] integerValue] withProductType:@"新手专区"];
//        }];
//
//        [_rookieTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLInvestNewCell class]) bundle:nil] forCellReuseIdentifier:rookieCellId];
//        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
//        footerView.backgroundColor = SLBackgroundColor;
//        _rookieTableView.tableFooterView = footerView;
    }
    return _rookieTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
