//
//  SendGameViewController.m
//  igame
//
//  Created by Interest on 2016/12/9.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "SendGameViewController.h"
#import "LoginCell.h"
#import "ASBirthSelectSheet.h"
@interface SendGameViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UIButton *sendbtn;
@property (strong, nonatomic) IBOutlet UIView *footview;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIButton *imgbtn;

@end

@implementation SendGameViewController
{
    NSMutableArray *list;
    NSString  *base64Sting;
    NSString *selecttime;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sendbtn cornerRadius:5.0];
    self.headview.backgroundColor = BaseColor;
    self.footview.backgroundColor = Backgroundcolor;
    self.tableview.backgroundColor =Backgroundcolor;
    [self.tableview setTableFooterView:self.footview];
    [self.tableview setTableHeaderView:self.headview];
    self.sendbtn.backgroundColor =BaseColor;
    self.title = @"我要约战";
    UINib *nib =[UINib nibWithNibName:@"LoginCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"login"];
    list =[@[@[@"登录-手机号",@"请输入手机账号"],@[@"智能手柄-使用记录",@"请输入参赛时间，如：2017-12-29"]]mutableCopy];
}

- (IBAction)send:(UIButton *)sender {
    LoginCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    LoginCell *cell2 = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *phone = cell.tf.text;
    if (!(phone.length>0)) {
        
        [self showHudWithString:@"请输入手机号码"];
        return;
    }
    if (!(selecttime.length>0)) {
        
        [self showHudWithString:@"请输入参赛时间"];
        return;
    }
    if (!(self.tf.text.length>0)) {
        
        [self showHudWithString:@"请输入标题"];
        return;
    }
    if (!(base64Sting>0)) {
        
        [self showHudWithString:@"请选择图片"];
        return;
    }
   
    UserModel *model = [[LoginService shareInstanced]getUserModel];
    [ExamService shareInstenced].upLoadExamSuccess = ^(id obj){
      
        [self hideHud];
        [self showHudWithString:@"约战成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    };
    [ExamService shareInstenced].upLoadExamFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    [self showHud];
    [[ExamService shareInstenced]upLoadGameWithdic:@{@"uid":model.uid,
                                                     @"phone":phone,
                                                     @"battle_title":self.tf.text,
                                                     @"battle_thumb":base64Sting,
                                                     @"add_time":selecttime
                                                     
                                                     }];
    
}


- (IBAction)upload:(UIButton *)sender {
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self.view];
    actionSheet = nil;
}
#pragma mark - UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
    if(buttonIndex == 0)
    {
        [self presentViewController:[PhotoManager shareManager].camera animated:YES completion:nil];
    }
    else if(buttonIndex == 1)
    {
        [self presentViewController:[PhotoManager shareManager].pickingImageView animated:YES completion:nil];
    }
    
    [PhotoManager shareManager].configureBlock = ^(id image){
        if(image == nil)
        {
            return ;
        }
        image = [image imageWithSize:CGSizeMake(ScreenWidth-20, 200)];
        
        NSData *data  = UIImageJPEGRepresentation(image, 0.9);
        base64Sting = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self.imgbtn setBackgroundImage:image forState:UIControlStateNormal];
        
        
    };
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"login"];
    if (indexPath.row == 0) {
        
        cell.tf.keyboardType = UIKeyboardTypeNumberPad;
        cell.tf.userInteractionEnabled = YES;
    }
    else{
        cell.tf.keyboardType =UIKeyboardTypeDefault;
        cell.tf.userInteractionEnabled = NO;
        cell.tf.text = selecttime;
    }
    cell.imagv.image = [UIImage imageNamed:list[indexPath.row][0]];
    cell.tf.placeholder =list[indexPath.row][1];
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        //        datesheet.selectDate = @"2016-07-05";
        datesheet.GetSelectDate = ^(NSString *dateStr) {
            
            selecttime = dateStr;
            [self.tableview reloadData];
            NSLog(@"%@",dateStr);
        };
        [self.navigationController.view addSubview:datesheet];
    }
}

@end
