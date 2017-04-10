//
//  ZZBluetoothManger.m
//  ibulb
//
//  Created by Interest on 16/1/20.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "ZZBluetoothManger.h"

#define ServiceUUID @"CDEACB10-5235-4C07-8846-93A37EE6B86D"

#define CBCharacteristic1 @"CDEACB11-5235-4C07-8846-93A37EE6B86D"
#define CBCharacteristic2 @"CDEACB12-5235-4C07-8846-93A37EE6B86D"
@implementation ZZBluetoothManger
{
    
    NSUInteger currentIndex;
    
    BOOL didConnect;
    
    NSString *retrieveidentifier;
    
    NSMutableDictionary *macDic;
    
    dispatch_queue_t queue;
    
    NSMutableArray *dataList;
}

+ (ZZBluetoothManger *)shareInstance{
    
    
    static dispatch_once_t once;
    
    static ZZBluetoothManger *blue = nil;
   
    dispatch_once(&once, ^{
        
            blue = [[self alloc]init];
        
        
    });
    
    
    return blue;
    
}

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        
        
        //持有发现的设备
        _discoverPeripherals = [[NSMutableArray alloc]init];
        
        queue = dispatch_queue_create("ZZMangerQueue", NULL);
        
        _lightList = [NSMutableArray array];
        
        self.connectedList = [NSMutableArray array];
        
        macDic = [NSMutableDictionary dictionary];
        
        dataList = [NSMutableArray array];
    }
    
    return self;
}


/**
 *  开始扫描
 */
-(void)startScanWithBlock:(ScanResultBlock)block{
    
    _manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    self.scanResultBlock = [block copy];
}

/**
 *  连接
 */
-(void)startconnectWithPeripheral:(CBPeripheral *)peripheral block:(ConnectPeripheralResultBlock)resultBlock{
    
    [_manager connectPeripheral:peripheral
                        options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@(0)}];
    self.connectPeripheralResultBlock = [resultBlock copy];
}



- (void)retrieveConnectWithIdentifier:(NSString *)identifier  block:(RetrieveConnectResultBlock)resultBlock{
    
    retrieveidentifier = identifier;
    
    self.retrieveBlock = [resultBlock copy];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(retri) name:@"ZZRetrivePoweredOn" object:nil];
    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:retrieveidentifier];
    CBPeripheral *peripheral = [[_manager retrievePeripheralsWithIdentifiers:@[uuid]] firstObject];
    
    if (peripheral) {
    
        [_discoverPeripherals addObject:peripheral];
        
        [self startconnectWithPeripheral:peripheral block:^(BOOL isSuccess, NSError *error, DataModel *model) {
            
            if (resultBlock) {
                
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"ZZConnected" object:nil];
                resultBlock(isSuccess,model);
                
            }
        }];
    }
    
}
- (void)retri{
    
    NSUUID *uuid = [[NSUUID alloc]initWithUUIDString:retrieveidentifier];
    CBPeripheral *peripheral = [[_manager retrievePeripheralsWithIdentifiers:@[uuid]] firstObject];
    
    if (peripheral) {
        
        [_discoverPeripherals addObject:peripheral];
        
        [self startconnectWithPeripheral:peripheral block:^(BOOL isSuccess, NSError *error, DataModel *model) {
            
        }];
    }
}



/**
 *  取消连接
 */
-(void)cancelConnectWithPeripheral:(CBPeripheral *)peripheral{
    
    if (peripheral) {
        
        [_manager cancelPeripheralConnection:peripheral];

        
    }
   
}




#pragma mark CBCentralManagerDelegate

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    
    if (central.state == CBCentralManagerStatePoweredOn) {
        
        self.powerOn = YES;
        if (!(retrieveidentifier.length>0)) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ZZPoweredOn" object:nil];
            
            CBUUID *uuid = [CBUUID UUIDWithString:ServiceUUID];
            
            [_manager scanForPeripheralsWithServices:nil options:nil];
            
            double delayInSeconds = 10.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
         
                
                [_manager stopScan];
                
                
                
            });
            
        }
        else{
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ZZRetrivePoweredOn" object:nil];
            NSLog(@"post ZZRetrivePoweredOn");
        }
        
    }
    
}

