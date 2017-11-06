//
//  PushViewController.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/3.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "PushViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTabbarHeight (kDevice_Is_iPhoneX ? 83:64)
#define kNavHeight (kDevice_Is_iPhoneX ? 88:64)
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)//判断是否为iPhoneX
@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, kNavHeight, kScreenWidth, kScreenHeight-kNavHeight)];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, kNavHeight+100, self.view.frame.size.width-100, 30)];
    label.text = self.titleString;
    label.textColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    // Do any additional setup after loading the view.
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
