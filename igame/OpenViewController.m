//
//  OpenViewController.m
//  igame
//
//  Created by Interest on 2016/12/14.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "OpenViewController.h"

@interface OpenViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UIButton *openbtn;
@property (weak, nonatomic) IBOutlet UIButton *closebtn;
@end

@implementation OpenViewController

{
    NSMutableArray *list;
    UserModel *model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tf becomeFirstResponder];
    self.topview.backgroundColor = BaseColor;
    self.openbtn.backgroundColor = BaseColor;
    [self.openbtn cornerRadius:4];
    [self.closebtn cornerRadius:4];
    
    self.title = @"儿童锁";
    model = [[LoginService shareInstanced]getUserModel];
    list = [@[_lab1,_lab2,_lab3,_lab4]mutableCopy];
}

- (IBAction)activetf:(id)sender {
    
    if (![self.tf isFirstResponder]) [self.tf becomeFirstResponder];
}

- (IBAction)action:(UIButton *)sender {

    if (self.tf.text.length == 4) {
        
        [ExamService shareInstenced].getExamRecordSuccess = ^(id obj){
            
            [self hideHud];
            DataModel *data = [ZZBluetoothManger shareInstance].currentModel;
            if (!data) {
                
                [self showHudWithString:@"请连接并选择需要通讯的蓝牙手柄..."];
            }
            else{
                
                NSString *value;
                if (sender.tag == 1) {
                    
                    value = @"0000";
                }else{
                    
                    NSString *time =[[NSUserDefaults standardUserDefaults]objectForKey:@"time"];
                    if (!time) time = @"30";
                    NSString *str = [self ToHex:[time intValue]];
                    if (str.length == 2) {
                        
                        value = [NSString stringWithFormat:@"%@00",str];
                    }else{
                        
                        value = [NSString stringWithFormat:@"%@0%@",[str substringFromIndex:1],[str substringToIndex:1]];
                    }
                }
                [[ZZBluetoothManger shareInstance]writePeripheral:data.cbPeripheral characteristic:data.cbCharacteristc2 value:[self hexToBytesWith:@"0202"]];
                [[ZZBluetoothManger shareInstance]writePeripheral:data.cbPeripheral characteristic:data.cbCharacteristc1 value:[value dataUsingEncoding:NSUTF8StringEncoding]];
                [self showHudWithString:@"设置成功"];
            }

        };
        [ExamService shareInstenced].getExamRecordFailure = ^(id obj){
            
            [self hideHud];
            [self showHudWithString:obj];
            
        };
        [self showHud];
        [[ExamService shareInstenced]openLockWithDic:@{@"uid":model.uid,@"password":self.tf.text,@"type":@(sender.tag-1)}];
    }

}
-(NSString *)ToHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i =0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length >= 4 && string.length) {
        
        return NO;
    }
    NSString *totalString;
    if (string.length <= 0) {
        totalString = [textField.text substringToIndex:textField.text.length-1];
    }
    else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    for (int a =0; a<list.count; a++) {
        
        UILabel *lab = list[a];
        if (a<totalString.length) {
            
            lab.text = [totalString substringWithRange:NSMakeRange(a, 1)];
        }else{
            lab.text = @"";
        }
        
    }
    NSLog(@"_____total %@",totalString);
    return YES;
}




@end
