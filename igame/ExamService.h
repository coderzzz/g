//
//  ExamService.h
//  iwen
//
//  Created by Interest on 15/10/23.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GetCourseTypeSuccess) (id obj);
typedef void (^GetCourseTypeFailure) (id obj);

typedef void (^GetGradeTypeSuccess) (id obj);
typedef void (^GetGradeTypeFailure) (id obj);

typedef void (^GetPayInfoSuccess) (id obj);
typedef void (^GetPayInfoFailure) (id obj);

typedef void (^GetWxPayInfoSuccess) (id obj);
typedef void (^GetWxPayInfoFailure) (id obj);

typedef void (^GetChapterPracticeSuccess) (id obj);
typedef void (^GetChapterPracticeFailure) (id obj);

typedef void (^GetPracticeSuccess) (id obj);
typedef void (^GetPracticeFailure) (id obj);

typedef void (^GetExamGradeSuccess) (id obj);
typedef void (^GetExamGradeFailure) (id obj);

typedef void (^GetAllowExamSuccess) (id obj);
typedef void (^GetAllowExamFailure) (id obj);

typedef void (^GetExamSuccess) (id obj);
typedef void (^GetExamFailure) (id obj);

typedef void (^GetMnExamSuccess) (id obj);
typedef void (^GetMnExamFailure) (id obj);

typedef void (^SavePracticeSuccess) (id obj);
typedef void (^SavePracticeFailure) (id obj);

typedef void (^UpLoadExamSuccess) (id obj);
typedef void (^UpLoadExamFailure) (id obj);

typedef void (^UpLoadMnExamSuccess) (id obj);
typedef void (^UpLoadMnExamFailure) (id obj);

typedef void (^GetTitleTypeSuccess) (id obj);
typedef void (^GetTitleTypeFailure) (id obj);


typedef void (^CancelExamSuccess) (id obj);
typedef void (^CancelExamFailure) (id obj);


typedef void (^GetExamRecordSuccess) (id obj);
typedef void (^GetExamRecordFailure) (id obj);

typedef void (^GetPraRecordSuccess) (id obj);
typedef void (^GetPraRecordFailure) (id obj);




typedef void (^AddExamLikeSuccess) (id obj);
typedef void (^AddExamLikeFailure) (id obj);

typedef void (^GetAllLikeSuccess) (id obj);
typedef void (^GetAllLikeFailure) (id obj);

typedef void (^GetExamLikeSuccess) (id obj);
typedef void (^GetExamLikeFailure) (id obj);


typedef void (^DelErrorSuccess) (id obj);
typedef void (^DelErrorFailure) (id obj);

typedef void (^GetErrorTitleSuccess) (id obj);
typedef void (^GetErrorTitleFailure) (id obj);


typedef void (^GetRankingSuccess) (id obj,NSString *type);
typedef void (^GetRankingFailure) (id obj,NSString *type);


typedef void (^GetbattleSuccess) (id obj);
typedef void (^GetbattleFailure) (id obj);

typedef void (^GetnewsSuccess) (id obj);
typedef void (^GetnewsFailure) (id obj);


typedef void (^GetCommentsSuccess) (id obj);
typedef void (^GetCommentsFailure) (id obj);

typedef void (^GetRecordSuccess) (id obj);
typedef void (^GetRecordFailure) (id obj);


typedef void (^GetmgSuccess) (id obj);
typedef void (^GetmgFailure) (id obj);


typedef void (^GetmbSuccess) (id obj);
typedef void (^GetmbFailure) (id obj);

typedef void (^GetmblogSuccess) (id obj);
typedef void (^GetmblogFailure) (id obj);










@interface ExamService : NSObject

@property (nonatomic, copy) GetCourseTypeSuccess getCourseTypeSuccess;
@property (nonatomic, copy) GetCourseTypeFailure getCourseTypeFailure;

@property (nonatomic, copy) GetGradeTypeSuccess getGradeTypeSuccess;
@property (nonatomic, copy) GetGradeTypeFailure getGradeTypeFailure;

@property (nonatomic, copy) GetPayInfoSuccess getPayInfoSuccess;
@property (nonatomic, copy) GetPayInfoFailure getPayInfoFailure;

@property (nonatomic, copy) GetWxPayInfoSuccess getWxPayInfoSuccess;
@property (nonatomic, copy) GetWxPayInfoFailure getWxPayInfoFailure;

