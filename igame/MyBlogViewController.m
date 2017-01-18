//
//  MyBlogViewController.m
//  igame
//
//  Created by Interest on 2016/12/19.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyBlogViewController.h"
#import "BlogDetailViewController.h"
#import "ListCell.h"
@interface MyBlogViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headview;

@end

@implementation MyBlogViewController

{
    NSMutableArray *list;
    UserModel *model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的帖子";
     model = [[LoginService shareInstanced]getUserModel];
    UINib *nib =[UINib nibWithNibName:@"ListCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"list"];
    [self.tableview setTableHeaderView:self.headview];
    self.tableview.backgroundColor = Backgroundcolor;
    [self setUptables];
}
-(void)setUptables
{
    //添加下拉刷新
    [self configBlock];
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getFirstmblogWithUid:model.uid];
    }];
    self.tableview.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getMoremblogWithUid:model.uid];
    }];
    [self.tableview.header beginRefreshing];
    
}


-(void)configBlock
{
    [ExamService shareInstenced].getmblogSuccess = ^(id obj){
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        list  = [obj mutableCopy];
        [self.tableview reloadData];
        
    };
    [ExamService shareInstenced].getmblogFailure = ^(id obj){
        
        [self showHudWithString:obj];
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
        
    };
}



#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
    NewsModel *data = list[indexPath.row];
    [cell.imagv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,data.news_thumb]] placeholderImage:Aavatar];
    [cell.readbtn setTitle:[NSString stringWithFormat:@"%@",data.read_times] forState:UIControlStateNormal];
    cell.titlelab.text = data.news_title;
    cell.contentlab.text = data.add_time;
    return cell;
    
    
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *data = list[indexPath.row];
    BlogDetailViewController *vc = [[BlogDetailViewController alloc]initWithUid:model.uid NewsModel:data];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
