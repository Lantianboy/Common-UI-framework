//
//  ViewXib.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/23.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ViewXib.h"

@implementation ViewXib


+ (instancetype)initView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ViewXib class]) owner:self options:nil] lastObject] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
