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

@interface ViewController1 ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemClickde)] ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClicked)] ;
    self.view.backgroundColor = [UIColor redColor] ;
    
    //self.navigationItem.searchController =YES ;
    
    [self tab] ;
    
    // Do any additional setup after loading the view.
}
- (void)tab
{
    UITableView * tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain] ;
    tab.backgroundColor = [UIColor whiteColor] ;
    tab.delegate = self ;
    tab.dataSource = self ;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.showsVerticalScrollIndicator = NO;
    /// iOS11 fix
    if (@available(iOS 11.0, *)) {
        tab.estimatedRowHeight = 0;
        tab.estimatedSectionFooterHeight = 0;
        tab.estimatedSectionHeaderHeight = 0;
    }
    [self.view addSubview:tab] ;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6 ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( section == 3) {
        return 8 ;
    }else{
        return 0 ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"one" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.textLabel.text = indexPath.row % 2 ? @"你好！" : @"不好！" ;
    cell.backgroundColor = indexPath.row % 2 ? [UIColor lightGrayColor] : [UIColor whiteColor] ;
    
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController * vi = [[ViewController alloc] init ];
    vi.title = @"阳光明媚" ;
    vi.view.backgroundColor = [UIColor greenColor] ;
    //vi.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:vi animated:YES] ;
}

- (void)leftBarButtonItemClickde
{
    ViewController * vi =[[ViewController alloc] init] ;
    //vi.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:vi animated:YES] ;
    
}

- (void)rightBarButtonItemClicked
{
    [(TabbarVC * )[UIApplication sharedApplication].keyWindow.rootViewController setSelectedIndex:1] ;
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
