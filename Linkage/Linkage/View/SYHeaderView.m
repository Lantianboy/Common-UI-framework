//
//  SYHeaderView.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/6.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "SYHeaderView.h"

#define COUNT            3
#define TITLEBUTTONWIDTH SCREEN_WIDTH/COUNT

@interface SYHeaderView()
@property(nonatomic, strong) UIButton * leftButton ;
@property(nonatomic, strong) UIButton * rightButton ;
@property(nonatomic, strong) UIButton * rookieButton ;

@property(nonatomic, strong) UIView * bottomLine ;

@end

@implementation SYHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI] ;
    }
    return self ;
}

- (void) setUI
{
    self.backgroundColor = [UIColor whiteColor] ;
    
    self.rookieButton = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [button setTitle:@"新手专区" forState:0] ;
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal] ;
        [button setTitleColor:UIColorFromRGB(0xff5400) forState:UIControlStateSelected] ;
        button.titleLabel.font = [UIFont systemFontOfSize:15] ;
        button.frame = CGRectMake(0, 0, TITLEBUTTONWIDTH, self.height) ;
        button.selected = YES ;
        [button addTarget:self action:@selector(rookieButtonClick:) forControlEvents:UIControlEventTouchUpInside] ;
        button ;
        
    }) ;
    
    self.leftButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"优选项目" forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xff5400) forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.frame = CGRectMake(self.width*(1.00/COUNT), 0, TITLEBUTTONWIDTH, self.height);
        [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    self.rightButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"转让专区" forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xff5400) forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.frame = CGRectMake(self.width*(2.00/COUNT), 0, TITLEBUTTONWIDTH, self.height);
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    self.bottomLine = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-3, self.width*(1.00/COUNT), 3)];
        view.backgroundColor = UIColorFromRGB(0xff5400);
        view;
    });
    
    [self addSubview:self.leftButton] ;
    [self addSubview:self.rightButton] ;
    [self addSubview:self.bottomLine] ;
    [self addSubview:self.rookieButton] ;
}

- (void)setSelectdIndex:(NSInteger)selectdIndex
{
    _selectdIndex = selectdIndex ;
    
    switch (_selectdIndex) {
        case 0:
        {
            [self rookieButtonClick:self.rookieButton] ;
            break ;
        }
        case 1:
        {
            [self leftButtonClick:self.leftButton] ;
            break ;
        }
        case 2:
        {
            [self rightButtonClick:self.rightButton] ;
            break ;
        }
        default:
            break;
    }
}

- (void)rookieButtonClick:(UIButton *)button {
    if (button.isSelected) {
        return ;
    }
    button.selected = YES ;
    self.rightButton.selected = NO ;
    self.leftButton.selected = NO ;
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtindex:)]) {
        [self.delegate didClickButtonAtindex:0] ;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLine.x = 0 ;
    }] ;
}

- (void)rightButtonClick:(UIButton *)button {
    if (button.isSelected) {
        return;
    }
    button.selected = YES;
    self.leftButton.selected = NO;
    self.rookieButton.selected = NO;
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtindex:)]) {
        [self.delegate didClickButtonAtindex:2];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLine.x = SCREEN_WIDTH*(2.00/COUNT);
    }];
}

- (void)leftButtonClick:(UIButton *)button {
    if (button.isSelected) {
        return;
    }
    button.selected= YES;
    self.rightButton.selected = NO;
    self.rookieButton.selected = NO;
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtindex:)]) {
        [self.delegate didClickButtonAtindex:1];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLine.x = SCREEN_WIDTH*(1.00/COUNT);
    }];
}
@end
