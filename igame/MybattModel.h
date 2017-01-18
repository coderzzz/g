//
//  MybattModel.h
//  igame
//
//  Created by Interest on 2017/1/13.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MybattModel : JSONModel


@property (nonatomic, strong) NSString <Optional> * id;
@property (nonatomic, strong) NSString <Optional> * battle_thumb;
@property (nonatomic, strong) NSString <Optional> * battle_title;
@property (nonatomic, strong) NSString <Optional> * nickname;
@property (nonatomic, strong) NSString <Optional> * battle_id;

@end
