//
//  LoginViewController.m
//  igame
//
//  Created by Interest on 2016/12/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "PasswordViewController.h"
#import "LoginCell.h"
#import "UIButton+Corner.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *footview;
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;

@end

@implementation LoginViewController
{
    NSMutableArray *list;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginbtn cornerRadius:5.0];
    self.headview.backgroundColor = BaseColor;
    self.footview.backgroundColor = Backgroundcolor;
    self.tableview.backgroundColor =Backgroundcolor;
    [self.tableview setTableFooterView:self.footview];
    [self.tableview setTableHeaderView:self.headview];
    self.loginbtn.backgroundColor =BaseColor;
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = nil;
    UINib *nib =[UINib nibWithNibName:@"LoginCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"login"];
    list =[@[@[@"登录-手机号",@"请输入手机账号"],@[@"登录-密码",@"请输入密码"]]mutableCopy];
}

- (IBAction)registAction:(id)sender {
    
    RegistViewController *vc = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)passwordaction:(id)sender {
    
    PasswordViewController *vc = [[PasswordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginaction:(id)sender {
    
    LoginCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
     LoginCell *cell2 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *phone = cell.tf.text;
    NSString *password = cell2.tf.text;

    if (!(phone.length>0)) {
        
        [self showHudWithString:@"请填写手机号"];
        return;
    }
    if (!(password.length>0)) {
        
        [self showHudWithString:@"请填写密码"];
        return;
    }

    [LoginService shareInstanced].loginSuccess = ^(id obj){
        
        [self hideHud];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
        TabBarViewController *vc = [[TabBarViewController alloc]init];
        delegate.window.rootViewController = vc;
        
    };
    [LoginService shareInstanced].loginFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    [self showHud];
    [[LoginService shareInstanced]loginWithPhoneNumber:phone passWord:password];
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"login"];
    cell.imagv.image = [UIImage imageNamed:list[indexPath.row][0]];
    if (indexPath.row == 0) {
        
        cell.tf.keyboardType = UIKeyboardTypeNumberPad;
    }
    else{
        cell.tf.keyboardType =UIKeyboardTypeDefault;
    }
    cell.tf.placeholder =list[indexPath.row][1];
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}




@end
