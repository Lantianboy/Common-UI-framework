//
//  UIButton+btn.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/31.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "UIButton+btn.h"
#import <objc/message.h> //runtime头文件
@implementation UIButton (btn)

//分类添加的方法 可直接调用
- (instancetype)initWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    if (self = [super initWithFrame:frame]) {
        // 边框颜色
        self.layer.borderColor = borderColor.CGColor;
        // 边框宽度
        self.layer.borderWidth = borderWidth;
        // title颜色(与边框颜色一致)
        [self setTitleColor:borderColor forState:UIControlStateNormal];
        // 圆角
        self.layer.cornerRadius = 3;
        // 字号
        [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return self;
}

+ (void)load // 加载分类的时候调用,不导入头文件,也会交换
{
    
    //获得原始方法
    //class_getInstanceMethod 对象方法
    //class_getClassMethod    类方法
    Method strMethod = class_getInstanceMethod([self class], @selector(setTitle: forState:)) ;
    
    //获得要交换的方法
    Method exchange = class_getInstanceMethod([self class], @selector(Hook_setTitle: forState: )) ;
    
    //交换方法
    method_exchangeImplementations(strMethod, exchange) ;
}





//需要交换的方法的实现
- (void)Hook_setTitle:(NSString *)str forState:(UIControlState *)sta
{
    NSString * ste= @"222" ;
    str = ste ;
    NSLog(@"222") ;
    //self.titleLabel.text =str ;
    [self Hook_setTitle:str forState:sta] ;
    
}





@end
