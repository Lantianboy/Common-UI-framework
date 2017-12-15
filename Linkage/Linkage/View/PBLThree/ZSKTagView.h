//
//  ZSKTagView.h
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/12.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SKTagView.h>

@interface ZSKTagView : UIView

@property (nonatomic, strong) SKTagView * tagView ;
@property (nonatomic, strong) UILabel * label ;
@property (nonatomic,strong) NSMutableArray *dataSource;

- (instancetype) initWithFrame:(CGRect)frame ;

@end
