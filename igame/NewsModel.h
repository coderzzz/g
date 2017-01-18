//
//  NewsModel.h
//  igame
//
//  Created by Interest on 2017/1/9.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewsModel : JSONModel

@property (nonatomic, strong) NSString <Optional> * id;
@property (nonatomic, strong) NSString <Optional> * news_title;
@property (nonatomic, strong) NSString <Optional> * news_thumb;
@property (nonatomic, strong) NSString <Optional> * content;
@property (nonatomic, strong) NSString <Optional> * add_time;
@property (nonatomic, strong) NSString <Optional> * read_times;
@property (nonatomic, strong) NSString <Optional> * nickname;
@property (nonatomic, strong) NSString <Optional> * news_typ;

@property (nonatomic, strong) NSString <Optional> * comment_count;
@end
