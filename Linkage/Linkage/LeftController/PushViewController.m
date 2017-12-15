//
//  PushViewController.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/3.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "PushViewController.h"
@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT)];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, NAVIGATION_HEIGHT+100, self.view.frame.size.width-100, 30)];
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

@end
