//
//  MyGameViewController.m
//  igame
//
//  Created by Interest on 2016/12/19.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "MyGameViewController.h"
#import "HMSegmentedControl.h"
#import "ListCell.h"
@interface MyGameViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UITableView *tab1;
@property (strong, nonatomic) IBOutlet UITableView *tab2;
@property (weak, nonatomic) IBOutlet UILabel *centerline;

@end

@implementation MyGameViewController

{
    HMSegmentedControl *_segmentedControl;
    UserModel *model;
    NSMutableArray *mgs;
    NSMutableArray *mbs;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"我的约战";
    [self initUI];
    model = [[LoginService shareInstanced]getUserModel];
    self.centerline.frame =CGRectMake(ScreenWidth/2, 0, 1,44);
    self.scrollview.frame =CGRectMake(0, 44, ScreenWidth, ScreenHeight-64-44);
    self.scrollview.contentSize = CGSizeMake(ScreenWidth*2, self.scrollview.frame.size.height);
    
    self.tab1.frame = CGRectMake(0, 0, ScreenWidth, self.scrollview.frame.size.height);
    [self.scrollview addSubview:self.tab1];
    
    self.tab2.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollview.frame.size.height);
    [self.scrollview addSubview:self.tab2];
    
    
    self.tab1.backgroundColor = Backgroundcolor;
    self.tab2.backgroundColor = Backgroundcolor;
    
    UINib *nib =[UINib nibWithNibName:@"ListCell" bundle:nil];
    [self.tab1 registerNib:nib forCellReuseIdentifier:@"list"];
    [self.tab2 registerNib:nib forCellReuseIdentifier:@"list"];
    [self.view bringSubviewToFront:self.centerline];
    [self setUptables];
    
}

-(void)setUptables
{
    //添加下拉刷新
    [self configBlock];
    self.tab1.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getFirstmgWithUid:model.uid];
    }];
    self.tab1.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getMoremgWithUid:model.uid];
    }];
    [self.tab1.header beginRefreshing];
    
    self.tab2.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getFirstmbWithUid:model.uid];
    }];
    self.tab2.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getMorembWithUid:model.uid];
    }];
    [self.tab2.header beginRefreshing];
    
}


-(void)configBlock
{
    [ExamService shareInstenced].getmgSuccess = ^(id obj){
        
  
        [_tab1.header endRefreshing];
        [_tab1.footer endRefreshing];
        mgs = [obj mutableCopy];
        [_tab1 reloadData];
        
    };
    [ExamService shareInstenced].getmgFailure= ^(id obj){
        
        [self showHudWithString:obj];
        [_tab1.header endRefreshing];
        [_tab1.footer endRefreshing];
    };
    
    
    [ExamService shareInstenced].getmbSuccess = ^(id obj){
        
        
        [_tab2.header endRefreshing];
        [_tab2.footer endRefreshing];
        mbs = [obj mutableCopy];
        [_tab2 reloadData];
        
    };
    [ExamService shareInstenced].getmbFailure= ^(id obj){
        
        [self showHudWithString:obj];
        [_tab2.header endRefreshing];
        [_tab2.footer endRefreshing];
    };
    
}


-(void)initUI
{
    _segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"我的约战",@"我报名的"]];
    [_segmentedControl setFrame:CGRectMake(0, 0,ScreenWidth, 44)];
    [_segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
    [_segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleFullWidthStripe];
    [_segmentedControl setSelectionIndicatorHeight:3];
    [_segmentedControl setTextColor:[UIColor darkGrayColor]];
    [_segmentedControl setFont:[UIFont systemFontOfSize:16]];
    [_segmentedControl setSelectionIndicatorColor:BaseColor];
    __weak MyGameViewController * weakSelf = self;
    [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            [weakSelf.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];;
        }else if (index == 1) {
            [weakSelf.scrollview setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
        }else{
            return;
        }
    }];
    
    UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.4, ScreenWidth, 0.6)];
    line.backgroundColor = [UIColor colorWithRed:.831 green:.831 blue:.843 alpha:1.0f];
    [_segmentedControl addSubview:line];
    
    [self.view addSubview:_segmentedControl];
}

#pragma scrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollview){
        if (scrollView.contentOffset.x == 0) {
            [_segmentedControl setSelectedSegmentIndex:0 animated:YES];
        }else if (scrollView.contentOffset.x == ScreenWidth) {
            [_segmentedControl setSelectedSegmentIndex:1 animated:YES];
        }else{
            return;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tab1) {
        return mgs.count;
    }
    return mbs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tab1) {
        
        ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
        MybattModel *data = mgs[indexPath.row];
        [cell.imagv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,data.battle_thumb]] placeholderImage:Aavatar];
        cell.titlelab.text = data.battle_title;
        cell.contentlab.text = data.nickname;
        return cell;

    }
    else{
        
        ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
        MybattModel *data = mbs[indexPath.row];
        [cell.imagv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,data.battle_thumb]] placeholderImage:Aavatar];
        cell.titlelab.text = data.battle_title;
        cell.contentlab.text = data.nickname;
        return cell;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


@end
