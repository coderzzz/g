//
//  ExamService.m
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "ExamService.h"
#import "RankingModel.h"
@implementation ExamService
{
    
    NSString *type;
}
- (id)init{
    
    self = [super init];
    
    if (self) {
        
        _wrPageIndex = 0;
        _wrrankArray = [NSMutableArray array];
        
        _mrPageIndex = 0;
        _mrrankArray = [NSMutableArray array];

        _arPageIndex = 0;
        _arrankArray = [NSMutableArray array];

        _battPageIndex = 0;
        _battArray = [NSMutableArray array];
        
        _newsPageIndex = 0;
        _news = [NSMutableArray array];
        
        _commentsPageIndex = 0;
        _comments = [NSMutableArray array];
        
        _recordPageIndex = 0;
        _records = [NSMutableArray array];
        
        
        _mgPageIndex = 0;
        _mgs = [NSMutableArray array];
        
        _mbPageIndex = 0;
        _mbs = [NSMutableArray array];
        
        _mblogPageIndex = 0;
        _mblogs = [NSMutableArray array];
        
    }
    
    return self;
}

+ (ExamService *)shareInstenced{
    
    static ExamService *this = nil;
    
    static dispatch_once_t onesToken;
    
    dispatch_once(&onesToken, ^{
        
        this = [[self alloc]init];
    });
    
    return this;

}

#pragma mark


- (void)getCourseType{
    
    [[HttpService sharedInstance]getCourseType:nil completionBlock:^(id objdct) {
    
        
        if (objdct) {
            
            NSMutableArray *ary = objdct;
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            for (NSDictionary *dic in ary) {
                
//                CourseTypeModel *model = [[CourseTypeModel alloc]initWithDictionary:dic error:nil];
//                
//                if (model) {
//                    
//                    [dataArray addObject:model];
//                }
            }
            
            if (_getCourseTypeSuccess) {
                
                _getCourseTypeSuccess(dataArray);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCourseTypeFailure) {
            
            _getCourseTypeFailure(responseString);
        }
        
    }];
    
}

- (void)getGradeTypeWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]getGradeType:@{@"uid":uid} completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            
            if (_getGradeTypeSuccess) {
                
                _getGradeTypeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getGradeTypeFailure) {
            
            _getGradeTypeFailure(responseString);
        }
        
    }];
    
}

- (void)getPayInfoWithUid:(NSString *)uid grade_id:(NSString *)grade_id fee:(NSString *)fee coupon_id:(NSString *)coupon_id{
    
    NSDictionary *dic = @{@"grade_id":grade_id,@"uid":uid,@"total_fee":fee,@"coupon_id":coupon_id};
    
    [[HttpService sharedInstance]getPayInfo:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSDictionary *dic = objdct;
            
//            ExamGradeModel *model = [[ExamGradeModel alloc]initWithDictionary:dic error:nil];
//            
//            if (model) {
//                
//                
//                if (_getPayInfoSuccess) {
//                    
//                    _getPayInfoSuccess(model);
//                }
//                
//            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getPayInfoFailure) {
            
            _getPayInfoFailure(responseString);
        }
        
    }];

}

- (void)getWxPayInfoWithUid:(NSString *)uid grade_id:(NSString *)grade_id fee:(NSString *)fee coupon_id:(NSString *)coupon_id{
    
    NSDictionary *dic = @{@"grade_id":grade_id,@"uid":uid,@"total_fee":fee,@"coupon_id":coupon_id};
    
    [[HttpService sharedInstance]getWxPayInfo:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSDictionary *dic = objdct;
            
            
            if (_getWxPayInfoSuccess) {
                
                _getWxPayInfoSuccess(dic);
            }
                
         
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getWxPayInfoFailure) {
            
            _getWxPayInfoFailure(responseString);
        }
        
    }];
    
}

