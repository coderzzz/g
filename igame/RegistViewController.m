//
//  RegistViewController.m
//  igame
//
//  Created by Interest on 2016/12/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginCell.h"
#import "LoginService.h"
#import "UIButton+Corner.h"
@interface RegistViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)rules:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registbtn;
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (strong, nonatomic) IBOutlet UIView *footview;

@end

@implementation RegistViewController
{
    NSMutableArray *list;
    int _surplusSecond;
    BOOL check;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _surplusSecond = 60;
    check = YES;
    [self.registbtn cornerRadius:5.0];
    self.headview.backgroundColor = BaseColor;
    self.footview.backgroundColor = Backgroundcolor;
    self.tableview.backgroundColor =Backgroundcolor;
    [self.tableview setTableFooterView:self.footview];
    [self.tableview setTableHeaderView:self.headview];
    self.registbtn.backgroundColor =BaseColor;
    self.title = @"注册";
    UINib *nib =[UINib nibWithNibName:@"LoginCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"login"];
    list =[@[@[@"登录-手机号",@"请输入用户名"],@[@"注册-手机号码",@"请输入手机号码"],@[@"注册-验证码",@"请输入验证码"],@[@"登录-密码",@"请设置登录密码"],@[@"登录-密码",@"请再次输入登录密码"]]mutableCopy];
}


- (IBAction)check:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        [sender setImage:nil forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"扫描-勾选"] forState:UIControlStateNormal];
    }
    check = !sender.selected;

}
- (IBAction)rules:(id)sender {
}
- (IBAction)regist:(id)sender {
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i<list.count; i++) {
        
         LoginCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [temp addObject:cell.tf.text?cell.tf.text:@""];
    }
    if ([temp[0] isEqualToString:@""]) {
        
        [self showHudWithString:@"请填写用户名"];
        return;
    }
    if ([temp[1] isEqualToString:@""]) {
        
        [self showHudWithString:@"请填写手机号"];
        return;
    }
    if ([temp[2] isEqualToString:@""]) {
        
        [self showHudWithString:@"请填写验证码"];
        return;
    }
    if (!([temp[3] isEqualToString:temp[4]] && ![temp[3] isEqualToString:@""])) {
        
        [self showHudWithString:@"请输入相同的密码"];
        return;
    }
    if (!check) {
        
        [self showHudWithString:@"请同意用户协议"];
        return;
    }
    [LoginService shareInstanced].registSuccess = ^(id obj){
        
        [self showHudWithString:@"注册成功"];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [LoginService shareInstanced].registFailure = ^(id obj){
        
        [self showHudWithString:@"注册失败"];
    };
    [[LoginService shareInstanced]registWithdic:@{@"phone":temp[1],
                                                  @"password":temp[3],
                                                  @"nickname":temp[0],
                                                  @"num":temp[2]
                                                  }];
}

- (void)word:(UIButton *)btn{

    
    LoginCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (!(cell.tf.text.length>0)) return;
    [[LoginService shareInstanced]getCodeWithPhoneNumber:cell.tf.text type:@"0"];
    [LoginService shareInstanced].getCodeSuccess = ^(id obj){
      
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if (_surplusSecond <= 0) {
                
                _surplusSecond = 60;
                dispatch_source_cancel(timer);
                dispatch_async(mainQueue, ^{
                    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    btn.enabled = YES;
                });
                
            } else {
                _surplusSecond--;
                dispatch_async(mainQueue, ^{
                    NSString *btnInfo = [NSString stringWithFormat:@"重新获取%ld秒", (long)(_surplusSecond + 1)];
                    btn.enabled = NO;
                    [btn setTitle:btnInfo forState:UIControlStateDisabled];
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
    if (indexPath.row == 1 || indexPath.row == 2) {
        
        cell.tf.keyboardType = UIKeyboardTypeNumberPad;
    }
    else{
        cell.tf.keyboardType =UIKeyboardTypeDefault;
    }
    if (indexPath.row == 2) {
        
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
