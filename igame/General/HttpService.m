//
//  HttpService.m
//  iStudy
//
//  Created by GZInterest on 14/11/22.
//  Copyright (c) 2014年 helloworld. All rights reserved.
//

#import "HttpService.h"
#import <objc/runtime.h>

@implementation HttpService

#pragma mark Life Cycle
- (id)init
{
    if ((self = [super init])) {
        
    }
    return  self;
}

#pragma mark Class Method
+ (HttpService *)sharedInstance
{
    static HttpService * this = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        this = [[self alloc] init];
    });
    return this;
}



#pragma mark Private Methods


- (BOOL)filterError:(NSDictionary *)obj failureBlock:(void (^)(NSError *, NSString *))failure
{
    if(obj == nil)
    {
        if(failure) failure(nil,@"未知错误");
        return YES;
    }
    
    if(![obj isKindOfClass:[NSDictionary class]])
    {
        if(failure) failure(nil,@"未知错误");
        return YES;
    }
    
    if(obj[@"err_code"] == nil)
    {
        if(failure) failure(nil,@"未知错误");
        return YES;
    }
    
    
    
    
    if([obj[@"err_code"] intValue] != NO_Error)
    {
        if(obj[@"err_msg"] != [NSNull null] || obj[@"err_msg"] != nil)
        {
            if(failure) failure(nil,obj[@"err_msg"]);
      
        }
        return YES;
    }
    
//    if(obj[@"result"] == nil || obj[@"result"] == [NSNull null])
//    {
//        if(failure) failure(nil,@"未知错误");
//        return YES;
//    }
    
    return NO;
}


#pragma mark - Override
/**
 @desc 重写父类的方法，添加http头部参数
 */
- (void)get:(NSString *)url parameters:(NSDictionary *)parameters  completionBlock:(void (^)(id obj))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
   
    [super get:url parameters:parameters completionBlock:success failureBlock:failure];
}




- (void)post:(NSString *)url withParams:(NSDictionary *)params completionBlock:(void (^)(id obj))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
  

    NSLog(@"%@",[NSString stringWithFormat:@"interest%@#$@%%!%@",[[NSDate date]formatDateString:nil],url]);
    
    NSString *token = [[NSString stringWithFormat:@"interest%@#$@%%!%@",[[NSDate date]formatDateString:nil],url]md5];

    NSString *url2= [NSString stringWithFormat:@"%@&a=%@&token=%@",Res_URL_Prefix,url,token];
    [super post:url2 withParams:params completionBlock:success failureBlock:failure];
    
}


- (void)postTopic:(NSString *)url withParams:(NSDictionary *)params completionBlock:(void (^)(id obj))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
   
    NSString *token = [[NSString stringWithFormat:@"interest%@#$@%%!%@",[[NSDate date]formatDateString:nil],url]md5];
    
    NSString *url2= [NSString stringWithFormat:@"%@&a=%@&token=%@",Res_URL_Prefix,url,token];
    [super post:url2 withParams:params completionBlock:success failureBlock:failure];
    
}

- (void)postStudy:(NSString *)url withParams:(NSDictionary *)params completionBlock:(void (^)(id obj))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{

    NSString *token = [[NSString stringWithFormat:@"interest%@#$@%%!%@",[[NSDate date]formatDateString:nil],url]md5];
    UserModel *model = [[LoginService shareInstanced]getUserModel];
    NSString *url2= [NSString stringWithFormat:@"%@&a=%@&token=%@&cache_token=%@",Res_URL_Prefix,url,token,model.cache_token];
    
    [super post:url2 withParams:params completionBlock:success failureBlock:failure];
    
}



#pragma mark

- (void)regist:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure
{
    
    [self post:Register withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }

    } failureBlock:failure];

}

/**
 @desc 获取验证码
 */
//TODO:获取验证码
- (void)getCode:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    [self post:sendValidCode withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

- (void)Scoring:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    [self post:IndexLogin withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc 判断验证吗
 */
//TODO:判断验证吗
- (void)judeCode:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    [self post:JudgeCode withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}
/**
 @desc 意见反馈
 */
//TODO:意见反馈
- (void)feedBack:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    [self post:FeedBack withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}
- (void)login:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    [self post:DoLogin withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
    
}


/**
 @desc 修改密码
 */
//TODO:修改密码
- (void)changePassWord:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError * error,NSString * responseString))failure{
    
    
    [self post:UpdPassword withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc 获取广告
 */
//TODO:获取广告

- (void)getAd:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:Ad withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
 
}

/**
 @desc 获取启动页
 */
//TODO:获取启动页

- (void)getLanuchAd:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:LanuchAd withParams:nil completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];

}

/**
 @desc 获取用户详情
 */
//TODO:获取用户详情

- (void)getUserDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:UsePersonal withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];

}

/**
 @desc 更新用户信息
 */
//TODO:更新用户信息

- (void)updUserDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:UpdPersonal withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc 更新用户头像
 */
//TODO:更新用户头像

- (void)updUserAvatar:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:SaveAvatar withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc  查看帖子
 */
//TODO: 查看帖子

- (void)getNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure
{
    [self post:MyNews withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];

}