- (void)getChapterPracticeWithTypeId:(NSString *)typeId uid:(NSString *)uid{
    
    NSDictionary *dic = @{@"post_title":typeId,@"uid":uid};
    
    [[HttpService sharedInstance]getChapterPractice:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            if (_getChapterPracticeSuccess) {
                
                _getChapterPracticeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getChapterPracticeFailure) {
            
            _getChapterPracticeFailure(responseString);
        }
        
    }];
 
}

- (void)getPracticeWithTypeId:(NSString *)typeId uid:(NSString *)uid{
    
    NSDictionary *dic = @{@"age":typeId,@"uid":uid};
    
    [[HttpService sharedInstance]getPractice:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            if (_getPracticeSuccess) {
                
                _getPracticeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getPracticeFailure) {
            
            _getPracticeFailure(responseString);
        }
        
    }];
}

- (void)getGetExamGradeWithType:(NSString *)type uid:(NSString *)uid{
    
    NSDictionary *dic = @{@"type":type,@"uid":uid};
    
    [[HttpService sharedInstance]getExamGrade:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSDictionary *dic = objdct;

//            ExamGradeModel *model = [[ExamGradeModel alloc]initWithDictionary:dic error:nil];
//            
//            if (model) {
//                
//                
//                if (_getExamGradeSuccess) {
//                    
//                    _getExamGradeSuccess(model);
//                }
//              
//            }

        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getExamGradeFailure) {
            
            _getExamGradeFailure(responseString);
        }
        
    }];
    
}

- (void)getAllowExamWithdic:(NSDictionary *)dic{
    

    [[HttpService sharedInstance]getAllowExam:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
           
            if (_getAllowExamSuccess) {
                
                _getAllowExamSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getAllowExamFailure) {
            
            _getAllowExamFailure(responseString);
        }
        
    }];
    
}

- (void)getExamWithUid:(NSString *)uid type:(NSString *)type{
    
    NSDictionary *dic = @{@"uid":uid,@"type":type};
    
    [[HttpService sharedInstance]getExam:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSMutableArray *ary = objdct[@"title"];
            
            NSString      *examId = objdct[@"exam_id"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
//            for (NSDictionary *dic in ary) {
//                
//                ChapterPracticeModel *model = [[ChapterPracticeModel alloc]initWithDictionary:dic error:nil];
//                
//                if (model) {
//                    
//                    model.examId = examId;
//                    [dataArray addObject:model];
//                }
//            }
            
            if (_getExamSuccess) {
                
                _getExamSuccess(dataArray);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getExamFailure) {
            
            _getExamFailure(responseString);
        }
        
    }];
    
}

- (void)getMnExamWithUid:(NSString *)uid type:(NSString *)type{
    
    NSDictionary *dic = @{@"uid":uid,@"type":type};
    
    [[HttpService sharedInstance]getMnExam:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            NSMutableArray *ary = objdct[@"title"];
            
            NSString      *examId = objdct[@"exam_id"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
//            for (NSDictionary *dic in ary) {
//                
//                ChapterPracticeModel *model = [[ChapterPracticeModel alloc]initWithDictionary:dic error:nil];
//                
//                if (model) {
//                    
//                    model.examId = examId;
//                    [dataArray addObject:model];
//                }
//            }
            
            if (_getMnExamSuccess) {
                
                _getMnExamSuccess(dataArray);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getMnExamFailure) {
            
            _getMnExamFailure(responseString);
        }
        
    }];
    
    
}

- (void)getExamLikeWithUid:(NSString *)uid cid:(NSString *)cid{
    
    NSDictionary *dic = @{@"uid":uid,@"news_id":cid};
    
    [[HttpService sharedInstance]getLike:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            if (_getExamLikeSuccess) {
                
                _getExamLikeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getExamLikeFailure) {
            
            _getExamLikeFailure(responseString);
        }
        
    }];
    
    
}

