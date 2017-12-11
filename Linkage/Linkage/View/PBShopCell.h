//
//  PBShopCell.h
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/13.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PBShop ;

@interface PBShopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@property (nonatomic, strong) PBShop * shop ;

@end
