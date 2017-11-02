//
//  AppDelegate.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/10/26.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface AppDelegate ()
@property (nonatomic,strong)MMDrawerController * drawerController ;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
   // UITabBarController *tabVC = [[UITabBarController alloc] init];
    ViewController *mainVC = [[ViewController alloc] init];
    //tabVC.viewControllers = @[mainVC];
    
    LeftViewController * left = [[LeftViewController alloc] init] ;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC] ;
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]} ;
    nav.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    
    //创建中心视图和左侧视图
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:nav leftDrawerViewController:left] ;
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
    
    
    
    
    
    
    
    // Override point for customization after application launch.
    return YES;
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