- (void)savePracticeWithJsonString:(NSString *)jsonStr time:(NSString *)time{
    
    NSDictionary *dic = @{@"uid":jsonStr,@"sex":time};
    
    [[HttpService sharedInstance]savePra:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
           
            if (_savePracticeSuccess) {
                
                _savePracticeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_savePracticeFailure) {
            
            _savePracticeFailure(responseString);
        }
        
    }];
    
}



- (void)upLoadGameWithdic:(NSDictionary *)dic{
    
     [[HttpService sharedInstance]upAnswer:dic completionBlock:^(id objdct) {

        if (_upLoadExamSuccess) {
            
            
            _upLoadExamSuccess(dic);
        }

    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_upLoadExamFailure) {
            
            _upLoadExamFailure(responseString);
        }
        
    }];

}

- (void)upLoadMnExamWithdic:(NSDictionary *)dic{
    

    [[HttpService sharedInstance]upMnAnswer:dic completionBlock:^(id objdct) {
        if (objdct) {
            

                
                if (_upLoadMnExamSuccess) {
                    
                    
                    _upLoadMnExamSuccess(objdct);
                }

            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_upLoadMnExamFailure) {
            
            _upLoadMnExamFailure(responseString);
        }
        
    }];

    
}

- (void)getTitleType{
    
    [[HttpService sharedInstance]titleType:nil completionBlock:^(id objdct) {
        if (objdct) {
            
            NSArray *ary = objdct;
            
            if (_getTitleTypeSuccess) {
                
                _getTitleTypeSuccess(ary);
                
            }

        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getTitleTypeFailure) {
            
            _getTitleTypeFailure(responseString);
        }
        
    }];
    
}


- (void)cancleExamWithUid:(NSString *)uid examId:(NSString *)examId{
    
    
    NSDictionary *dic = @{@"uid":uid,@"password":examId};
    
    [[HttpService sharedInstance]cancleExam:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            if (_cancelExamSuccess) {
                
                _cancelExamSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_cancelExamFailure) {
            
            _cancelExamFailure(responseString);
        }
        
    }];
    

}

- (void)openLockWithDic:(NSDictionary *)dic{
    
    
    [[HttpService sharedInstance]getExamRecord:dic completionBlock:^(id objdct) {
    
        if (_getExamRecordSuccess) {
            
            _getExamRecordSuccess(objdct);
        }

        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getExamRecordFailure) {
            
            _getExamRecordFailure(responseString);
        }
        
    }];
}

- (void)setTimeWithDic:(NSDictionary *)dic{
    
    [[HttpService sharedInstance]getParRecord:dic completionBlock:^(id objdct) {
        
        if (_getPraRecordSuccess) {
            
            _getPraRecordSuccess(objdct);
        }
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getPraRecordFailure) {
            
            _getPraRecordFailure(responseString);
        }
        
    }];
    
}

- (void)addExamLikeWithUid:(NSString *)uid tid:(NSString *)tid{
    

    NSDictionary *dic = @{@"uid":uid,@"battle_id":tid};
    
    [[HttpService sharedInstance]getExamLike:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            if (_addExamLikeSuccess) {
                
                _addExamLikeSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_addExamLikeFailure) {
            
            _addExamLikeFailure(responseString);
        }
        
    }];
}

- (void)getAllLikeWithUid:(NSString *)uid battle_id:(NSString *)battle_id{
    
    NSDictionary *dic = @{@"uid":uid,@"battle_id":battle_id};
    
    [[HttpService sharedInstance]getAllLike:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            
            NSDictionary *dic = (NSDictionary *)objdct;
            NSMutableArray *ary = dic[@"sign"];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            SignModel *bat = [[SignModel alloc]initWithDictionary:dic[@"battle"] error:nil];
            bat.state = [NSString stringWithFormat:@"%@",dic[@"is_sign"]];
            for (NSDictionary *temp in ary) {
                
                UserModel *model = [[UserModel alloc]initWithDictionary:temp error:nil];
                
                if (model) {
                    
                    [dataArray addObject:model];
                }
            }
            bat.signs = [NSMutableArray array];
            [bat.signs addObjectsFromArray:dataArray];
            
            
            
            if (_getAllLikeSuccess) {
                
                _getAllLikeSuccess(bat);
            }
            
        }

        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getAllLikeFailure) {
            
            _getAllLikeFailure(responseString);
        }
        
    }];
}

