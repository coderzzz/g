//
//  DataModel.h
//  ibulb
//
//  Created by Interest on 16/1/20.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface DataModel : NSObject

@property (strong,nonatomic) CBPeripheral *cbPeripheral;
@property (strong,nonatomic) CBCharacteristic *cbCharacteristc1;
@property (strong,nonatomic) CBCharacteristic *cbCharacteristc2;
@property (copy, nonatomic)  NSString *realName;
@property (copy, nonatomic)  NSString *uuid;

@end