@property (nonatomic, copy) GetChapterPracticeSuccess getChapterPracticeSuccess;
@property (nonatomic, copy) GetChapterPracticeFailure getChapterPracticeFailure;

@property (nonatomic, copy) GetPracticeSuccess getPracticeSuccess;
@property (nonatomic, copy) GetPracticeFailure getPracticeFailure;

@property (nonatomic, copy) GetExamGradeSuccess getExamGradeSuccess;
@property (nonatomic, copy) GetExamGradeFailure getExamGradeFailure;

@property (nonatomic, copy) GetAllowExamSuccess getAllowExamSuccess;
@property (nonatomic, copy) GetAllowExamFailure getAllowExamFailure;

@property (nonatomic, copy) GetExamSuccess getExamSuccess;
@property (nonatomic, copy) GetExamFailure getExamFailure;

@property (nonatomic, copy) GetMnExamSuccess getMnExamSuccess;
@property (nonatomic, copy) GetMnExamFailure getMnExamFailure;

@property (nonatomic, copy) SavePracticeSuccess savePracticeSuccess;
@property (nonatomic, copy) SavePracticeFailure savePracticeFailure;

@property (nonatomic, copy) UpLoadExamSuccess upLoadExamSuccess;
@property (nonatomic, copy) UpLoadExamFailure upLoadExamFailure;

@property (nonatomic, copy) UpLoadMnExamSuccess upLoadMnExamSuccess;
@property (nonatomic, copy) UpLoadMnExamFailure upLoadMnExamFailure;

@property (nonatomic, copy) GetTitleTypeSuccess getTitleTypeSuccess;
@property (nonatomic, copy) GetTitleTypeFailure getTitleTypeFailure;

@property (nonatomic, copy) CancelExamSuccess cancelExamSuccess;
@property (nonatomic, copy) CancelExamFailure cancelExamFailure;

@property (nonatomic, copy) GetExamRecordSuccess getExamRecordSuccess;
@property (nonatomic, copy) GetExamRecordFailure getExamRecordFailure;


@property (nonatomic, copy) GetPraRecordSuccess getPraRecordSuccess;
@property (nonatomic, copy) GetPraRecordFailure getPraRecordFailure;


@property (nonatomic, copy) AddExamLikeSuccess addExamLikeSuccess;
@property (nonatomic, copy) AddExamLikeFailure addExamLikeFailure;

@property (nonatomic, copy) GetAllLikeSuccess getAllLikeSuccess;
@property (nonatomic, copy) GetAllLikeFailure getAllLikeFailure;


@property (nonatomic, copy) GetExamLikeSuccess getExamLikeSuccess;
@property (nonatomic, copy) GetExamLikeFailure getExamLikeFailure;

@property (nonatomic, copy) GetErrorTitleSuccess getErrorTitleSuccess;
@property (nonatomic, copy) GetErrorTitleFailure getErrorTitleFailure;

@property (nonatomic, copy) GetRankingSuccess getRankingSuccess;
@property (nonatomic, copy) GetRankingFailure getRankingFailure;

@property (nonatomic, assign) NSInteger      wrPageIndex;
@property (nonatomic, strong) NSMutableArray *wrrankArray;
@property (nonatomic, assign) NSInteger      mrPageIndex;
@property (nonatomic, strong) NSMutableArray *mrrankArray;
@property (nonatomic, assign) NSInteger      arPageIndex;
@property (nonatomic, strong) NSMutableArray *arrankArray;

@property (nonatomic, copy) GetbattleSuccess getbattleSuccess;
@property (nonatomic, copy) GetbattleFailure getbattleFailure;

@property (nonatomic, assign) NSInteger      battPageIndex;
@property (nonatomic, strong) NSMutableArray *battArray;

@property (nonatomic, copy) GetnewsSuccess getnewsSuccess;
@property (nonatomic, copy) GetnewsFailure getnewsFailure;

@property (nonatomic, assign) NSInteger      newsPageIndex;
@property (nonatomic, strong) NSMutableArray *news;
//typedef void (^GetCommentsSuccess) (id obj);
//typedef void (^GetCommentsFailure) (id obj);




@property (nonatomic, copy) GetCommentsSuccess getCommentsSuccess;
@property (nonatomic, copy) GetCommentsFailure getCommentsFailure;

@property (nonatomic, assign) NSInteger      commentsPageIndex;
@property (nonatomic, strong) NSMutableArray *comments;