- (void)getErrorTitleWithUid:(NSString *)uid tid:(NSString *)tid{
    
    NSDictionary *dic = @{@"uid":uid,@"nickname":tid};
    
    [[HttpService sharedInstance]getErrorTitle:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {

            if (_getErrorTitleSuccess) {
                
                _getErrorTitleSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getErrorTitleFailure) {
            
            _getErrorTitleFailure(responseString);
        }
        
    }];

}

- (void)delErrorTitleWithUid:(NSString *)uid tid:(NSString *)tid{
    
    NSDictionary *dic = @{@"uid":uid,@"avatar":tid};
    
    [[HttpService sharedInstance]delErrorTitle:dic completionBlock:^(id objdct) {
        
        
        if (objdct) {
            
            
            if (_delErrorSuccess) {
                
                _delErrorSuccess(objdct);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_delErrorFailure) {
            
            _delErrorFailure(responseString);
        }
        
    }];
    
}

- (void)getFirstRankingWithUid:(NSString *)uid timeType:(NSString *)timeType{

//    ,@"page":index
    [[HttpService sharedInstance]getRanking:@{@"uid":uid,@"offset":@"0",@"type":timeType} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                RankingModel *model = [[RankingModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            
         
                
            if ([timeType isEqualToString:@"1"]) {
                
                _wrPageIndex = 0;
                _wrrankArray = [NSMutableArray array];
               
                 [_wrrankArray addObjectsFromArray:data];
                
                if (_getRankingSuccess) _getRankingSuccess (_wrrankArray,timeType);
            }
            else if ([timeType isEqualToString:@"2"]){

                _mrPageIndex = 0;
                _mrrankArray = [NSMutableArray array];
                
                [_mrrankArray addObjectsFromArray:data];
                
                if (_getRankingSuccess) _getRankingSuccess (_mrrankArray,timeType);

            }
            else{
                
                _arPageIndex = 0;
                _arrankArray = [NSMutableArray array];
                
                [_arrankArray addObjectsFromArray:data];
                
                if (_getRankingSuccess) _getRankingSuccess (_arrankArray,timeType);
            }

       }
            
       
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getRankingFailure) {
            
            _getRankingFailure(responseString,timeType);
        }
        
    }];
}

- (void)getMoreRankingWithUid:(NSString *)uid timeType:(NSString *)timeType{
    
    NSString *index;
    if ([timeType isEqualToString:@"1"]) {
        
         index = [NSString stringWithFormat:@"%ld",_wrPageIndex +10];

    }
    else if ([timeType isEqualToString:@"2"]){
        
         index = [NSString stringWithFormat:@"%ld",_mrPageIndex +10];
    }
    else{
        
         index = [NSString stringWithFormat:@"%ld",_arPageIndex +10];
    }

    [[HttpService sharedInstance]getRanking:@{@"uid":uid,@"offset":index,@"type":timeType} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                 RankingModel *model = [[RankingModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            

                
            if ([timeType isEqualToString:@"1"]) {
                
                _wrPageIndex =10 +_wrPageIndex;
                [_wrrankArray addObjectsFromArray:data];
                
                if (_getRankingSuccess) _getRankingSuccess (_wrrankArray,timeType);
            }
            else if ([timeType isEqualToString:@"2"]){
                
                _mrPageIndex = 10 + _mrPageIndex;
                [_mrrankArray addObjectsFromArray:data];
                
                if (_getRankingSuccess) _getRankingSuccess (_mrrankArray,timeType);
                
            }
            else{
                
                _arPageIndex =10 + _arPageIndex;
                [_arrankArray addObjectsFromArray:data];
                
                if (_getRankingSuccess) _getRankingSuccess (_arrankArray,timeType);
            }
            
        }
            
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getRankingFailure) {
            
            _getRankingFailure(responseString,timeType);
        }
        
    }];
    
}

