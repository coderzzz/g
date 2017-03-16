//
//  BatteryViewController.m
//  igame
//
//  Created by Interest on 2017/1/16.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import "BatteryViewController.h"

@interface BatteryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *batterystatuelab;
@property (weak, nonatomic) IBOutlet UILabel *batteryvaluelab;
@property (weak, nonatomic) IBOutlet UILabel *handspeedlab;

@end

@implementation BatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"状态";
    DataModel *model = [ZZBluetoothManger shareInstance].currentModel;
    if (!model) {
        
        [self showHudWithString:@"请连接并选择需要通讯的蓝牙手柄..."];
    }
    else{
        
        
        [ZZBluetoothManger shareInstance].completeBlock = ^(id obj){
            
            NSLog(@"complete = %@",obj);
            NSMutableArray *datalist = [obj mutableCopy];
            NSString *statue = [NSString stringWithFormat:@"%@",datalist[0]];
            NSString *btv = [NSString stringWithFormat:@"%lu",strtoul([datalist[1] UTF8String],0,16)];
            NSString *speed = [NSString stringWithFormat:@"%@%@",datalist[3],datalist[2]];
            NSString *str = [NSString stringWithFormat:@"手速：%lu次每分钟",strtoul([speed UTF8String],0,16)];
            self.batteryvaluelab.text = [NSString stringWithFormat:@"当前电量：%@",btv];
            self.batterystatuelab.text = [statue boolValue]?@"是否充电中：是":@"是否充电中：否";
            self.handspeedlab.text = str;
        };
        
        [[ZZBluetoothManger shareInstance]writePeripheral:model.cbPeripheral characteristic:model.cbCharacteristc2 value:[self hexToBytesWith:@"0384"]];
        [[ZZBluetoothManger shareInstance]readvalue:model];
    }
    
    
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

@end
