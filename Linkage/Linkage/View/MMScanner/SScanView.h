//
//  SScanView.h
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/12/15.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MMScanTypeQrCode,
    MMScanTypeBarCode,
    MMScanTypeAll,
} MMScanType;

@interface SScanView : UIView
-(id)initWithFrame:(CGRect)frame style:(NSString *)style;

- (void)stopAnimating;

@property (nonatomic, assign) MMScanType scanType;
@end