- (void)getFirstbattleWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]getCircleList:@{@"uid":uid,@"offset":@"0"} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                BattleModel *model = [[BattleModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }

            _battPageIndex = 0;
        
            _battArray = [NSMutableArray array];
            
            [_battArray addObjectsFromArray:data];
            
            if (_getbattleSuccess) _getbattleSuccess (_battArray);
               

        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getbattleFailure) {
            
            _getbattleFailure(responseString);
        }
        
    }];
}

- (void)getMorebattleWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]getCircleList:@{@"uid":uid,@"offset":[NSString stringWithFormat:@"%ld",_battPageIndex +10]} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                BattleModel *model = [[BattleModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            _battPageIndex = 10 +_battPageIndex;
            [_battArray addObjectsFromArray:data];
            
            if (_getbattleSuccess) _getbattleSuccess (_battArray);
        }
        
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getbattleFailure) {
            
            _getbattleFailure(responseString);
        }
        
    }];
}

- (void)getFirstnewWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]addNews:@{@"uid":uid,@"offset":@"0"} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                NewsModel *model = [[NewsModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            
            _newsPageIndex = 0;
            
            _news = [NSMutableArray array];
            
            [_news addObjectsFromArray:data];
            
            if (_getnewsSuccess) _getnewsSuccess (_news);
            
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getnewsFailure) {
            
            _getnewsFailure(responseString);
        }
        
    }];
}

- (void)getMorenewWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]addNews:@{@"uid":uid,@"offset":[NSString stringWithFormat:@"%ld",_newsPageIndex +10]} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                NewsModel *model = [[NewsModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            _newsPageIndex =10 + _newsPageIndex;
            [_news addObjectsFromArray:data];
            
            if (_getnewsSuccess) _getnewsSuccess (_news);
        }
        
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getnewsFailure) {
            
            _getnewsFailure(responseString);
        }
        
    }];
    
}


- (void)getFirstmgWithUid:(NSString *)uid{
    
    
    [[HttpService sharedInstance]getForum:@{@"uid":uid,@"offset":@"0"} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                MybattModel *model = [[MybattModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            
            _mgPageIndex = 0;
            
            _mgs = [NSMutableArray array];
            
            [_mgs addObjectsFromArray:data];
            
            if (_getmgSuccess) _getmgSuccess (_mgs);
            
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getmgFailure) {
            
            _getmgFailure(responseString);
        }
        
    }];
}

- (void)getMoremgWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]getForum:@{@"uid":uid,@"offset":[NSString stringWithFormat:@"%ld",_mgPageIndex +10]} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                MybattModel *model = [[MybattModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            _mgPageIndex =10 + _mgPageIndex;
            [_mgs addObjectsFromArray:data];
            
            if (_getmgSuccess) _getmgSuccess (_mgs);
        }
        
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getmgFailure) {
            
            _getmgFailure(responseString);
        }
        
    }];

}

- (void)getFirstmbWithUid:(NSString *)uid{
    
    
    [[HttpService sharedInstance]getCoure:@{@"uid":uid,@"offset":@"0"} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                MybattModel *model = [[MybattModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            
            _mbPageIndex = 0;
            
            _mbs = [NSMutableArray array];
            
            [_mbs addObjectsFromArray:data];
            
            if (_getmbSuccess) _getmbSuccess (_mbs);
            
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getmbFailure) {
            
            _getmbFailure(responseString);
        }
        
    }];
}

- (void)getMorembWithUid:(NSString *)uid{
    [[HttpService sharedInstance]getCoure:@{@"uid":uid,@"offset":[NSString stringWithFormat:@"%ld",_mbPageIndex +10]} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                MybattModel *model = [[MybattModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            _mbPageIndex =10 + _mbPageIndex;
            [_mbs addObjectsFromArray:data];
            
            if (_getmbSuccess) _getmbSuccess (_mbs);
        }
        
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getmbFailure) {
            
            _getmbFailure(responseString);
        }
        
    }];

}

