//
//  TimeViewController.m
//  igame
//
//  Created by Interest on 2016/12/14.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "TimeViewController.h"
#import "TimeCell.h"
@interface TimeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *donebtn;
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation TimeViewController
{
    NSMutableArray *list;
    NSInteger select;
    UserModel *model;
}
- (IBAction)done:(id)sender {
    
    [ExamService shareInstenced].getPraRecordSuccess = ^(id obj){
        
        [self hideHud];
        NSString *times = [NSString stringWithFormat:@"%ld",(select +1) * 30];
        
        [[NSUserDefaults standardUserDefaults]setObject:times forKey:@"time"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    };
    [ExamService shareInstenced].getPraRecordFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
        
    };
    [self showHud];
    [[ExamService shareInstenced]setTimeWithDic:@{@"uid":model.uid,@"time":list[select]}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.topview.backgroundColor = BaseColor;
    self.donebtn.backgroundColor = BaseColor;
    [self.donebtn cornerRadius:4];
    UINib *nib =[UINib nibWithNibName:@"TimeCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"time"];
    self.title = @"儿童锁";
    model = [[LoginService shareInstanced]getUserModel];
    select = 0;
    list = [@[@"0.5",@"1.0",@"1.5",@"2.0",@"2.5"]mutableCopy];
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"time"];
    cell.lab.text = list[indexPath.row];
    if (indexPath.row == select) {
        
        cell.imgv.hidden = NO;
    }
    else{
        cell.imgv.hidden = YES;
    }
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    select = indexPath.row;
    [self.tableview reloadData];
   
}


@end