@property (nonatomic, copy) GetRecordSuccess getRecordSuccess;
@property (nonatomic, copy) GetRecordFailure getRecordFailure;

@property (nonatomic, assign) NSInteger      recordPageIndex;
@property (nonatomic, strong) NSMutableArray *records;









@property (nonatomic, copy) GetmgSuccess getmgSuccess;
@property (nonatomic, copy) GetmgFailure getmgFailure;

@property (nonatomic, assign) NSInteger      mgPageIndex;
@property (nonatomic, strong) NSMutableArray *mgs;


@property (nonatomic, copy) GetmbSuccess getmbSuccess;
@property (nonatomic, copy) GetmbFailure getmbFailure;

@property (nonatomic, assign) NSInteger      mbPageIndex;
@property (nonatomic, strong) NSMutableArray *mbs;


@property (nonatomic, copy) GetmblogSuccess getmblogSuccess;
@property (nonatomic, copy) GetmblogFailure getmblogFailure;

@property (nonatomic, assign) NSInteger      mblogPageIndex;
@property (nonatomic, strong) NSMutableArray *mblogs;




@property (nonatomic, copy) DelErrorSuccess delErrorSuccess;
@property (nonatomic, copy) DelErrorFailure delErrorFailure;

+ (ExamService *)shareInstenced;


- (void)getCourseType;

- (void)getGradeTypeWithUid:(NSString *)uid;

- (void)getPayInfoWithUid:(NSString *)uid grade_id:(NSString *)grade_id fee:(NSString *)fee coupon_id:(NSString *)coupon_id;

- (void)getWxPayInfoWithUid:(NSString *)uid grade_id:(NSString *)grade_id fee:(NSString *)fee coupon_id:(NSString *)coupon_id;




- (void)getPracticeWithTypeId:(NSString *)typeId uid:(NSString *)uid;

- (void)getGetExamGradeWithType:(NSString *)type uid:(NSString *)uid;

- (void)getAllowExamWithdic:(NSDictionary *)dic;

- (void)getExamWithUid:(NSString *)uid type:(NSString *)type;

- (void)getMnExamWithUid:(NSString *)uid type:(NSString *)type;

- (void)getExamLikeWithUid:(NSString *)uid cid:(NSString *)cid;



- (void)upLoadMnExamWithExamId:(NSString *)string topic_answer:(NSString *)answers time:(NSString *)time grade:(NSString *)grade;

- (void)upLoadGameWithdic:(NSDictionary *)dic;

- (void)getTitleType;






- (void)getChapterPracticeWithTypeId:(NSString *)typeId uid:(NSString *)uid;

- (void)savePracticeWithJsonString:(NSString *)jsonStr time:(NSString *)time;
- (void)getErrorTitleWithUid:(NSString *)uid tid:(NSString *)tid;
- (void)delErrorTitleWithUid:(NSString *)uid tid:(NSString *)tid;
- (void)cancleExamWithUid:(NSString *)uid examId:(NSString *)examId;
- (void)openLockWithDic:(NSDictionary *)dic;
- (void)setTimeWithDic:(NSDictionary *)dic;
- (void)addExamLikeWithUid:(NSString *)uid tid:(NSString *)tid;
- (void)getAllLikeWithUid:(NSString *)uid battle_id:(NSString *)battle_id;
- (void)upLoadMnExamWithdic:(NSDictionary *)dic;



- (void)getFirstRankingWithUid:(NSString *)uid timeType:(NSString *)timeType;

- (void)getMoreRankingWithUid:(NSString *)uid timeType:(NSString *)timeType;


- (void)getFirstbattleWithUid:(NSString *)uid;

- (void)getMorebattleWithUid:(NSString *)uid;








- (void)getFirstnewWithUid:(NSString *)uid;

- (void)getMorenewWithUid:(NSString *)uid;



- (void)getFirstmgWithUid:(NSString *)uid;

- (void)getMoremgWithUid:(NSString *)uid;

- (void)getFirstmbWithUid:(NSString *)uid;

- (void)getMorembWithUid:(NSString *)uid;

- (void)getFirstmblogWithUid:(NSString *)uid;

- (void)getMoremblogWithUid:(NSString *)uid;






- (void)getFirstrecWithUid:(NSString *)uid;

- (void)getMorerecWithUid:(NSString *)uid;



- (void)getFirstcomWithUid:(NSString *)uid newsid:(NSString *)newid;

- (void)getMorecomWithUid:(NSString *)uid newsid:(NSString *)newid;

@end
