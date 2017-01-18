//
//  SignModel.h
//  igame
//
//  Created by Interest on 2017/1/9.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SignModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;
@property (nonatomic, strong) NSString <Optional> * battle_thumb;
@property (nonatomic, strong) NSString <Optional> * battle_title;
@property (nonatomic, strong) NSString <Optional> * add_time;
@property (nonatomic, strong) NSString <Optional> * number_applicants;
@property (nonatomic, strong) NSString <Optional> * mid;
@property (nonatomic, strong) NSMutableArray <Optional> * signs;

@end
