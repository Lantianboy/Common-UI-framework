//
//  PBShopCell.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/11/13.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "PBShopCell.h"
#import "PBShop.h"
#import <UIImageView+WebCache.h>

@interface PBShopCell ()


@end
@implementation PBShopCell

- (void)setShop:(PBShop *)shop
{
    _shop = shop ;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img]
                      placeholderImage:[UIImage imageNamed:@"杨5.jpge"]] ;
    self.priceLable.text = shop.price ;
    NSLog(@"111") ;
}


@end


