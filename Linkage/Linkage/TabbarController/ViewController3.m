//
//  ViewController3.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/6.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ViewController3.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <SVProgressHUD.h>
@interface ViewController3 ()

@end

@implementation ViewController3

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    //设置关闭抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone] ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.navigationController.navigationBar.alpha = 1 ;
    // Do any additional setup after loading the view.
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(35, 100, 100, 100)] ;
    btn.backgroundColor = [UIColor orangeColor] ;
    [btn setTitle:@"微信分享" forState:UIControlStateNormal] ;
    [btn addTarget:self action:@selector(fenxiang) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:btn] ;
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(250, 100, 100, 100)] ;
    btn1.backgroundColor = [UIColor orangeColor] ;
    [btn1 setTitle:@"短信分享" forState:UIControlStateNormal] ;
    [btn1 addTarget:self action:@selector(fenxiang1) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:btn1] ;
    
}

- (void)fenxiang
{
    __weak typeof(self) weakSelf = self;
    [weakSelf share:UMSocialPlatformType_WechatSession withText:@"你好啊"];
}

- (void)fenxiang1
{
    __weak typeof(self) weakSelf = self;
    [weakSelf share:UMSocialPlatformType_Sms withText:@"sjdjsid"];
}


-(void)share:(UMSocialPlatformType)type  withText:(NSString*)string
{
    UMSocialMessageObject *object = [UMSocialMessageObject messageObject];
    
    object.text = string;
    
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:object currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            
            [SVProgressHUD showErrorWithStatus:@"分享失败"];
            NSLog(@"%@",error);
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"分享成功"];
            NSLog(@"%@",result);
        }
        
    }];
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
