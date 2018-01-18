//
//  ViewController2.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/10/16.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "ViewController2.h"
#import <CoreLocation/CoreLocation.h>



@interface ViewController2 ()<CLLocationManagerDelegate>
{
    NSString * str ;
}

@property (nonatomic, strong)UILabel * lable ;

@property (nonatomic, strong) CLLocationManager * locationManger ;

//地理位置解码编码器
@property (nonatomic, strong) CLGeocoder * geo ;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"点击定位" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, 400, 100, 40)] ;
    btn.backgroundColor = [UIColor orangeColor] ;
    [btn setTitle:@"开始定位" forState:0] ;
    [btn setTitleColor:[UIColor purpleColor] forState:0] ;
    [btn addTarget:self action:@selector(Positioning) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:btn] ;
    
    [self.view addSubview:self.lable] ;
    
    
    //初始化定位服务
    self.locationManger = [[CLLocationManager alloc] init] ;
    
    //设置定位的精确度和更新频率
    self.locationManger.desiredAccuracy = kCLLocationAccuracyBest ;
    self.locationManger.distanceFilter = 10.f ;
    self.locationManger.delegate = self ;
    
    //授权状态是没有做过选择
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManger requestAlwaysAuthorization] ;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //既然已经定位到了用户当前的经纬度了 那么可以让定位管理器 停止定位了
    [self.locationManger stopUpdatingLocation] ;
    //然后取出第一个位置 根据其经纬度 通过CLGeocoder反向解析 获得该位置所在的城市名称 转成城市对象用工具保存
    CLLocation * loc = [locations firstObject] ;
    //CLGeocoder反向通过经纬度 获得城市名
    //获取当前所在的城市名
    CLGeocoder * geocoder = [[CLGeocoder alloc] init] ;
    //根据经纬度反向地理编译出地理信息
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray * array, NSError * error){
        if (array.count > 0) {
            CLPlacemark * placemark = [array objectAtIndex:0] ;
            //将获得所有信息显示到lable上
            str = [NSString stringWithFormat:@"%@-%@--%@",placemark.country,placemark.locality,placemark.name] ;
            NSLog(@"--name--%@",placemark.name) ;
            NSLog(@"--locality--%@",placemark.locality) ;
            
            NSLog(@"--administrativeArea--%@",placemark.administrativeArea) ;
            
            NSLog(@"--country--%@",placemark.country) ;
            
            //获取城市
            NSString * city = placemark.locality ;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得 只能通过获取省份的方法来获得（如果city为空 则可知为直辖市）
                city = placemark.administrativeArea ;
            }
            NSLog(@"city = %@",city) ;
            self.lable.text = str ;
        }else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned") ;
        }else if (error != nil)
        {
            NSLog(@"An error occurred = %@",error) ;
        }
        
    }] ;
    //系统会一直更新数据 直到选择停止更新 因为我们只需要获得一次经纬度即可 所以获取之后就停止更新
    [manager stopUpdatingLocation] ;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"====%@",error) ;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"---%d",status) ;
}

- (void)Positioning
{
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManger startUpdatingLocation] ;
    }
    
}

- (UILabel *)lable
{
    if (!_lable) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, 300, 200, 40)] ;
        _lable.text = str ;
        _lable.font = [UIFont systemFontOfSize:14] ;
        _lable.backgroundColor = [UIColor grayColor] ;
    }
    return _lable ;
}
@end
