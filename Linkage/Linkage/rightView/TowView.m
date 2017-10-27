//
//  TowView.m
//  Linkage
//
//  Created by 最爱是深蓝 on 2017/10/27.
//  Copyright © 2017年 ProductTest. All rights reserved.
//

#import "TowView.h"

@interface TowView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation TowView

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self ;
        self.dataSource = self ;
        
    }
    return self ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] ;
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%ld",indexPath.row] ;
    cell.detailTextLabel.text = @"点我" ;
    return cell ;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
