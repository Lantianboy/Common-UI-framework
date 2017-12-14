//
//  OneCollectionViewCell.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/10/26.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "OneCollectionViewCell.h"

@implementation OneCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame ;
        [self addSubview:self.backView] ;
        [self addSubview:self.titleLable] ;
    }
    return self ;
}
- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.width - 20)] ;
        _backView.backgroundColor = [UIColor grayColor] ;
        
    }
    return _backView ;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, _backView.frame.origin.y + _backView.frame.size.height + 10, self.frame.size.width, 20)] ;
        _titleLable.textAlignment = NSTextAlignmentCenter ;
        _titleLable.font = [UIFont systemFontOfSize:13] ;
    }
    return _titleLable ;
}


@end
