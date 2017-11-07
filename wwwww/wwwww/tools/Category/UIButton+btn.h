//
//  UIButton+btn.h
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/31.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (btn)

//自定义方法
- (instancetype)initWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth ;


- (void)Hook_setTitle:(NSString *)str forState:(UIControlState *)sta;

@end
