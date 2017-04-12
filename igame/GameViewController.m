//
//  GameViewController.m
//  igame
//
//  Created by Interest on 2016/12/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "GameViewController.h"
#import "ChildrenViewController.h"
#import "ConnectViewController.h"
#import "RecordViewController.h"
#import "AppDelegate.h"
#import "BatteryViewController.h"
@interface GameViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIView *contentview;
@property (weak, nonatomic) IBOutlet UIView *funtionview;
@property (weak, nonatomic) IBOutlet UIButton *datebtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIView *top;
@property (strong, nonatomic) IBOutlet UIView *timev;


@property (weak, nonatomic) IBOutlet UIButton *usebtn;
@end

@implementation GameViewController
{
    NSInteger select;
    NSMutableArray *list;
}
- (IBAction)cancle:(id)sender {
    
    self.timev.hidden = YES;
}

- (IBAction)done:(id)sender {
    
    self.timev.hidden = YES;
    
    NSString *str = [list[select] componentsJoinedByString:@""];
    NSLog(@"%@",str);
    
    //写入时间
    DataModel *model = [ZZBluetoothManger shareInstance].currentModel;
    [[ZZBluetoothManger shareInstance] writePeripheral:model.cbPeripheral characteristic:model.cbCharacteristc2 value:[self hexToBytesWith:@"0105"]];
    [[ZZBluetoothManger shareInstance] writePeripheral:model.cbPeripheral  characteristic:model.cbCharacteristc1 value:[self hexToBytesWith:str]];
}
-(NSData *)hexToBytesWith:(NSString *)str{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentview.backgroundColor = BaseColor;
    [self.usebtn setTitleColor:BaseColor forState:UIControlStateNormal];;
    [self.datebtn setTitleColor:BaseColor forState:UIControlStateNormal];
    NSString *date = [[NSDate date]formatDateString:nil];
    [self.datebtn setTitle:date forState:UIControlStateNormal];
    
    self.timev.backgroundColor = [UIColor colorWithWhite:.2 alpha:.3];
    self.timev.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.timev.hidden = YES;
    
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [dele.window addSubview:self.timev];
    
    self.top.backgroundColor = BaseColor;
    self.tableview.backgroundColor = [UIColor whiteColor];
    
    
    if (self.view.frame.size.height >450) {
        
        self.contentview.frame  = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49);
        [self.scrollview addSubview:self.contentview];
    }
    else{
        self.contentview.frame  = CGRectMake(0, 0, ScreenWidth, 450);
        [self.scrollview addSubview:self.contentview];
    }
  
}
- (IBAction)action:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        ChildrenViewController *vc = [[ChildrenViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 5 ){
        
        self.timev.hidden = NO;
        NSString *datestr = [[NSDate date]formatDateString:@"YYYY-MM-dd-HH-mm"];
        NSString *str = [datestr substringFromIndex:2];
        NSArray *temp = [str componentsSeparatedByString:@"-"];
        list = [NSMutableArray array];
        for (int a=0; a<4; a++) {
            
            NSMutableArray *ary = [@[]mutableCopy];
            int year = [temp[0] intValue];
            [ary addObject:[NSString stringWithFormat:@"%d",year+a]];
            
            int monuth = [temp[1] intValue];
            if ((monuth + a)>12) {
                
                NSString *str =[NSString stringWithFormat:@"%d",(monuth + a) -12];
                [ary addObject:[self addst:str]];

            }else{
                NSString *str =[NSString stringWithFormat:@"%d",(monuth + a)];
                [ary addObject:[self addst:str]];
            }
            
            int day = [temp[2] intValue];
            if ((day + a)>30) {
                
                NSString *str =[NSString stringWithFormat:@"%d",(day + a) -30];
                [ary addObject:[self addst:str]];
                
            }else{
                
                NSString *str =[NSString stringWithFormat:@"%d",(day + a)];
                [ary addObject:[self addst:str]];
            }

            int hour = [temp[3] intValue];
            if ((hour + a)>23) {
                
                NSString *str =[NSString stringWithFormat:@"%d",(hour + a) -24];
                [ary addObject:[self addst:str]];
                
            }else{
                
                NSString *str =[NSString stringWithFormat:@"%d",(hour + a)];
                [ary addObject:[self addst:str]];            }

            int sec = [temp[4] intValue];
            if ((sec + a)>60) {
                
                NSString *str =[NSString stringWithFormat:@"%d",(sec + a) -60];
                [ary addObject:[self addst:str]];
            }else{
                
                NSString *str =[NSString stringWithFormat:@"%d",(sec + a)];
                [ary addObject:[self addst:str]];
            }
            [list addObject:ary];
        }
        [self.tableview reloadData];
    }
    else if ( sender.tag == 6){

        RecordViewController *vc = [[RecordViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 4){
        
        BatteryViewController *vc = [[BatteryViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

    else{
        
        ConnectViewController *vc = [[ConnectViewController alloc]init];
        vc.type = [NSString stringWithFormat:@"%ld",(long)sender.tag];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"c"];
    NSMutableArray *temp = list[indexPath.row];
    if (select == indexPath.row) {
        
        cell.textLabel.textColor = BaseColor;
        cell.contentView.backgroundColor=  [UIColor colorWithRed:0.0/255.0 green:178.0/255.0 blue:156.0/255.0 alpha:.3];
    }
    else{
        cell.textLabel.textColor =[UIColor darkGrayColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"20%@年   %@月   %@日   %@时    %@分",temp[0],[self addst:temp[1]],[self addst:temp[2]],[self addst:temp[3]],[self addst:temp[4]]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (NSString *)addst:(NSString *)s{
    
    if (s.length==1) {
        s = [NSString stringWithFormat:@"0%@",s];
    }
    return s;
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    select = indexPath.row;
    [self.tableview reloadData];
    
}


@end
