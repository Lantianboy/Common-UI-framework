//
//  DrawBarViewController.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/15.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "DrawBarViewController.h"

@interface DrawBarViewController ()

@end

@implementation DrawBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    UILabel * la = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 115, 300, 230, 35)] ;
    la.text = @"条形码太LOW,请用二维码！" ;
    la.textColor = [UIColor redColor] ;
    la.font = [UIFont systemFontOfSize:18] ;
    [self.view addSubview:la] ;
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
