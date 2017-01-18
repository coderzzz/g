//
//  SendBlogViewController.m
//  igame
//
//  Created by Interest on 2016/12/12.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "SendBlogViewController.h"

@interface SendBlogViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *imagebtn;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@end

@implementation SendBlogViewController
{
    NSString  *base64Sting;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendblog)];
    self.navigationItem.rightBarButtonItem = item;
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem = item2;
}

- (void)sendblog{
    
    if (!(self.tf.text.length>0)) {
        
        [self showHudWithString:@"请输入标题"];
        return;
    }
    
    if (!(self.textview.text.length>0)) {
        
        [self showHudWithString:@"请输入内容"];
        return;
    }
    if (!(base64Sting>0)) {
        
        [self showHudWithString:@"请选择图片"];
        return;
    }
    
    UserModel *model = [[LoginService shareInstanced]getUserModel];
    [ExamService shareInstenced].upLoadMnExamSuccess = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    };
    [ExamService shareInstenced].upLoadMnExamFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
    };
    [self showHud];
    [[ExamService shareInstenced]upLoadMnExamWithdic:@{@"uid":model.uid,
                                                     @"news_title":self.tf.text,
                                                     @"news_thumb":base64Sting,
                                                     @"content":self.textview.text
                                                     
                                                     }];
}
- (void)cancle{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)action:(UIButton *)sender {
    
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
        [self.imagebtn setBackgroundImage:image forState:UIControlStateNormal];
        
        
    };
}

@end
