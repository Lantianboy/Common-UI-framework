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
#import "ZCWaterWaveView.h"
#import "SScanViewController.h"
#import "DrawQrViewController.h"
#import "DrawBarViewController.h"
@interface ViewController3 ()<SheetViewDelgate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIImageView * _topView ;
    UIImage * imageV ;
}

@property (nonatomic, strong) SheetView * sheet ;
@property (nonatomic, strong) ZCWaterWaveView * zcwater ;
@property (nonatomic, strong) UITableView * tableView ;
@property (nonatomic, strong) NSMutableArray * array ;

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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor] ;

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:91/255.0 green:142/255.0 blue:234/255.0 alpha:0.5];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更换图片" style:UIBarButtonItemStyleDone target:self action:@selector(sheet1)] ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击分享" style:UIBarButtonItemStylePlain target:self action:@selector(sheet2)] ;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor] ;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor] ;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil] ;
    
    self.zcwater = [[ZCWaterWaveView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)] ;
    [self.view addSubview:self.tableView] ;
    [self.view addSubview:self.zcwater] ;
    
    
    
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
        [weakSelf share:UMSocialPlatformType_WechatSession withText:@"吃饭了吗"];
        
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

#pragma mark - 图片选择器代理
//(上传图片的网络请求也是在这里)
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}] ;
    //通过key值获取图片
    imageV = [info objectForKey:UIImagePickerControllerOriginalImage] ;
    //ZCWaterWaveView * zcwater = [[ZCWaterWaveView alloc] init] ;
    self.zcwater.imgV.image = imageV ;//给imageView赋值已选择的图片
    
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, SCREEN_HEIGHT - 260)] ;
        _tableView.dataSource = self ;
        _tableView.delegate = self ;
        _tableView.backgroundColor = [UIColor whiteColor] ;
        _tableView.tableFooterView = [UIView new] ;
        
    }
    return _tableView ;
}

- (NSMutableArray *)array
{
    
    if (!_array) {
        _array = [NSMutableArray arrayWithObjects:@"扫一扫",@"绘制二维码",@"绘制条形码", nil] ;
    }
    return _array ;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"cell" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] ;
    }
    
    cell.textLabel.text = self.array[indexPath.row] ;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    if (indexPath.row == 0) {
        SScanViewController * scanVC = [[SScanViewController alloc] initWithQrType:MMScanTypeAll onFinish:^(NSString *result, NSError *error) {
            if (error) {
                NSLog(@"error:%@",error) ;
            }else{
                NSLog(@"扫描结果:%@",result) ;
                [self showInfo:result] ;
            }
        }] ;
        scanVC.hidesBottomBarWhenPushed = YES ;
        [self.navigationController pushViewController:scanVC animated:YES] ;
        
    }else if (indexPath.row == 1) {
        DrawQrViewController * drawQrVC = [[DrawQrViewController alloc] init] ;
        [self.navigationController pushViewController:drawQrVC animated:YES] ;
    }else{
        DrawBarViewController * barVC = [[DrawBarViewController alloc] init] ;
        [self.navigationController pushViewController:barVC animated:YES] ;
    }
    
}


- (void)showInfo:(NSString *)str {
    [self showInfo:str andTitle:@"提示"] ;
}

- (void)showInfo:(NSString *)str andTitle:(NSString *)title
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert] ;
    
    UIAlertAction * action1 = ({
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:NULL] ;
        action ;
    }) ;
    [alert addAction:action1] ;
    [self presentViewController:alert animated:YES completion:nil] ;
}

@end
