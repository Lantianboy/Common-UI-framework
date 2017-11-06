//
//  SYHeaderView.h
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/6.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYHeaderViewDelgate <NSObject>

- (void)didClickButtonAtindex:(NSInteger) index ;

@end


@interface SYHeaderView : UIView

@property(nonatomic, weak) id<SYHeaderViewDelgate>  delegate ;
@property(nonatomic, assign) NSInteger selectdIndex ;


@end
