//
//  TabBarViewController.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/19.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "LeftViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface TabBarViewController ()


@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewController *mainVC = [[ViewController alloc] init];
    mainVC.title = @"手机" ;
    mainVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"] ;
    mainVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"] ;
    
    ViewController1 * vc2 = [[ViewController1 alloc] init] ;
    vc2.title = @"钱包" ;
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"] ;
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"] ;
    
    ViewController2 * vc3 = [[ViewController2 alloc] init] ;
    vc3.title = @"钥匙" ;
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"] ;
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected"] ;
    
    ViewController3 * vc4 = [[ViewController3 alloc] init] ;
    vc4.title = @"充电宝" ;
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"] ;
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_selected"] ;
    
    LeftViewController * left = [[LeftViewController alloc] init] ;
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc2] ;
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc3] ;
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc4] ;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC] ;
    
    //nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]} ;
    
    UITabBarController * tab = [[UITabBarController alloc] init] ;
    tab.viewControllers = @[nav,nav1,nav2,nav3] ;
    UITabBar*tbb=tab.tabBar;
    tbb.barStyle=UIBarStyleDefault;
    tbb.translucent=YES;
    tbb.layer.borderWidth=0.1;
    //tab.selectedIndex = self.selectedIndex ;
    //边框颜色深度
    
    tbb.barTintColor=[UIColor whiteColor];
    //控制背景颜色
    
    tbb.tintColor=[UIColor orangeColor];
    //选中的颜色
    nav.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    nav1.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    nav2.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    nav3.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    
    //创建中心视图和左侧视图
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:tab leftDrawerViewController:left] ;
    //是否开启阴影效果
    [self.drawerController setShowsShadow:YES] ;
    //设置左侧视图最大宽度 屏幕宽度减一百
    [self.drawerController setMaximumLeftDrawerWidth:SCREEN_WIDTH - 100] ;
    //左侧视图开启手势
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll] ;
    //左侧视图关闭手势
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll] ;
    //设置左侧视图出现时的自定义动画
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController * drawerController, MMDrawerSide drawerSide, CGFloat percentVisible){
        MMDrawerControllerDrawerVisualStateBlock block ;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide] ;
        if (block) {
            block(drawerController, drawerSide, percentVisible) ;
        }
    }] ;//侧滑效果
    
    self.window.backgroundColor = [UIColor whiteColor] ;
    self.window.rootViewController = self.drawerController ;
   
}



@end
