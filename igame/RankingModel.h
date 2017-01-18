//
//  RankingModel.h
//  iwen
//
//  Created by Interest on 15/10/26.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "JSONModel.h"

@interface RankingModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * number_wins;
@property (nonatomic, strong) NSString <Optional> * nickname;
@property (nonatomic, strong) NSString <Optional> * avatar;
@end