/**
 @desc  删除帖子
 */
//TODO: 删除帖子

- (void)delNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:DelNews withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
    
}

/**
 @desc  增加地址
 */
//TODO: 增加地址

- (void)addAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:NewAddress withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc  更新地址
 */
//TODO: 更新地址

- (void)updAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:UpdAddress withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   全部地址
 */
//TODO:  全部地址
- (void)allAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:AllAddress withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   删除地址
 */
//TODO:  删除地址
- (void)delAds:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:DelAddress withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   优惠券
 */
//TODO:  优惠券
- (void)getCoupon:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self post:LookCoupon withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   用户协议
 */
//TODO:  用户协议
- (void)getAgreement:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure
{
    [self post:GetAgreement withParams:nil completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

#pragma mark  topic

/**
 @desc   课程分类
 */
//TODO:  课程分类

- (void)getCourseType:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:CourseType withParams:nil completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   考试等级
 */
//TODO:  考试等级

- (void)getGradeType:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:AllExamGrade withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   支付信息
 */
//TODO:  支付信息

- (void)getPayInfo:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:ReturnAlipayInfo withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure]; 
    
    
}
/**
 @desc   微信支付信息
 */
//TODO:  微信支付信息

- (void)getWxPayInfo:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:WxPay withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   章节练习
 */
//TODO:  章节练习

- (void)getChapterPractice:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:ChapterPractice withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   练习
 */
//TODO:  练习

- (void)getPractice:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:Practice withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   考试等级
 */
//TODO:  考试等级

- (void)getExamGrade:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:ExamGrade withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}
/**
 @desc   允许考试
 */
//TODO:  允许考试

- (void)getAllowExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure
{
    [self postStudy:AllowExam withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

/**
 @desc   考试
 */
//TODO:  考试

- (void)getExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:Exam withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   模拟考试
 */
//TODO:  模拟考试

- (void)getMnExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    
    [self postTopic:MnExam withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   收藏试题
 */
//TODO:  收藏试题

- (void)getLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:ClassLike withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   保存练习
 */
//TODO:  保存练习

- (void)savePra:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:SavePractice withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

/**
 @desc   取消考试
 */
//TODO:  取消考试

- (void)cancleExam:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:CancelExam withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   提交答案
 */
//TODO:  提交答案

- (void)upAnswer:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:TopicAnswer withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}
/**
 @desc   提交模拟答案
 */
//TODO:  提交模拟答案

- (void)upMnAnswer:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    [self postStudy:MnTopicAnswer withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}
/**
 @desc   考题章节
 */
//TODO:  考题章节

- (void)titleType:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postTopic:TitleType withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}


/**
 @desc   考试纪录
 */
//TODO:  考试纪录

- (void)getExamRecord:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:ExamRecord withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

/**
 @desc   练习纪录
 */
//TODO:  练习纪录

- (void)getParRecord:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:PracticeRecord withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}


/**
 @desc   考试赞
 */
//TODO:  考试赞

- (void)getExamLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:MyLike withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}

- (void)getAllLike:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:LookLike withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
}

/**
 @desc   收藏
 */
//TODO:  收藏

- (void)getErrorTitle:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:ErrorDetail withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj);
        }
        
    } failureBlock:failure];
    
}
/**
 @desc   删除错题
 */
//TODO:  删除错题

- (void)delErrorTitle:(NSDictionary *)parms completionBlock:(void (^)(id objdct))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:DelEtitle withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

#pragma mark study

/**
 @desc   学习列表
 */
//TODO:  学习列表

- (void)getCoureList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:CourseList withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   学习点赞
 */
//TODO:  学习点赞

- (void)signCoure:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:Sign withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   学习详情
 */
//TODO:  学习详情

- (void)getCoure:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:CourseDetail withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   论坛
 */
//TODO:  论坛

- (void)getForum:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:GetForum withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   详情
 */
//TODO:  详情

- (void)getNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:GetNewsDetail withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];

}

/**
 @desc   赞新闻
 */
//TODO:   赞新闻

- (void)signNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:NewSign withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   评论新闻
 */
//TODO:  评论新闻

- (void)commonNewsDetail:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:Comment withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   查看评论
 */
//TODO:  查看评论

- (void)comments:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:LookComment withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"news_comment"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   删除评论
 */
//TODO:  删除评论

- (void)delcomment:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:DelComment withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
}

/**
 @desc   发帖
 */
//TODO:  发帖

- (void)addNews:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:AddNews withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   类别
 */
//TODO:  类别

- (void)getCircleList:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:CircleList withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}

/**
 @desc   排行榜
 */
//TODO:  排行榜

- (void)getRanking:(NSDictionary *)parms completionBlock:(void (^)(id object))success failureBlock:(void (^)(NSError *error,NSString *responseString))failure{
    
    [self postStudy:MyRanking withParams:parms completionBlock:^(id obj) {
        
        BOOL isError = [self filterError:obj failureBlock:failure];
        if (isError) {
            return ;
        }
        if(success)
        {
            success(obj[@"result"]);
        }
        
    } failureBlock:failure];
    
}



@end

