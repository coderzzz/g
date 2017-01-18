//
//  BlogDetailViewController.m
//  igame
//
//  Created by Interest on 2016/12/12.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "BlogDetailViewController.h"
#import "DetailCell.h"
#import "CommonCell.h"
@interface BlogDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *commentview;
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation BlogDetailViewController
{
    NSMutableArray *list;
    NSString *userid;
    NewsModel *data;
    UITextField *textfield;
}



- (id)initWithUid:(NSString *)uid NewsModel:(NewsModel *)model{
    
    self = [super init];
    if (self) {
        
        userid = uid;
        data = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    list = [NSMutableArray array];
    self.title = @"帖子";
    UINib *nib =[UINib nibWithNibName:@"DetailCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"detail"];
    UINib *nib2 =[UINib nibWithNibName:@"CommonCell" bundle:nil];
    [self.tableview registerNib:nib2 forCellReuseIdentifier:@"common"];
    self.tableview.backgroundColor = Backgroundcolor;
    
//    self.commentview.frame = CGRectMake(0, , ScreenWidth, 40);
//    [self.view addSubview:self.commentview];
//
    textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    textfield.alpha = 0.001;
    textfield.inputAccessoryView = self.commentview;
    [self.view addSubview:textfield];

    
  
    [[ExamService shareInstenced]getExamLikeWithUid:userid cid:data.id];
    [ExamService shareInstenced].getExamLikeSuccess = ^(id obj){
      
        data.comment_count = [NSString stringWithFormat:@"%@",obj[@"comment_count"]];
        [self setUptables];
    };
    
//
}

-(void)setUptables
{
    //添加下拉刷新
    [self configBlock];
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getFirstcomWithUid:userid newsid:data.id];
    }];
    self.tableview.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [[ExamService shareInstenced]getMorecomWithUid:userid newsid:data.id];
    }];
    [self.tableview.header beginRefreshing];
    
}


-(void)configBlock
{
    [ExamService shareInstenced].getCommentsSuccess = ^(id obj){
        
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        list  = [obj mutableCopy];
        [self.tableview reloadData];
        
    };
    [ExamService shareInstenced].getCommentsFailure = ^(id obj){
        
        [self showHudWithString:obj];
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
        
    };
}

- (void)input{
    
    if (![textfield isFirstResponder]) {
        
        [textfield becomeFirstResponder];
        [self.tf becomeFirstResponder];
    }
}
- (IBAction)send:(id)sender {
    
    if (self.tf.text.length>0) {
        
        [ExamService shareInstenced].getAllowExamSuccess = ^(id obj){
            
            [self hideHud];
            CommentModel *model = [[CommentModel alloc]init];
            model.add_time = [[NSDate date]formatDateString:@"YYYY-MM-dd HH:mm"];
            model.comment = self.tf.text;
            UserModel *user= [[LoginService shareInstanced]getUserModel];
            model.avatar = user.avatar;
            model.nickname = user.nickname;
            
            [list addObject:model];
            [self.tableview reloadData];
            self.tf.text = nil;
            [self.tf resignFirstResponder];
            [textfield resignFirstResponder];
        };
        [ExamService shareInstenced].getAllowExamFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:obj];
            
        };
        [self showHud];
        [[ExamService shareInstenced]getAllowExamWithdic:@{@"news_id":data.id,
                                                           @"uid":userid,
                                                           @"comment":self.tf.text
                                                           }];

        NSLog(@"%@",self.tf.text);
    }
    else{
        [self.tf resignFirstResponder];
        [textfield resignFirstResponder];
    }
}
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return list.count +1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
    
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
        cell.titlelab.text = data.news_title;
        [cell.commonsbtn setTitle:data.comment_count forState:UIControlStateNormal];
        [cell.readbtn setTitle:data.read_times forState:UIControlStateNormal];
        cell.namelab.text = data.nickname;
        cell.contentlab.text = data.content;
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,data.news_thumb]] placeholderImage:Aavatar];
        cell.datelab.text = data.add_time;
        [cell.common addTarget:self action:@selector(input) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{
        
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"common"];
        CommentModel *comment = list[indexPath.row -1];
        cell.namelab.text = comment.nickname;
        cell.contentlab.text =comment.comment;
        [cell.headimgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,comment.avatar]] placeholderImage:Aavatar];
        cell.datelab.text =comment.add_time;
        return cell;
    }
    
    
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
      CGFloat height = [RTLabel getHightWithString:data.content andSizeValue:14.0 andWidth:ScreenWidth-20];
        return 355 + height;
    }
    CommentModel *comment = list[indexPath.row -1];
    CGFloat height = [RTLabel getHightWithString:comment.comment andSizeValue:14.0 andWidth:ScreenWidth-64];
    return 70 + height;
}


@end
