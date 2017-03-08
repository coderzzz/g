//
//  PersonViewController.m
//  igame
//
//  Created by Interest on 2016/12/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "PersonViewController.h"
#import "ReNameViewController.h"
#import "SexViewController.h"
#import "MyBlogViewController.h"
#import "MyGameViewController.h"
#import "IntroduceViewController.h"
#import "UIButton+WebCache.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"
@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource,SexViewControllerDelegate,ReNameViewControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (weak, nonatomic) IBOutlet UIButton *headbtn;
@property (weak, nonatomic) IBOutlet UIButton *namebtn;
@property (strong, nonatomic) IBOutlet UIView *footerview;
@property (weak, nonatomic) IBOutlet UIButton *logoutbtn;

@end

@implementation PersonViewController
{
    NSMutableArray *leflist;
    NSMutableArray *rightlist;
    UserModel *model;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupui];
}
- (IBAction)loginout:(id)sender{
    
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)setupui{
    
    model = [[LoginService shareInstanced]getUserModel];
    [self.headbtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Img_URL_Prefix,model.avatar]] forState:UIControlStateNormal placeholderImage:Aavatar];
    [self.namebtn setTitle:model.nickname forState:UIControlStateNormal];
    rightlist = [@[@[model.phone,[model.sex isEqualToString:@"2"]?@"女":@"男",model.age?model.age:@""],@[@"我的帖子",@"我的约战"],@[@"使用说明",@"产品介绍"]]mutableCopy];
    [self.tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headview.backgroundColor = BaseColor;
    [_headbtn cornerRadius:3];
    [_logoutbtn cornerRadius:3];
    
    [self.tableview setTableHeaderView:self.headview];
    NSLog(@"");
    [self.tableview setTableFooterView:self.footerview];
    leflist = [@[@[@"电话",@"性别",@"年龄"],@[@"个人中心-我的帖子",@"个人中心-我的约战"],@[@"个人中心-使用说明",@"个人中心-产品介绍"]]mutableCopy];
    
}


- (IBAction)rename:(id)sender {
    
    ReNameViewController *vc = [[ReNameViewController alloc]init];
    vc.delegate = self;
    vc.title = @"修改昵称";
    vc.text = @"请输入您的昵称";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)head:(id)sender {
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self.view];
    actionSheet = nil;
}
#pragma mark UIAlertViewDelegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [[LoginService shareInstanced]loginout];
        LoginViewController *vc = [[LoginViewController alloc]init];
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        dele.window.rootViewController = nav;
    }
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
        NSString *base64Sting = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [[ExamService shareInstenced]delErrorTitleWithUid:model.uid tid:base64Sting];
        [self showHud];
        [ExamService shareInstenced].delErrorSuccess = ^(id obj){
            
            [[LoginService shareInstanced]saveUserModelWithDictionary:@{@"avatar":obj}];
            [self hideHud];
            [self.headbtn setBackgroundImage:image forState:UIControlStateNormal];
        };
        [ExamService shareInstenced].delErrorFailure = ^(id obj){
          
            [self hideHud];
            [self showHudWithString:obj];
        };
        
        
        
    };
}


#pragma mark SexViewControllerDelegate
- (void)didChangeSex:(NSInteger)sex{
    
    [[ExamService shareInstenced]savePracticeWithJsonString:model.uid time:[NSString stringWithFormat:@"%ld",(long)sex]];
    [self showHud];
    [ExamService shareInstenced].savePracticeSuccess = ^(id obj){
        
        [[LoginService shareInstanced]saveUserModelWithDictionary:@{@"sex":[NSString stringWithFormat:@"%ld",(long)sex]}];
        [self hideHud];
        [self setupui];
    };
    [ExamService shareInstenced].savePracticeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };

}

#pragma mark ReNameViewControllerDelegate
- (void)didChangeName:(NSString *)name title:(NSString *)title{
    
    if ([title isEqualToString:@"修改昵称"]) {
        

        [[ExamService shareInstenced]getErrorTitleWithUid:model.uid tid:name];
        [self showHud];
        [ExamService shareInstenced].getErrorTitleSuccess = ^(id obj){
            
            [[LoginService shareInstanced]saveUserModelWithDictionary:@{@"nickname":name}];
            [self hideHud];
            [self showHudWithString:@"修改成功"];
            [self.namebtn setTitle:name forState:UIControlStateNormal];
        };
        [ExamService shareInstenced].getErrorTitleFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:obj];
        };
        
        
        
        
    }
    else{
        
        
        [self hideHud];
        [[ExamService shareInstenced]getPracticeWithTypeId:name uid:model.uid];
        [self showHud];
        [ExamService shareInstenced].getPracticeSuccess = ^(id obj){
            
            [[LoginService shareInstanced]saveUserModelWithDictionary:@{@"age":name}];
            [self hideHud];
            [self showHudWithString:@"修改成功"];
             [self setupui];
        };
        [ExamService shareInstenced].getPracticeFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:obj];
        };
    }
    
}
#pragma mark UITableViewDataSource
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return leflist.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [leflist[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (indexPath.row == 0 && indexPath.section == 0) {
        
         cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
     
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = leflist[indexPath.section][indexPath.row];
        cell.detailTextLabel.text = rightlist[indexPath.section][indexPath.row];
    }else{

        cell.textLabel.text = rightlist[indexPath.section][indexPath.row];
        cell.imageView.image= [UIImage imageNamed:leflist[indexPath.section][indexPath.row]];
    }
    return cell;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
           
            SexViewController *vc = [[SexViewController alloc]init];
            vc.delegate = self;
            vc.mysex = model.sex;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row == 2) {
            
            ReNameViewController *vc = [[ReNameViewController alloc]init];
            vc.delegate = self;
            vc.title = @"修改年龄";
            vc.text = @"请输入您的年龄";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1) {
        
        
        if (indexPath.row == 0) {
            
            MyBlogViewController *vc = [[MyBlogViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row == 1) {
            
            MyGameViewController *vc = [[MyGameViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 2) {
        
        
        if (indexPath.row == 0) {
            
            IntroduceViewController *vc = [[IntroduceViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = @"使用说明";
            vc.type = @"1";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row == 1) {
            
            IntroduceViewController *vc = [[IntroduceViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = @"产品介绍";
            vc.type = @"2";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}



@end