- (void)getFirstmblogWithUid:(NSString *)uid{
    
    
    [[HttpService sharedInstance]commonNewsDetail:@{@"uid":uid,@"offset":@"0"} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                NewsModel *model = [[NewsModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            
            _mblogPageIndex = 0;
            
            _mblogs = [NSMutableArray array];
            
            [_mblogs addObjectsFromArray:data];
            
            if (_getmblogSuccess) _getmblogSuccess (_mblogs);
            
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getnewsFailure) {
            
            _getnewsFailure(responseString);
        }
        
    }];
}

- (void)getMoremblogWithUid:(NSString *)uid{
    [[HttpService sharedInstance]commonNewsDetail:@{@"uid":uid,@"offset":[NSString stringWithFormat:@"%ld",_mblogPageIndex +10]} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                NewsModel *model = [[NewsModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            _mblogPageIndex =10 + _mblogPageIndex;
            [_mblogs addObjectsFromArray:data];
            
            if (_getmblogSuccess) _getmblogSuccess (_mblogs);
        }
        
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getmblogFailure) {
            
            _getmblogFailure(responseString);
        }
        
    }];

}


- (void)getFirstrecWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]delcomment:@{@"uid":uid,@"offset":@"0"} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                RecordModel *model = [[RecordModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            
            _recordPageIndex= 0;
            
            _records = [NSMutableArray array];
            
            [_records addObjectsFromArray:data];
            
            if (_getRecordSuccess) _getRecordSuccess (_records);
            
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getRecordFailure) {
            
            _getRecordFailure(responseString);
        }
        
    }];
    
}

- (void)getMorerecWithUid:(NSString *)uid{
    
    [[HttpService sharedInstance]delcomment:@{@"uid":uid,@"offset":[NSString stringWithFormat:@"%ld",_recordPageIndex +10]} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                RecordModel *model = [[RecordModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            _recordPageIndex =10 + _recordPageIndex;
            [_records addObjectsFromArray:data];
            
            if (_getRecordSuccess) _getRecordSuccess (_records);
        }
        
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getRecordFailure) {
            
            _getRecordFailure(responseString);
        }
        
    }];
}

- (void)getFirstcomWithUid:(NSString *)uid newsid:(NSString *)newid{
    
    
    [[HttpService sharedInstance]comments:@{@"uid":uid,@"news_id":newid,@"offset":@"0"} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                CommentModel *model = [[CommentModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            
            _commentsPageIndex = 0;
            
            _comments = [NSMutableArray array];
            
            [_comments addObjectsFromArray:data];
            
            if (_getCommentsSuccess) _getCommentsSuccess (_comments);
            
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCommentsFailure) {
            
            _getCommentsFailure(responseString);
        }
        
    }];
}

- (void)getMorecomWithUid:(NSString *)uid newsid:(NSString *)newid{
    
    [[HttpService sharedInstance]comments:@{@"uid":uid,@"news_id":newid,@"offset":[NSString stringWithFormat:@"%ld",_commentsPageIndex +10]} completionBlock:^(id objdct) {
        
        if (objdct) {
            
            NSArray *temp = objdct;
            NSMutableArray *data = [NSMutableArray array];
            for (NSDictionary *dic in temp) {
                
                CommentModel *model = [[CommentModel alloc]initWithDictionary:dic error:nil];
                if (model) {
                    
                    [data addObject:model];
                }
            }
            _commentsPageIndex =10 + _commentsPageIndex;
            [_comments addObjectsFromArray:data];
            
            if (_getCommentsSuccess) _getCommentsSuccess (_comments);
        }
        
        
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCommentsFailure) {
            
            _getCommentsFailure(responseString);
        }
        
    }];
}


@end
