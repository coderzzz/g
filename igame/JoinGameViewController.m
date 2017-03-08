//
//  JoinGameViewController.m
//  igame
//
//  Created by Interest on 2016/12/9.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "JoinGameViewController.h"
#import "JoinCell.h"
#import "SendGameViewController.h"
#import "SignUpViewController.h"
@interface JoinGameViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *gamebtn;
@property (weak, nonatomic) IBOutlet UIButton *joinbtn;
@end

@implementation JoinGameViewController
{
    NSMutableArray *list;
    UserModel *model;
    NSString *battle_id;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"约战";
     model = [[LoginService shareInstanced]getUserModel];
    [self.gamebtn borderColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1]];
    [self.joinbtn borderColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1]];
    self.tableview.backgroundColor= Backgroundcolor;
    UINib *nib =[UINib nibWithNibName:@"JoinCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"join"];
    [self setUptables];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview.header beginRefreshing];
}

-(void)setUptables
{
    //添加下拉刷新
    [self configBlock];
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getFirstbattleWithUid:model.uid];
    }];
    self.tableview.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getMorebattleWithUid:model.uid];
    }];

}


-(void)configBlock
{
    [ExamService shareInstenced].getbattleSuccess = ^(id obj){

            [self.tableview.header endRefreshing];
            [self.tableview.footer endRefreshing];
            list  = [obj mutableCopy];
            [self.tableview reloadData];
    
    };
    [ExamService shareInstenced].getbattleFailure = ^(id obj){
        
        [self showHudWithString:obj];
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
            
    
    };
}

- (IBAction)btnaction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 0) {
        
        SendGameViewController *vc = [[SendGameViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        if (battle_id.length>0) {
            
            SignUpViewController *vc = [[SignUpViewController alloc]init];
            vc.battle_id = battle_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"join"];
    BattleModel *data= list[indexPath.row];
    if ([data.id isEqualToString:battle_id]) {
        
        cell.checkbtn.selected = YES;
    }else{
        cell.checkbtn.selected = NO;
    }
    [cell.imagv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,data.battle_thumb]] placeholderImage:Aavatar];
    cell.titlelab.text = data.battle_title;
    cell.counslab.text = [NSString stringWithFormat:@"已报名：%@",data.number_applicants];
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BattleModel *data= list[indexPath.row];
    if ([battle_id isEqualToString:data.id]) {
        
        battle_id = @"999";
    }else{
     
        battle_id = data.id;
    }
    [self.tableview reloadData];
    
}

@end
