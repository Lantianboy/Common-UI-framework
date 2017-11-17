//
//  LinkageMenuView.h
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/10/30.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkageMenuView : UIView

@property (nonatomic, strong) UIColor * selectViewColor ;//滑块颜色

@property (nonatomic, strong) UIColor * textColor ;      //标题颜色

@property (nonatomic, strong) UIColor * selectTextColor ;//标题选中的颜色

@property (nonatomic, assign) CGFloat textSize ;         //标题字体大小



/**
 Init Method

 @param frame    LinkageMenu frame
 @param menu     titles array
 @param views     right views array
 
 */
- (instancetype)initWithFrame:(CGRect)frame WithMenu:(NSArray * )menu andViews:(NSArray * )views ;



@end
