//
//  ViewController1.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/16.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ViewController1.h"
#import "TabbarVC.h"
#import "ViewController.h"
#import "ViewXib.h"
#import "TableViewDelegate.h"

@interface ViewController1 ()
@property(nonatomic,strong) ViewXib * vix ;
@property (nonatomic, strong) TableViewDelegate *delegateObject;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemClickde)] ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClicked)] ;
    self.view.backgroundColor = [UIColor redColor] ;
    NSMutableArray * mut = [NSMutableArray arrayWithObjects:@"2",@"3",@"4",@"5",@"5",@"6", nil];
    
    /**
     下面只是简单的实现了将UITableView的点击事件传递出来，如果当前类和代理对象交互比较复杂和频繁，可以考虑用代理的形式来传递事件。
     在代理和block的选取中，一定要记住：代理是面向过程的回调，block是面向结果的回调。
     */
    self.delegateObject = [TableViewDelegate createTableViewDelegateWithDataList:mut selectBlock:^(NSIndexPath * indexPath){
        
            ViewController * vi = [[ViewController alloc] init ];
            vi.title = @"阳光明媚" ;
            vi.view.backgroundColor = [UIColor greenColor] ;
            [self.navigationController pushViewController:vi animated:YES];
            
            //vi.hidesBottomBarWhenPushed = YES ;
            NSLog(@"点击了%ld",indexPath.section);
        
    }] ;
    
    //self.navigationItem.searchController =YES ;
    
    [self tab] ;
    
    // Do any additional setup after loading the view.
}
- (void)tab
{
    UITableView * tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain] ;
    tab.backgroundColor = [UIColor whiteColor] ;
    tab.delegate = self.delegateObject ;
    tab.dataSource = self.delegateObject ;
    //取消多余的cell
    tab.tableFooterView = self.vix ;
    //去掉tabcell下划线
    //tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.showsVerticalScrollIndicator = NO;
    [tab reloadData] ;
    
    
    
    // iOS11 fix
    if (@available(iOS 11.0, *)) {
        tab.estimatedRowHeight = 0;
        tab.estimatedSectionFooterHeight = 0;
        tab.estimatedSectionHeaderHeight = 0;
    }
    [self.view addSubview:tab] ;
    
}

- (ViewXib *)vix
{
    if (!_vix) {
        _vix = [ViewXib initView] ;
        _vix.frame = CGRectMake(0, 0, 414, 400) ;
        
    }
    return _vix ;
}

- (void)leftBarButtonItemClickde
{
    ViewController * vi =[[ViewController alloc] init] ;
    //vi.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:vi animated:YES] ;
    
}

- (void)rightBarButtonItemClicked
{
    //跳转到tabbar下标为一的
    [(TabbarVC * )[UIApplication sharedApplication].keyWindow.rootViewController setSelectedIndex:1] ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
