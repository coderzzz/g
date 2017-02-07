//
//  UserModel.h
//  iwen
//
//  Created by Interest on 15/10/22.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * uid;
@property (nonatomic, strong) NSString <Optional> * age;
@property (nonatomic, strong) NSString <Optional> * nickname;

@property (nonatomic, strong) NSString <Optional> * realname;

@property (nonatomic, strong) NSString <Optional> * phone;

@property (nonatomic, strong) NSString <Optional> * avatar;

@property (nonatomic, strong) NSString <Optional> * email;

@property (nonatomic, strong) NSString <Optional> * sex;

@property (nonatomic, strong) NSString <Optional> * integral;

@property (nonatomic, strong) NSString <Optional> * child_lock_pwd;

@property (nonatomic, strong) NSString <Optional> * child_lock_time;

@property (nonatomic, strong) NSString <Optional> * cache_token;



@end
