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
#import "SheetView.h"
@interface ViewController3 ()<SheetViewDelgate>

@property (nonatomic, strong) SheetView * sheet ;

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
    //[self.view addSubview:self.sheetView] ;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, 200, 100, 50)] ;
    btn.backgroundColor = [UIColor orangeColor] ;
    [btn setTitle:@"点击分享" forState:UIControlStateNormal] ;
    [btn addTarget:self action:@selector(sheet2) forControlEvents:UIControlEventTouchUpInside] ;
    btn.layer.cornerRadius = 8.72 ;
    [self.view addSubview:btn] ;
    
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, 400, 100, 50)] ;
    btn1.backgroundColor = [UIColor orangeColor] ;
    [btn1 setTitle:@"点击分享" forState:UIControlStateNormal] ;
    [btn1 addTarget:self action:@selector(sheet1) forControlEvents:UIControlEventTouchUpInside] ;
    btn1.layer.cornerRadius = 8.72 ;
    [self.view addSubview:btn1] ;

    
}

- (void)sheet1
{
    [self.sheet showWithController:self] ;
}

- (SheetView *)sheet
{
    if (!_sheet) {
        _sheet = [[SheetView alloc] initWithTitle:@"分享" message:@"请选择分享方式"] ;
        
        _sheet.sheetDelgate = self ;
        _sheet.actionTitles = @[@"微信",@"短信",@"取消"] ;
    }
    return _sheet ;
}

- (UIAlertActionStyle)sheetView:(SheetView *)sheetView actionStyleAtIndex:(NSInteger)index
{
    if (index == 0) {
        return UIAlertActionStyleDestructive ;
    }else if (index == sheetView.actionTitles.count - 1){
        return UIAlertActionStyleCancel ;
    }
    return UIAlertActionStyleDefault ;
}

- (void)sheetView:(SheetView *)sheetView didSelectedAtIndex:(NSInteger)index
{
    if (index == 0) {
        NSLog(@"微信") ;
    }
    if (index == 1) {
        NSLog(@"短信") ;
    }
    if (index == 2) {
        NSLog(@"取消") ;
    }
}

- (void)sheet2
{
    //直接创建sheetView
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择分享方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"微信分享" otherButtonTitles:@"短信分享", nil] ;
//    actionSheet.actionSheetStyle = UIActionSheetStyleDefault ;
//    [actionSheet showInView:self.view] ;
    
    //创建AlertController对象 preferredStly可以设置AlertView的样式或者ActionSheet样式
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"分享" message:@"选择分享方式" preferredStyle:UIAlertControllerStyleActionSheet] ;
    
    //创建取消按钮 UIAlertActionStyleCancel取消样式
    UIAlertAction * sheet1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消") ;
    }] ;
    
    UIAlertAction * sheet2 = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"微信") ;
        __weak typeof(self) weakSelf = self;
        [weakSelf share:UMSocialPlatformType_WechatSession withText:@"你好啊"];
        
    }] ;
    
    UIAlertAction * sheet3 = [UIAlertAction actionWithTitle:@"短信" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"短信") ;
        __weak typeof(self) weakSelf = self;
        [weakSelf share:UMSocialPlatformType_Sms withText:@"sjdjsid"];
    }] ;
    
    //添加按钮
    [alert addAction:sheet1] ;
    [alert addAction:sheet2] ;
    [alert addAction:sheet3] ;
    //显示
    [self presentViewController:alert animated:YES completion:nil] ;
  
    
}

//sheetView的代理方法
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        NSLog(@"点击了%ld",buttonIndex) ;
//        __weak typeof(self) weakSelf = self;
//        [weakSelf share:UMSocialPlatformType_WechatSession withText:@"你好啊"];
//    }else if (buttonIndex == 1){
//        NSLog(@"点击了%ld",buttonIndex) ;
//        __weak typeof(self) weakSelf = self;
//        [weakSelf share:UMSocialPlatformType_Sms withText:@"sjdjsid"];
//    }
//}


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





@end
