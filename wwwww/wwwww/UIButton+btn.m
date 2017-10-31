//
//  UIButton+btn.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/31.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "UIButton+btn.h"

@implementation UIButton (btn)

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






@end
