//
//  TableViewDelegate.h
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/11/7.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>//要导入头文件

//定义点击cell后的block的回调方法
typedef void (^selectCell) (NSIndexPath * indexPath);

//代理对象*(UITableView的协议需要声明在.h文件中，不然外界在使用的时候会报黄色警告)
@interface TableViewDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>


/**
 创建代理对象 block回调方法

 @param dataList 数据列表 数组
 @param selectBlock 点击后的block回调
 @return 实例对象
 */
+ (instancetype)createTableViewDelegateWithDataList:(NSArray *)dataList selectBlock:(selectCell)selectBlock ;


@end
