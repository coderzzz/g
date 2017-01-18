//
//  ConnectViewController.m
//  igame
//
//  Created by Interest on 2016/12/14.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "ConnectViewController.h"

@interface ConnectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headview;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UISwitch *swi;
@property (weak, nonatomic) IBOutlet UILabel *tiplab;

@end

@implementation ConnectViewController
{
    NSMutableArray *list;
    NSInteger index;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.type isEqualToString:@"1"]) {
        
        self.title = @"扫描";
        self.swi.hidden = YES;
        self.titlelab.text = @"扫描蓝牙手柄";
        self.tiplab.text = @"搜索到的蓝牙设备...";
        __weak typeof(ConnectViewController) *weakSelf = self;
        [[ZZBluetoothManger shareInstance] startScanWithBlock:^(NSMutableArray *ary) {
            
            list = [ary copy];
            [weakSelf.tableview reloadData];
            NSLog(@" startScan %@",ary);
        }];
        
    }
    else if ([self.type isEqualToString:@"2"]){
        
        self.title = @"连接";
        self.titlelab.text = @"蓝牙连接";
        self.tiplab.text = @"我的设备";
        __weak typeof(ConnectViewController) *weakSelf = self;
        [[ZZBluetoothManger shareInstance] startScanWithBlock:^(NSMutableArray *ary) {
            
            list = [ary copy];
            [weakSelf.tableview reloadData];
            NSLog(@" connect %@",ary);
        }];
        
    }
    else{
        
        self.title = @"通讯";
        self.swi.hidden = YES;
        self.titlelab.text = @"通讯";
        self.tiplab.text = @"请选择需要通讯的设备...";
        index = 999;
        list = [[ZZBluetoothManger shareInstance].lightList copy];
        [self.tableview reloadData];

    }

    [self.tableview setTableHeaderView:self.headview];
}
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if ([self.type isEqualToString:@"3"]) {
        
        DataModel *model = list[indexPath.row];
        cell.textLabel.text = model.cbPeripheral.name;
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 10)];
        imgv.image = [UIImage imageNamed:@"扫描-勾选"];
        if (indexPath.row == index) {
            cell.accessoryView = imgv;
        }
        else{
            cell.accessoryView = nil;
        }
    }
    else{
     
        CBPeripheral *cbPeripheral = list[indexPath.row];
        cell.textLabel.text = cbPeripheral.name?cbPeripheral.name:@"未知设备";
        if ([self.type isEqualToString:@"2"]) {
            
            NSString *state;
            if (cbPeripheral.state == CBPeripheralStateConnected) {
                
                state = @"已连接";
            }
            else{
                
                state = @"未连接";
            }
            cell.detailTextLabel.text = state;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.type isEqualToString:@"2"]) {
        
        CBPeripheral *cbPeripheral = list[indexPath.row];
        if (cbPeripheral.state != CBPeripheralStateConnected ) {
            
            [[ZZBluetoothManger shareInstance]startconnectWithPeripheral:cbPeripheral block:^(BOOL isSuccess, NSError *error, DataModel *model) {
                
                [self.tableview reloadData];
                
            }];
        }
    }
    else if ([self.type isEqualToString:@"3"]){
       
        index = indexPath.row;
        [self.tableview reloadData];
        
        DataModel *selectmodel = list[indexPath.row];
        [ZZBluetoothManger shareInstance].currentModel = selectmodel;
    };
}


@end
