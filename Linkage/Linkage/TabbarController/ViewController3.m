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
@interface ViewController3 ()<SheetViewDelgate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更换图片" style:UIBarButtonItemStyleDone target:self action:@selector(sheet1)] ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击分享" style:UIBarButtonItemStylePlain target:self action:@selector(sheet2)] ;

}


- (void)sheet1
{
    [self.sheet showWithController:self] ;
}


- (SheetView *)sheet
{
    if (!_sheet) {
        _sheet = [[SheetView alloc] initWithTitle:@"更换图片" message:@"请选择方式"] ;
        
        _sheet.sheetDelgate = self ;
        _sheet.actionTitles = @[@"拍照",@"从相册选取",@"取消"] ;
    }
    return _sheet ;
}
#pragma mark - 自定义sheetView类的代理方法。样式属性
- (UIAlertActionStyle)sheetView:(SheetView *)sheetView actionStyleAtIndex:(NSInteger)index
{
    if (index == 0) {
        return UIAlertActionStyleDestructive ;
    }else if (index == sheetView.actionTitles.count - 1){
        return UIAlertActionStyleCancel ;
    }
    return UIAlertActionStyleDefault ;
}



#pragma mark - 自定义sheetView类的代理方法。点击属性
- (void)sheetView:(SheetView *)sheetView didSelectedAtIndex:(NSInteger)index
{
    if (index == 0) {
        //判断相机是否可用 调用相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
            picker.delegate = self ;//设置代理
            picker.allowsEditing = YES ;//是否允许对获得的图片进行编辑
            //显示相机的所有控件 默认为yes
            //picker.showsCameraControls = YES ;
            //相机 默认是相册
            picker.sourceType = UIImagePickerControllerSourceTypeCamera ;
            [self presentViewController:picker animated:YES completion:^{
                
            }] ;
        }else{
            [SVProgressHUD showErrorWithStatus:@"相机不可用"] ;
        }
        NSLog(@"拍照") ;
        
    }
    if (index == 1) {
        NSLog(@"从相册选取") ;
        UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
        picker.delegate = self ;
        picker.allowsEditing = YES ;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
        [self presentViewController:picker animated:YES completion:^{
            
        }] ;
  
    }
    if (index == 2) {
        NSLog(@"取消") ;
    }
}


#pragma mark - 分享方式选择框
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
#pragma mark - sheetView的代理方法
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


#pragma mark - 友盟分享
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

#pragma mark - 点击cancel调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"点击了取消") ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}


@end
