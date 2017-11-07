//
//  TableViewDelegate.m
//  wwwww
//
//  Created by 最爱是深蓝 on 2017/11/7.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "TableViewDelegate.h"
#import "UIButton+btn.h"
#import "ViewController.h"
@interface TableViewDelegate()
@property (nonatomic, strong) NSMutableArray   *dataList;
@property (nonatomic, copy)   selectCell selectBlock;
@end

@implementation TableViewDelegate

+ (instancetype)createTableViewDelegateWithDataList:(NSMutableArray *)dataList selectBlock:(selectCell)selectBlock
{
    return [[[self class] alloc] initTableViewDelegateWithDataList:dataList
selectBlock:selectBlock];
}

- (instancetype)initTableViewDelegateWithDataList:(NSMutableArray *)dataList selectBlock:(selectCell)selectBlock {
    self = [super init];
    if (self) {
        self.dataList = dataList;
        self.selectBlock = selectBlock;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //cell.textLabel.text = indexPath.section % 2 ? @"你好！" : @"不好！" ;
    //cell.backgroundColor = indexPath.section % 2 ? [UIColor lightGrayColor] : [UIColor whiteColor] ;
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 50, 30) borderColor:[UIColor redColor] borderWidth:2] ;
    //btn.backgroundColor = [UIColor orangeColor] ;
    //[btn setTitleColor:[UIColor redColor] forState:0] ;
    
    [btn setTitle:@"111" forState:UIControlStateNormal] ;
    
    [cell addSubview:btn] ;
    cell.textLabel.text = self.dataList[indexPath.section];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section >= 4 ? 8 : 0 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO] ;
    
    //将点击事件通过block的方式传递出去
    self.selectBlock(indexPath) ;
   
}


@end
