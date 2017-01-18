//
//  MySaveViewController.m
//  ZhuZhu
//
//  Created by Carl_Huang on 15/1/24.
//  Copyright (c) 2015年 Vison. All rights reserved.
//

#import "MySaveViewController.h"
#import "MySaveFirstTableViewCell.h"
//#import "SaveManager.h"
#import "MJRefresh.h"
@interface MySaveViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *weekList;
@property (nonatomic,strong) NSMutableArray *monthList;
@property (nonatomic,strong) NSMutableArray *all;
@end

@implementation MySaveViewController
{
     UserModel *model;
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = @"排行榜";
    
    model = [[LoginService shareInstanced]getUserModel];
    
    [self initUI];
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40)];
    self.scrollview.delegate = self;
    self.scrollview.pagingEnabled = YES;
    [self.view addSubview:self.scrollview];
    self.scrollview.contentSize = CGSizeMake(ScreenWidth*3, self.scrollview.frame.size.height);
    [self setUptables];
    
}

-(void)setUptables
{
    //添加下拉刷新
    [self configBlock];
    
    NSArray *tables = @[_firstTableview,_secondTableview,_thirdTableview];
    UINib *nib = [UINib nibWithNibName:@"MySaveFirstTableViewCell" bundle:nil];
    for (int a= 0; a<tables.count; a++) {
        
        UITableView *table = tables[a];
        
        [table registerNib:nib forCellReuseIdentifier:@"MySaveFirstTableViewCell"];
        
        table.frame = CGRectMake(a * ScreenWidth, 0, ScreenWidth, self.scrollview.frame.size.height);
        table.backgroundColor = Backgroundcolor;
        [self.scrollview addSubview:table];
        
        table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [[ExamService shareInstenced]getFirstRankingWithUid:model.uid timeType:[NSString stringWithFormat:@"%d",a+1]];
        }];
        table.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            
            [[ExamService shareInstenced]getMoreRankingWithUid:model.uid timeType:[NSString stringWithFormat:@"%d",a+1]];
        }];
        [table.header beginRefreshing];
    }
    

}


-(void)configBlock
{
    [ExamService shareInstenced].getRankingSuccess = ^(id obj,NSString *type){
      
        if ([type isEqualToString:@"1"]) {
            
            [_firstTableview.header endRefreshing];
            [_firstTableview.footer endRefreshing];
            _weekList  = [obj mutableCopy];
            [_firstTableview reloadData];
        }
        else if ([type isEqualToString:@"2"]){
            
            [_secondTableview.header endRefreshing];
            [_secondTableview.footer endRefreshing];
            _monthList = [obj mutableCopy];
            [_secondTableview reloadData];
            
        }else{
            
            [_thirdTableview.header endRefreshing];
            [_thirdTableview.footer endRefreshing];
            _all = [obj mutableCopy];
            [_thirdTableview reloadData];
        }
    };
    [ExamService shareInstenced].getRankingFailure = ^(id obj,NSString *type){
        
        [self showHudWithString:obj];
        if ([type isEqualToString:@"1"]) {
            
            [_firstTableview.header endRefreshing];
            [_firstTableview.footer endRefreshing];

        }
        else if ([type isEqualToString:@"2"]){
            
            [_secondTableview.header endRefreshing];
            [_secondTableview.footer endRefreshing];

            
        }else{
            
            [_thirdTableview.header endRefreshing];
            [_thirdTableview.footer endRefreshing];

        }
    };
}

-(void)initUI
{
    _segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"周榜",@"月榜",@"总榜"]];
    [_segmentedControl setFrame:CGRectMake(0, 0,ScreenWidth, 40)];
    [_segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
    [_segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleFullWidthStripe];
    [_segmentedControl setSelectionIndicatorHeight:3];
    [_segmentedControl setTextColor:[UIColor darkGrayColor]];
    [_segmentedControl setFont:[UIFont systemFontOfSize:16]];
    [_segmentedControl setSelectionIndicatorColor:BaseColor];
    __weak MySaveViewController * weakSelf = self;
    [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            [weakSelf.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];;
        }else if (index == 1) {
            [weakSelf.scrollview setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
        }else if (index == 2) {
            [weakSelf.scrollview setContentOffset:CGPointMake(ScreenWidth*2, 0) animated:YES];
            
        }else{
            return;
        }
    }];
    
    UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.4, ScreenWidth, 0.6)];
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
        }else if (scrollView.contentOffset.x == ScreenWidth*2) {
            [_segmentedControl setSelectedSegmentIndex:2 animated:YES];
        }else{
            return;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _firstTableview) {
        
        return _weekList.count;
    }
    else if (tableView == _secondTableview){
        
        return _monthList.count;
    }
    return _all.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySaveFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySaveFirstTableViewCell"];
    RankingModel *data;
    if (tableView == _firstTableview) {
        
        data = _weekList[indexPath.row];
    }
    else if (tableView == _secondTableview){
        
        data = _monthList[indexPath.row];
    }else{
        
        data = _all[indexPath.row];
    }
    if (data) {
        
        [cell.newsImg sd_setImageWithURL:[NSURL URLWithString:data.avatar] placeholderImage:Aavatar];
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


@end
