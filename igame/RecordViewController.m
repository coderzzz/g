//
//  RecordViewController.m
//  igame
//
//  Created by Interest on 2016/12/15.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "RecordViewController.h"
#import "HMSegmentedControl.h"
#import "RecordCell.h"
#import "UseTimeCell.h"
@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UITableView *tab1;
@property (strong, nonatomic) IBOutlet UITableView *tab2;
@property (weak, nonatomic) IBOutlet UILabel *centerline;

@end

@implementation RecordViewController
{
    HMSegmentedControl *_segmentedControl;
    NSMutableArray *list;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"排行榜";
//    [self initUI];
//    self.centerline.frame =CGRectMake(ScreenWidth/2, 0, 1,44);
    self.centerline.frame = CGRectZero;
    self.scrollview.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    self.scrollview.contentSize = CGSizeMake(ScreenWidth, self.scrollview.frame.size.height);
    
    self.tab2.frame = CGRectMake(0, 0, ScreenWidth, self.scrollview.frame.size.height);
    [self.scrollview addSubview:self.tab2];
    
//    self.tab2.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollview.frame.size.height);
//    [self.scrollview addSubview:self.tab2];
    
 
    self.tab1.backgroundColor = Backgroundcolor;
    self.tab2.backgroundColor = Backgroundcolor;
    
    UINib *nib = [UINib nibWithNibName:@"RecordCell" bundle:nil];
    [self.tab1 registerNib:nib forCellReuseIdentifier:@"record"];
    
    UINib *nib2 = [UINib nibWithNibName:@"UseTimeCell" bundle:nil];
    [self.tab2 registerNib:nib2 forCellReuseIdentifier:@"UseTime"];
    [self setUptables];
//    [self loadRefresh];
//    [self.view bringSubviewToFront:self.centerline];
    
}

-(void)setUptables
{
    //添加下拉刷新
    [self configBlock];
    UserModel *model = [[LoginService shareInstanced]getUserModel];
    self.tab2.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getFirstrecWithUid:model.uid];
    }];
    self.tab2.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getMorerecWithUid:model.uid];
    }];
    [self.tab2.header beginRefreshing];
    
}


-(void)configBlock
{
    [ExamService shareInstenced].getRecordSuccess = ^(id obj){
        
        [self.tab2.header endRefreshing];
        [self.tab2.footer endRefreshing];
        list  = [obj mutableCopy];
        [self.tab2 reloadData];
        
    };
    [ExamService shareInstenced].getRecordFailure = ^(id obj){
        
        [self showHudWithString:obj];
        [self.tab2.header endRefreshing];
        [self.tab2.footer endRefreshing];
        
        
    };
}

//-(void)initUI
//{
//    _segmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"使用时间",@"使用时长"]];
//    [_segmentedControl setFrame:CGRectMake(0, 0,ScreenWidth, 44)];
//    [_segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
//    [_segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleFullWidthStripe];
//    [_segmentedControl setSelectionIndicatorHeight:3];
//    [_segmentedControl setTextColor:[UIColor darkGrayColor]];
//    [_segmentedControl setFont:[UIFont systemFontOfSize:16]];
//    [_segmentedControl setSelectionIndicatorColor:BaseColor];
//    __weak RecordViewController * weakSelf = self;
//    [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
//        if (index == 0) {
//            [weakSelf.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];;
//        }else if (index == 1) {
//            [weakSelf.scrollview setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
//        }else{
//            return;
//        }
//    }];
//    
//    UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43.4, ScreenWidth, 0.6)];
//    line.backgroundColor = [UIColor colorWithRed:.831 green:.831 blue:.843 alpha:1.0f];
//    [_segmentedControl addSubview:line];
//    
//    [self.view addSubview:_segmentedControl];
//}
//
//#pragma scrollViewDelegate Methods
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.scrollview){
//        if (scrollView.contentOffset.x == 0) {
//            [_segmentedControl setSelectedSegmentIndex:0 animated:YES];
//        }else if (scrollView.contentOffset.x == ScreenWidth) {
//            [_segmentedControl setSelectedSegmentIndex:1 animated:YES];
//        }else{
//            return;
//        }
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == self.tab1) {
//        
//        RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"record"];
//        return cell;
//    }
//    else{
//        
//        UseTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UseTime"];
//        return cell;
//    }
    UseTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UseTime"];
    RecordModel *data = list[indexPath.row];
    cell.timelab.text = [NSString stringWithFormat:@"总时长：%@分钟",data.use_time];;
   
    cell.namelab.text = data.nickname;
    [cell.headimgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,data.avatar]] placeholderImage:Aavatar];
    cell.startdate.text = [NSString stringWithFormat:@"开始时间：%@",data.start_time];
    
    
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == self.tab1) {
//        
//        return 130;
//    }
//    else{
    
        return 95;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



@end
