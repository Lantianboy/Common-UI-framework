//
//  ViewController.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/10.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ViewController.h"
#import "ViewController5.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor] ;
    // Do any additional setup after loading the view, typically from a nib.egrehtrhtr刷新个绿点点+1+1
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ViewController5 * vi = [[ViewController5 alloc] init] ;
    [self.navigationController pushViewController:vi animated:YES] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
