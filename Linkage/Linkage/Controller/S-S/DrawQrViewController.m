//
//  DrawQrViewController.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/15.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "DrawQrViewController.h"
#import "SScanViewController.h"
@interface DrawQrViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UITextField *linkTfd;

@end

@implementation DrawQrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qrImageView.userInteractionEnabled = YES ;
    [self.qrImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(save:)]] ;
    
   
}
//生成二维码
- (IBAction)createQrBut:(id)sender {
    
    if (self.linkTfd.text == nil || self.linkTfd.text.length == 0) {
        [self showInfo:@"请先输入"] ;
    }else{
    
    UIImage * image = [SScanViewController createQRImageWithString:_linkTfd.text QRSize:CGSizeMake(250, 250) QRColor:[UIColor blackColor] bkColor:[UIColor colorWithRed:0.318 green:0.690 blue:0.839 alpha:1]] ;
    //如果不需要设置背景色以及前景色，则使用下面代码  默认白色底黑色码
    //UIImage *image = [ScanViewController createQRImageWithString:_linkTfd.text QRSize:CGSizeMake(250, 250)];
    
    [_qrImageView setImage:image] ;
    }
}


//点击图片保存
- (void)save:(UITapGestureRecognizer *)tap
{
    if (_qrImageView.image) {
        UIImageWriteToSavedPhotosAlbum(_qrImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self) ;
    }else{
        [self showInfo:@"请先生成二维码"] ;
    }
}


//保存二维码
- (void)image:(UIImage *)image didFinishSavingWithError:(NSString *)error contextInfo:(void *)contextInfo
{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (error) {
        [self showInfo:[NSString stringWithFormat:@"error:%@",error]] ;
    }else{
        [self showInfo:@"保存成功"] ;
    }
}

- (void)showInfo:(NSString *)str{
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.linkTfd resignFirstResponder] ;
}



@end
