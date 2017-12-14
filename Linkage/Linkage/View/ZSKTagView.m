//
//  ZSKTagView.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/12.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ZSKTagView.h"

@interface ZSKTagView ()

@end 

@implementation ZSKTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configTagView] ;
    }
    return self ;
}

//配置UI
- (void)configTagView
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 100, 30)] ;
    self.label.textColor = [UIColor blackColor] ;
    self.label.font = [UIFont systemFontOfSize:13] ;
    self.label.text = @"历史搜索" ;
    [self addSubview:self.label] ;
    
    [self.tagView removeAllTags] ;
    self.tagView = [[SKTagView alloc] init] ;
    //整个tagView对应其supperView的上下左右距离
    self.tagView.padding = UIEdgeInsetsMake(10, 10, 10, 10) ;
    //上下行之间的距离
    self.tagView.lineSpacing = 10 ;
    //item之间的距离
    self.tagView.interitemSpacing = 20 ;
    //最大宽度
    self.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH - 40 ;
    //开始加载
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //初始化标签
        SKTag * tag = [[SKTag alloc] initWithText:self.dataSource[idx]] ;
        //标签相对于自己容器的上下左右的距离
        tag.padding = UIEdgeInsetsMake(3, 10, 3, 10) ;
        //弧度
        tag.cornerRadius = 3.0f ;
        //字体
        tag.font = [UIFont systemFontOfSize:12] ;
        //边框宽度
        tag.borderWidth = 0 ;
        //背景
        tag.bgColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1] ;
        //边框颜色
        tag.borderColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1] ;
        //字体颜色
        tag.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1] ;
        //是否可点击
        tag.enable = YES ;
        //加入到tagView
        [self.tagView addTag:tag] ;
    }] ;
    
    __weak typeof (self) weakself = self ;
    //点击事件回调
    self.tagView.didTapTagAtIndex=^(NSUInteger index){
        NSLog(@"点击了第%ld个:%@",index,weakself.dataSource[index]) ;
        NSString * str = weakself.dataSource[index] ;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:str] ;
        
        
    } ;
    
    //获取刚才加入所有tag之后的内在高度
    CGFloat tagHeight = self.tagView.intrinsicContentSize.height ;
    NSLog(@"高度%lf",tagHeight) ;
    self.tagView.frame = CGRectMake(0,30, SCREEN_WIDTH - 20, tagHeight) ;
    [self.tagView layoutSubviews] ;
    [self addSubview:self.tagView] ;
    
    
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
//        _dataSource = [NSMutableArray arrayWithCapacity:15] ;
        _dataSource =[NSMutableArray arrayWithObjects:@"宫",@"王昭君",@"红楼梦",@"三生三世十里桃花",@"微时代之恋",@"仙剑奇侠传三",@"亲爱的翻译官",@"北京爱情故事",@"逆时营救",@"古剑奇谭",@"神雕侠侣",@"怦然星动",@"何以笙箫默",@"小时代",@"我是证人",@"扶摇皇后",@"谈判官", nil] ;
    }
    return _dataSource ;
}

@end
