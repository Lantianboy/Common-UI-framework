//
//  SheetView.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/7.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "SheetView.h"

@interface SheetView ()

@property (nonatomic, strong) UIAlertController * alert ;

@end
@implementation SheetView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super init] ;
    
    if (self) {
        _alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet] ;
    }
    return self ;
}

- (void)showWithController:(UIViewController *)controller
{
    
    [controller presentViewController:_alert animated:YES completion:nil] ;
 
}

- (void)setActionTitles:(NSArray *)actionTitles
{
    _actionTitles = actionTitles ;
    for (int i = 0; i < actionTitles.count; i ++) {
        if ([self.sheetDelgate respondsToSelector:@selector(sheetView:actionStyleAtIndex:)]) {
            UIAlertActionStyle style = [self.sheetDelgate sheetView:self actionStyleAtIndex:i] ;
            UIAlertAction * action = [UIAlertAction actionWithTitle:actionTitles[i] style:style handler:^(UIAlertAction * _Nonnull action) {
                if ([self.sheetDelgate respondsToSelector:@selector(sheetView:didSelectedAtIndex:)]) {
                    [self.sheetDelgate sheetView:self didSelectedAtIndex:i] ;
                }
                [_alert dismissViewControllerAnimated:YES completion:nil] ;
            }] ;
            [_alert addAction:action] ;
        }else{
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([self.sheetDelgate respondsToSelector:@selector(sheetView:didSelectedAtIndex:)]) {
                    [self.sheetDelgate sheetView:self didSelectedAtIndex:i] ;
                }
                [_alert dismissViewControllerAnimated:YES completion:nil] ;
            }] ;
            [_alert addAction:action] ;
            
        }
    }
}






@end
