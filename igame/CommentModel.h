//
//  CommentModel.h
//  igame
//
//  Created by Interest on 2017/1/12.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CommentModel : JSONModel
@property (nonatomic, strong) NSString <Optional> * avatar;
@property (nonatomic, strong) NSString <Optional> * add_time;
@property (nonatomic, strong) NSString <Optional> * comment;
@property (nonatomic, strong) NSString <Optional> * nickname;


@end
