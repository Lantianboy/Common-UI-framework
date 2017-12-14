//
//  LeftViewController.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/2.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "LeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "PushViewController.h"

@interface LeftViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray * array ;
@end

@implementation LeftViewController

- (NSMutableArray * )array
{
    if (!_array) {
        _array = [NSMutableArray arrayWithObjects:@"开通会员",@"开通黄钻",@"我的空间",@"特别关注",@"今日热卖",@"每日一笑",@"我的部落", nil] ;
    }
    return _array ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor orangeColor] ;
    
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:self.view.bounds] ;
    imageV.image = [UIImage imageNamed:@"leftbackiamge"] ;
    [self.view addSubview:imageV] ;
    
    UITableView * tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 100, self.view.frame.size.height)] ;
    tab.dataSource = self ;
    tab.delegate =self ;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone ;
    tab.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:tab] ;
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count ;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"str" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] ;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    cell.textLabel.font = [UIFont systemFontOfSize:20] ;
    cell.backgroundColor = [UIColor clearColor] ;
    cell.textLabel.textColor = [UIColor whiteColor] ;
    cell.textLabel.text =self.array[indexPath.row] ;
    
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    
    PushViewController * pushVc = [[PushViewController alloc] init] ;
    pushVc.titleString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text ;
    //MMDrawerController * mm = [[MMDrawerController alloc] init] ;
    
    UITabBarController * tab = (UITabBarController *)self.mm_drawerController.centerViewController ;
    //拿到当前tab
    UINavigationController *nav = (UINavigationController *)tab.viewControllers[tab.selectedIndex];
    pushVc.hidesBottomBarWhenPushed = YES ;
    [nav pushViewController:pushVc animated:NO] ;
    
    
    
    //当push成功后 关闭的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished){
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone] ;
    }] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180 ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)] ;
    view.backgroundColor = [UIColor clearColor] ;
    
    UIButton * imageBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    imageBtn.frame = CGRectMake(CGRectGetWidth(view.frame) / 2 - 25, 40, 50, 50) ;
    imageBtn.layer.cornerRadius = 25 ;
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"icon_tabbar_mine_selected"] forState:UIControlStateNormal] ;
    [view addSubview:imageBtn] ;
    [imageBtn addTarget:self action:@selector(imageBtn) forControlEvents:UIControlEventTouchUpInside] ;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageBtn.frame)+5, tableView.bounds.size.width, 20)];
    nameLabel.text = @"ZWJ-China";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    return view ;
}

- (void)imageBtn {
    
    PushViewController *pushVC = [[PushViewController alloc] init];
    pushVC.titleString = @"个人资料";
    UITabBarController * tab = (UITabBarController *)self.mm_drawerController.centerViewController ;
    //拿到当前tab
    UINavigationController *nav = (UINavigationController *)tab.viewControllers[tab.selectedIndex];
    pushVC.hidesBottomBarWhenPushed = YES ;
    
    [nav pushViewController:pushVC animated:NO];
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
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
