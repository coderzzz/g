//
//  SignUpViewController.m
//  igame
//
//  Created by Interest on 2016/12/12.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignContenCell.h"
#import "SingCell.h"
@interface SignUpViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation SignUpViewController
{
    NSMutableArray *list;
    SignModel *data;
    UserModel *model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要报名";
    UINib *nib =[UINib nibWithNibName:@"SignContenCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"conten"];
    UINib *nib2 =[UINib nibWithNibName:@"SingCell" bundle:nil];
    [self.tableview registerNib:nib2 forCellReuseIdentifier:@"sign"];
     model = [[LoginService shareInstanced]getUserModel];
    [ExamService shareInstenced].getAllLikeSuccess = ^(id obj){
        
        [self hideHud];
        data = obj;
        [self.tableview reloadData];

        
    };
    [ExamService shareInstenced].getAllLikeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    [self showHud];
    [[ExamService shareInstenced]getAllLikeWithUid:model.uid battle_id:self.battle_id];
    
}

- (void)sign{
    
    
    [ExamService shareInstenced].addExamLikeSuccess = ^(id obj){
        
        [self hideHud];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    };
    [ExamService shareInstenced].addExamLikeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    [self showHud];
    [[ExamService shareInstenced]addExamLikeWithUid:model.uid tid:self.battle_id];
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return data.signs.count +1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        SignContenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conten"];
        cell.titlelab.text = data.battle_title;
        cell.contenlab.text = data.battle_title;
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,data.battle_thumb]] placeholderImage:Aavatar];
        [cell.signbtn addTarget:self action:@selector(sign) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{
        SingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sign"];
        UserModel *mod = data.signs[indexPath.row -1];
        [cell.imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,mod.avatar]] placeholderImage:Aavatar];
        cell.namelab.text = mod.nickname;
        return cell;
    }
    
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 446;
    }
    return 44;
}

@end
