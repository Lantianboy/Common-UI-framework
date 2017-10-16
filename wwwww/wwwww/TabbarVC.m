//
//  TabbarVC.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/16.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "TabbarVC.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@interface TabbarVC ()

@end

@implementation TabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    vc1.view.backgroundColor = [UIColor whiteColor];
    vc1.tabBarItem.badgeValue = @"23";
    vc1.title = @"Home";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    vc2.view.backgroundColor = [UIColor whiteColor];
    vc2.tabBarItem.badgeValue = @"12";
    vc2.title = @"yi";
    vc2.view.backgroundColor = [UIColor orangeColor] ;
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
    
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    vc3.view.backgroundColor = [UIColor whiteColor];
    vc3.tabBarItem.badgeValue = @"34";
    vc3.title = @"er";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected"];
    
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    vc4.view.backgroundColor = [UIColor whiteColor];
    vc4.tabBarItem.badgeValue = @"99+";
    vc4.title = @"san";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];
    
    
    UINavigationController * na1 = [[UINavigationController alloc] initWithRootViewController:vc1] ;
    UINavigationController * na2 = [[UINavigationController alloc] initWithRootViewController:vc2] ;
    UINavigationController * na3 = [[UINavigationController alloc] initWithRootViewController:vc3] ;
    UINavigationController * na4 = [[UINavigationController alloc] initWithRootViewController:vc4] ;
    
    self.viewControllers = @[na1,na2,na3,na4] ;
    
    UITabBar*tbb=self.tabBar;
    tbb.barStyle=UIBarStyleDefault;
    tbb.translucent=YES;
    tbb.layer.borderWidth=0.1;
    //边框颜色深度
    
    tbb.barTintColor=[UIColor whiteColor];
    //控制背景颜色
    
    tbb.tintColor=[UIColor orangeColor];
    //选中的颜色
    
    [self isIPhoneX] ;
}
//#pragma mark 测试tablet上移
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.childViewControllers.count >0) {
//        viewController.hidesBottomBarWhenPushed =YES;
//    }
//    //[super pushViewController:viewController animated:animated];
//    CGRect frame =self.tabBarController.tabBar.frame;
//    frame.origin.y =[UIScreen mainScreen].bounds.size.height -frame.size.height;
//    self.tabBarController.tabBar.frame =frame;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)isIPhoneX{
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size);
    }else{
        return NO;
    }
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
