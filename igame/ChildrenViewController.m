//
//  ChildrenViewController.m
//  igame
//
//  Created by Interest on 2016/12/13.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "ChildrenViewController.h"
#import "InputViewController.h"
#import "TimeViewController.h"
#import "OpenViewController.h"
@interface ChildrenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ChildrenViewController
{
    NSMutableArray *list;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"儿童锁";
    list = [@[@"设置密码",@"设置时间",@"密码锁"]mutableCopy];
}
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text =list[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        InputViewController *vc = [[InputViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.row == 1){
        
        TimeViewController *vc = [[TimeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        OpenViewController *vc = [[OpenViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
