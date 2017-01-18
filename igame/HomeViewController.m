//
//  HomeViewController.m
//  igame
//
//  Created by Interest on 2016/12/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "JoinGameViewController.h"
#import "MySaveViewController.h"
#import "BlogListViewController.h"
#import "AdvertisementView.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,AdvertisementViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (weak, nonatomic) IBOutlet UIButton *rangbtn;
@property (weak, nonatomic) IBOutlet UIButton *gamebtn;
@property (weak, nonatomic) IBOutlet UIButton *blogbtn;

@end

@implementation HomeViewController
{
    NSMutableArray *list;
    NSMutableArray *ads;
    UserModel *model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ads = [NSMutableArray array];
    model = [[LoginService shareInstanced]getUserModel];
    [self.rangbtn cornerRadius:4];
    [self.gamebtn cornerRadius:4];
    [self.blogbtn cornerRadius:4];
    UINib *nib =[UINib nibWithNibName:@"HomeCell" bundle:nil];
    [self.tableview setTableHeaderView:self.headview];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"home"];
    [self setUptables];
    
    
    
    [ExamService shareInstenced].getGradeTypeFailure = ^(id obj){
        
      
        [self showHudWithString:obj];
        
    };
    [ExamService shareInstenced].getGradeTypeSuccess = ^(id obj){
        
        ads = (NSMutableArray *)obj;
        NSMutableArray *urls= [NSMutableArray array];
        for (NSDictionary *dic in ads) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",Img_URL_Prefix,dic[@"ad_image"]];
            [urls addObject:url];
        }
        AdvertisementView *ad =[[AdvertisementView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 245)];
        ad.delegate = self;
        ad.urlArray = urls;
        [self.headview addSubview:ad];
    };
   
    [[ExamService shareInstenced]getGradeTypeWithUid:model.uid];
}

-(void)setUptables
{
    //添加下拉刷新
    [self configBlock];
  
    _tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getFirstRankingWithUid:model.uid timeType:@"3"];
    }];
    _tableview.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getMoreRankingWithUid:model.uid timeType:@"3"];
    }];
    [_tableview.header beginRefreshing];
    
}


-(void)configBlock
{
    [ExamService shareInstenced].getRankingSuccess = ^(id obj,NSString *type){

        [_tableview.header endRefreshing];
        [_tableview.footer endRefreshing];
        list = [obj mutableCopy];
        [_tableview reloadData];

    };
    [ExamService shareInstenced].getRankingFailure = ^(id obj,NSString *type){
        
        [self showHudWithString:obj];
        [_tableview.header endRefreshing];
        [_tableview.footer endRefreshing];
            

    };
}

- (IBAction)btnaction:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        MySaveViewController *vc = [[MySaveViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (sender.tag == 1) {
        
        JoinGameViewController *vc = [[JoinGameViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (sender.tag == 2) {
        
        BlogListViewController *vc = [[BlogListViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark AdvertisementViewDelegate
- (void)didTapImageViewAtIndex:(NSInteger )index{
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"home"];
    RankingModel *data = list[indexPath.row];
    cell.namelab.text = data.nickname;
    cell.contenlab.text = [NSString stringWithFormat:@"胜利场数：%@",data.number_wins];
    [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,data.avatar]] placeholderImage:Aavatar];
    cell.rangelab.text = [NSString stringWithFormat:@"第%ld名",(long)indexPath.row +1];
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
