//
//  TabBarViewController.h
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/19.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
@interface TabBarViewController : UITabBarController
@property (strong, nonatomic) UIWindow * window ;
@property (nonatomic,strong)MMDrawerController * drawerController ;

@end
