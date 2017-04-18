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
#import "gCell.h"
@interface GameViewController ()<UITableViewDelegate,UITableViewDataSource,gCellDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIView *contentview;
@property (weak, nonatomic) IBOutlet UIView *funtionview;
@property (weak, nonatomic) IBOutlet UIButton *datebtn;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@property (weak, nonatomic) IBOutlet UIView *top;
@property (strong, nonatomic) IBOutlet UIView *timev;


@property (weak, nonatomic) IBOutlet UIButton *usebtn;
@end

@implementation GameViewController
{
    NSInteger select;
    NSMutableArray *list;
    NSMutableArray *selectArray;
}
- (IBAction)cancle:(id)sender {
    
    self.timev.hidden = YES;
}

- (IBAction)done:(id)sender {
    
    self.timev.hidden = YES;
    selectArray= [@[@"",@"",@"",@"",@""]mutableCopy];

    for (int a=0; a<5; a++) {
        
        NSInteger row = [self.picker selectedRowInComponent:a];
        [selectArray replaceObjectAtIndex:a withObject:list[a][row]];
    }
    
    NSString *str = [selectArray componentsJoinedByString:@""];
    NSLog(@"selectArray= %@",str);
    
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
        selectArray= [@[@"",@"",@"",@"",@""]mutableCopy];
        NSString *ye = temp[0];
        NSMutableArray *years = [NSMutableArray array];
        for (int a=0; a<20; a++) {
            
            [years addObject:[NSString stringWithFormat:@"%d",[ye intValue]+a]];
            
        }
        NSMutableArray *mons = [NSMutableArray array];
        for (int a=1; a<13; a++) {
            
            NSString *mon =[NSString stringWithFormat:@"%d",a];
            
            [mons addObject:[self addst:mon]];
            
        }
        NSMutableArray *days = [NSMutableArray array];
        for (int a=1; a<31; a++) {
            
            NSString *day =[NSString stringWithFormat:@"%d",a];
            
            [days addObject:[self addst:day]];
            
        }
        
        NSMutableArray *hours = [NSMutableArray array];
        for (int a=0; a<24; a++) {
            
            NSString *day =[NSString stringWithFormat:@"%d",a];
            
            [hours addObject:[self addst:day]];
            
        }
        
        NSMutableArray *mins = [NSMutableArray array];
        for (int a=0; a<60; a++) {
            
            NSString *day =[NSString stringWithFormat:@"%d",a];
            
            [mins addObject:[self addst:day]];
            
        }
        list =[@[years,mons,days,hours,mins]mutableCopy];
        [self.picker reloadAllComponents];
        [self.picker selectRow:0 inComponent:0 animated:NO];
        [self.picker selectRow:[temp[1] intValue]-1 inComponent:1 animated:NO];
        [self.picker selectRow:[temp[2] intValue]-1 inComponent:2 animated:NO];
        [self.picker selectRow:[temp[3] intValue] inComponent:3 animated:NO];
        [self.picker selectRow:[temp[4] intValue] inComponent:4 animated:NO];
       
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
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 5;
    
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [list[component] count];
    
}
#pragma mark UIPickerViewDelegate
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self titleForRow:row forComponent:component];
    UIFont* font = [UIFont fontWithName:@"Helvetica" size:14.0];
    NSDictionary * attrDic = @{NSForegroundColorAttributeName:BaseColor,
                               NSFontAttributeName:font};
    
    NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:str attributes:attrDic];
    return attrString;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    // Fill the label text here
    pickerLabel.attributedText=[self pickerView:pickerView attributedTitleForRow:row forComponent:component];
    return pickerLabel;
}
- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        
        return [NSString stringWithFormat:@"20%@年",list[component][row]];
    }
    if (component == 1) {
        
        return [NSString stringWithFormat:@"%@月",list[component][row]];
    }
    if (component == 2) {
        
        return [NSString stringWithFormat:@"%@日",list[component][row]];
    }
    if (component == 3) {
        
        return [NSString stringWithFormat:@"%@小时",list[component][row]];
    }
    return [NSString stringWithFormat:@"%@分钟",list[component][row]];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
   // [selectArray replaceObjectAtIndex:component withObject:list[component][row]];
}
//#pragma mark gCellDelegate 
//- (void)didSelectBtn:(UIButton *)btn{
//    
//    NSLog(@"%@",btn);
//    select = btn.superview.tag;
//    [self.tableview reloadData];
//    
//    
//    
//    
//}
//#pragma mark UITableViewDataSource
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
//    
//    return list.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    gCell *cell =[tableView dequeueReusableCellWithIdentifier:@"gcell"];
//    cell.delegate = self;
//    cell.contentView.tag = indexPath.row;
//    [cell setCellTextWithList:list[indexPath.row]];
//    [cell setBgColorWihtSelect:(select==indexPath.row)];
//    
//    return cell;
//}
//
- (NSString *)addst:(NSString *)s{
    
    if (s.length==1) {
        s = [NSString stringWithFormat:@"0%@",s];
    }
    return s;
}
//
//
//#pragma mark UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return 50;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    select = indexPath.row;
//    [self.tableview reloadData];
//    
//}
//
//
@end
