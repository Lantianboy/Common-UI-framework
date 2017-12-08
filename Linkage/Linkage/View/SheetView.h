//
//  SheetView.h
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/7.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SheetViewDelgate;

@interface SheetView : NSObject

@property (nonatomic, weak) id<SheetViewDelgate>sheetDelgate ;

@property (nonatomic, strong) NSArray * actionTitles ;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message ;

- (void)showWithController:(UIViewController *)controller ;

@end

@protocol SheetViewDelgate <NSObject>

- (UIAlertActionStyle)sheetView:(SheetView *)sheetView actionStyleAtIndex:(NSInteger)index ;

- (void)sheetView:(SheetView *)sheetView didSelectedAtIndex:(NSInteger)index ;

@end 
