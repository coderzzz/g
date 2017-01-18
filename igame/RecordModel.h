//
//  RecordModel.h
//  igame
//
//  Created by Interest on 2017/1/13.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RecordModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;
@property (nonatomic, strong) NSString <Optional> * start_time;
@property (nonatomic, strong) NSString <Optional> * use_time;
@property (nonatomic, strong) NSString <Optional> * nickname;
@property (nonatomic, strong) NSString <Optional> * avatar;


@end
