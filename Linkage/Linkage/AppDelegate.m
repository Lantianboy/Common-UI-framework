//
//  AppDelegate.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/10/26.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import <UMSocialCore/UMSocialCore.h>


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define APPKEY @"5a0d3a11f29d9827ea0000a8"
@interface AppDelegate ()
@property (nonatomic,strong)MMDrawerController * drawerController ;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
   // UITabBarController *tabVC = [[UITabBarController alloc] init];
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
    
    
    //tabVC.viewControllers = @[mainVC];
    
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
    [self.drawerController setMaximumLeftDrawerWidth:kScreenWidth - 100] ;
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
    
    
    
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:APPKEY];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)configUSharePlatforms
{
    //微信分享
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:nil];
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
