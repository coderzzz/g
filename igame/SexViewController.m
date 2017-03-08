//
//  SexViewController.m
//  igame
//
//  Created by Interest on 2016/12/19.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "SexViewController.h"

@interface SexViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation SexViewController

{
    NSMutableArray *list;
    NSInteger index;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"性别";
    index = [self.mysex intValue] -1;
    list =[@[@"男",@"女"]mutableCopy];
    self.tableview.backgroundColor = Backgroundcolor;
}
- (void)back{
    
    if ( [self.delegate respondsToSelector:@selector(didChangeSex:)] && self.delegate) {
        [self.delegate didChangeSex:index+1];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 10)];
    imgv.image = [UIImage imageNamed:@"扫描-勾选"];
    if (indexPath.row == index) {
        cell.accessoryView = imgv;
    }
    else{
        cell.accessoryView = nil;
    }
    cell.textLabel.text = list[indexPath.row];
    return cell;
    
    
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    index = indexPath.row;
    [self.tableview reloadData];
}


@end
