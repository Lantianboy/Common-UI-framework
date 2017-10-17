//
//  NavigationController.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/17.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "NavigationController.h"
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark 测试tablet上移
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed =YES;
    }
    [super pushViewController:viewController animated:animated];
    CGRect frame =self.tabBarController.tabBar.frame;
    frame.origin.y =[UIScreen mainScreen].bounds.size.height -frame.size.height;
    self.tabBarController.tabBar.frame =frame;
}

//- (BOOL)isIPhoneX{
//    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
//        return CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size);
//    }else{
//        return NO;
//    }
//}


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
