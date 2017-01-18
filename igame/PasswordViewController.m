//
//  PasswordViewController.m
//  igame
//
//  Created by Interest on 2016/12/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "PasswordViewController.h"
#import "LoginCell.h"
#import "UIButton+Corner.h"
@interface PasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (strong, nonatomic) IBOutlet UIView *footview;
@property (weak, nonatomic) IBOutlet UIButton *resetbtn;
- (IBAction)resetAction:(id)sender;

@end

@implementation PasswordViewController
{
    NSMutableArray *list;
    int time;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    time = 60;
    [self.resetbtn cornerRadius:5.0];
    self.headview.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:178.0/255.0 blue:156.0/255.0 alpha:1];
    self.footview.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    self.tableview.backgroundColor =[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    [self.tableview setTableFooterView:self.footview];
    [self.tableview setTableHeaderView:self.headview];
    self.resetbtn.backgroundColor =[UIColor colorWithRed:0.0/255.0 green:178.0/255.0 blue:156.0/255.0 alpha:1];
    self.title = @"忘记密码";
    UINib *nib =[UINib nibWithNibName:@"LoginCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"login"];
    list =[@[@[@"注册-手机号码",@"请输入手机号码"],@[@"注册-验证码",@"请输入验证码"],@[@"登录-密码",@"请设置登录密码"],@[@"登录-密码",@"请再次输入登录密码"]]mutableCopy];
}


- (IBAction)resetAction:(id)sender {
    
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i<list.count; i++) {
        
        LoginCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [temp addObject:cell.tf.text?cell.tf.text:@""];
    }

    if ([temp[0] isEqualToString:@""]) {
        
        [self showHudWithString:@"请填写手机号"];
        return;
    }
    if ([temp[1] isEqualToString:@""]) {
        
        [self showHudWithString:@"请填写验证码"];
        return;
    }
    if ([temp[2] isEqualToString:temp[3]] && ![temp[3] isEqualToString:@""]) {
        
        [self showHudWithString:@"请输入相同的密码"];
        return;
    }
    [LoginService shareInstanced].changePWSuccess = ^(id obj){
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    [LoginService shareInstanced].changePWFailure = ^(id obj){
        
        [self showHudWithString:@"重置失败"];
    };
    [[LoginService shareInstanced]changePwWithdic:@{@"phone":temp[0],@"new_password":temp[2],@"num":temp[1]}];
    
    
    
}

- (void)word:(UIButton *)sender{
    
    
    LoginCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (!(cell.tf.text.length>0)) return;
    [[LoginService shareInstanced]getCodeWithPhoneNumber:cell.tf.text type:@"1"];
    [LoginService shareInstanced].getCodeSuccess = ^(id obj){
        
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if (time <= 0) {
                
                time = 60;
                dispatch_source_cancel(timer);
                dispatch_async(mainQueue, ^{
                    [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                    sender.enabled = YES;
                });
                
            } else {
                time--;
                dispatch_async(mainQueue, ^{
                    NSString *btnInfo = [NSString stringWithFormat:@"重新获取%ld秒", (long)(time + 1)];
                    sender.enabled = NO;
                    [sender setTitle:btnInfo forState:UIControlStateDisabled];
                });
            }
        });
        dispatch_source_set_cancel_handler(timer, ^{
            NSLog(@"Cancel Handler");
        });
        dispatch_resume(timer);
        
    };
    [LoginService shareInstanced].getCodeFailure = ^(id obj){
        
        NSLog(@"%@",obj);
    };
    
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"login"];
    cell.imagv.image = [UIImage imageNamed:list[indexPath.row][0]];
    cell.tf.placeholder =list[indexPath.row][1];
    if (indexPath.row == 1) {
        
        cell.wordbtn.hidden = NO;
        [cell.wordbtn addTarget:self action:@selector(word:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