//扫描到设备会进入方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{

    NSLog(@"didDiscoverPeripheral %@",peripheral.name);
    
    BOOL isexit = NO;
    
    if ([peripheral.name hasPrefix:@"N"]) {
        
        for (CBPeripheral *per in _discoverPeripherals) {
            
            if ([peripheral.identifier.UUIDString isEqualToString:per.identifier.UUIDString]) {
                
                isexit = YES;
            }
        }
        if (!isexit) {
            
            [_discoverPeripherals addObject:peripheral];
        }
        
        self.scanResultBlock(_discoverPeripherals);
        
    }
    

}
#pragma mark Peripheral


//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
   NSLog(@"连接到Peripherals-失败 %@",peripheral.name);
    if (self.connectPeripheralResultBlock) {
        
        self.connectPeripheralResultBlock(NO,error,nil);
        
    }
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
     NSLog(@"断开设备 %@",peripheral.name);
//
    if ([self.connectedList containsObject:peripheral]) {
        
        [self.connectedList removeObject:peripheral];
    }
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        [self startconnectWithPeripheral:peripheral block:^(BOOL isSuccess, NSError *error, DataModel *model) {
            
            if (isSuccess) {
                
                dispatch_source_cancel(timer);
            }
            
        }];
        
    });
    dispatch_resume(timer);
    
    
    
    
    
    
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"DidDlePeripheral" object:[peripheral.identifier UUIDString]];
    


}
//连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"连接 %@ 成功",peripheral.name);
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    
    [self.connectedList addObject:peripheral];

}


#pragma mark Services andCharacteristics

//扫描到Services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{

    if (error)
    {
            return;
    }
    
    if (self.retrieveBlock) {
        
        //                [[NSNotificationCenter defaultCenter]postNotificationName:@"ZZConnected" object:nil];
        
        
        DataModel *model = [[DataModel alloc]init];
        
        model.cbPeripheral = peripheral;
        self.retrieveBlock(YES,model);
        
    }

    for (CBService *service in peripheral.services) {
      
        NSLog(@"didDiscoverService %@",[service.UUID UUIDString]);
        if ([service.UUID.UUIDString isEqualToString:ServiceUUID]) {
            
             [peripheral discoverCharacteristics:nil forService:service];
        }
    }
    
}

//扫描到Characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{

   
    CBCharacteristic *char1;
    CBCharacteristic *char2;
    for (CBCharacteristic *characteristic in service.characteristics)
    
    {
       [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        
        if ([characteristic.UUID.UUIDString isEqualToString:CBCharacteristic1]) char1 = characteristic;
        if ([characteristic.UUID.UUIDString isEqualToString:CBCharacteristic2]) char2 = characteristic;
//        NSLog(@"didDiscoverCharacteristics %@",characteristic.UUID.UUIDString);

    }
    //写入时间
    [self writePeripheral:peripheral characteristic:char2 value:[self hexToBytesWith:@"0105"]];
    NSString *datestr = [[NSDate date]formatDateString:@"YYYYMMddHHmm"];
    NSString *str = [datestr substringFromIndex:2];
    [self writePeripheral:peripheral characteristic:char1 value:[self hexToBytesWith:str]];

    DataModel *model = [[DataModel alloc]init];
    model.cbPeripheral = peripheral;
    model.cbCharacteristc1 = char1;
    model.cbCharacteristc2 = char2;
    
    [_lightList addObject:model];
    if (self.connectPeripheralResultBlock) {
        
        self.connectPeripheralResultBlock(YES,nil,model);
        
    }
}




//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{

    NSString *dataStr = [NSString stringWithFormat:@"%@",characteristic.value];
    if (dataStr.length>5) {
        dataStr =[dataStr substringWithRange:NSMakeRange(1, dataStr.length-2)];
        NSArray *ary = [dataStr componentsSeparatedByString:@" "];
        if (ary.count ==5) {
            NSMutableArray *test = [NSMutableArray array];
            for (NSString *str in ary) {
                
                
                int i =0;
                
                while (i<=str.length-2) {
                    
                    NSString *temp = [str substringWithRange:NSMakeRange(i, 2)];
                    
                    i = i+2;
                    
                    [test addObject:temp];
                }
                
            }
            if (self.completeBlock) {
                self.completeBlock(test);
            }
        }
    }

}
-(NSData*) hexToBytesWith:(NSString *)str{
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
- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
#pragma mark wirte data

//写数据
-(void)writePeripheral:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{

    if(characteristic.properties & CBCharacteristicPropertyWrite){
        
        NSLog(@"writeValue ======%@",value);
        
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        
    }else{
        
    }

}

- (void)readvalue:(DataModel *)datamodel{
    
    [datamodel.cbPeripheral readValueForCharacteristic:datamodel.cbCharacteristc1];
}

@end
