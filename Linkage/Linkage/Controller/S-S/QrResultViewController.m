//
//  QrResultViewController.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/19.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "QrResultViewController.h"

@interface QrResultViewController ()<UITextViewDelegate>

@end

@implementation QrResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描结果" ;
    self.view.backgroundColor = [UIColor whiteColor] ;

    self.sta = [[UITextView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT)] ;
    self.sta.textColor = [UIColor blackColor] ;
    self.sta.font = [UIFont systemFontOfSize:20] ;
    self.sta.delegate = self ;
    [self.view addSubview:self.sta] ;
    NSLog(@"%@",self.sta.text) ;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO ;
}

@end
