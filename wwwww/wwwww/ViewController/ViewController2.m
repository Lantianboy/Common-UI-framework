//
//  ViewController2.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/16.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.title = @"数据持久化" ;
    UITableView * tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] ;
    tab.delegate = self ;
    tab.dataSource = self ;
    tab.tableFooterView = [UIView new] ;
    [self.view addSubview:tab] ;
    
   
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO ;
}



@end
