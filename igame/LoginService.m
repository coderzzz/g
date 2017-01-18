//
//  LoginService.m
//  iwen
//
//  Created by Interest on 15/10/22.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "LoginService.h"
#import <objc/runtime.h>
@implementation LoginService

+ (LoginService *)shareInstanced
{
    
    static LoginService * this = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        this = [[self alloc] init];
    });
    
    return this;

}

- (BOOL)isLogined{
    
    UserModel *model = [self getUserModel];
    
    if (model.phone.length>0) {
        
        return YES;
    }
    
    return NO;
}


- (void)saveUserModelWithDictionary:(NSDictionary *)dic{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSArray *ary = [dic allKeys];
    
    for (int a= 0; a<ary.count; a++) {
        
        if (dic[ary[a]] !=[NSNull null] && dic[ary[a]] !=nil) {
            
            [userDefaults setObject:dic[ary[a]] forKey:ary[a]];
        }

    }
    [userDefaults synchronize];
}

- (UserModel *)getUserModel{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    UserModel *model = [[UserModel alloc]init];
    
    unsigned int outCount, i;
    
    objc_property_t * properties = class_copyPropertyList([UserModel class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        NSString *value =[userDefaults objectForKey:propertyName];
        
        if (value.length>0) {
            
            [model setValue:value forKey:propertyName];
        }
    }
    
    free(properties);
    
    return model;
}

- (void)loginout{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    unsigned int outCount, i;
    
    objc_property_t * properties = class_copyPropertyList([UserModel class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [userDefaults removeObjectForKey:propertyName];
    }
    
    free(properties);
    
    
}

- (void)getCodeWithPhoneNumber:(NSString *)phoneNumber type:(NSString *)type{
    
    NSDictionary *dic = @{@"phone":phoneNumber,@"type":type};
    
    [[HttpService sharedInstance]getCode:dic completionBlock:^(id object) {
        
        if (object) {
            
  
                
                if (_getCodeSuccess) {
                    
                    _getCodeSuccess(object);
                }

            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getCodeFailure) {
            
            _getCodeFailure (responseString);
        }
        
    }];
    
}

- (void)getScoringWithUid:(NSString *)uid{
    
    NSDictionary *dic = @{@"uid":uid};
    
    [[HttpService sharedInstance]Scoring:dic completionBlock:^(id object) {
        
        if (object) {
             
            
            
          
            
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
     
        
    }];
}

- (void)judgeCodeWithPhoneNumber:(NSString *)phoneNumber code:(NSString *)code{
    
    NSDictionary *dic = @{@"phone":phoneNumber,@"validCode":code};
    
    [[HttpService sharedInstance]judeCode:dic completionBlock:^(id object) {
        
        if (object) {
            
    
                
            if (_judgeCodeSuccess) {
                    
                    
                _judgeCodeSuccess(object);
             
                
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_judgeCodeFailure){
            
            _judgeCodeFailure(responseString);
        }
        
    }];
    
}


- (void)registWithdic:(NSDictionary *)dic{
    
    
    [[HttpService sharedInstance]regist:dic completionBlock:^(id object) {
        
        if (object) {
         
            NSDictionary *dic = (NSDictionary *)object;
            
            UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
            [self saveUserModelWithDictionary:dic];
            if (model) {
                
                if (_registSuccess) {
                    
                    _registSuccess(model);
                }

            }

        }
                                              
      } failureBlock:^(NSError *error, NSString *responseString) {
          
          if (_registFailure) {
              
              _registFailure (responseString);
          }
                                              
       }];

}


- (void)loginWithPhoneNumber:(NSString *)phoneNumber passWord:(NSString *)passWord{
    
    NSDictionary *dic = @{@"phone":phoneNumber,@"password":passWord};
    
    [[HttpService sharedInstance]login:dic completionBlock:^(id object) {
        
        if (object) {
            

            
            NSDictionary *dic = (NSDictionary *)object;
            
            UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
            
            [self saveUserModelWithDictionary:dic];
            
            if (model) {
                
                if (_loginSuccess) {
                    
                    _loginSuccess(model);
                }
                
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_loginFailure) {
            
            _loginFailure (responseString);
        }
        
    }];

    
}

- (void)changePwWithdic:(NSDictionary *)dic{
    
    [[HttpService sharedInstance]changePassWord:dic completionBlock:^(id object) {
        
        if (object) {
            
            
                if (_changePWSuccess) {
                    
                    _changePWSuccess(object);
                }

            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_changePWFailure) {
            
            _changePWFailure (responseString);
        }
        
    }];

}

//- (void)getAdvertisementWithType:(NSString *)type{
//    
//     NSDictionary *dic = @{@"type":type};
//    
//    [[HttpService sharedInstance]getAd:dic completionBlock:^(id object) {
//        
//        if (object) {
//            
//            NSMutableArray *ary = object[@"ad"];
//            
//            NSMutableArray *dataArray = [NSMutableArray array];
//            
//            for (NSDictionary *dic in ary) {
//                
//                AdvertiseMentModel *model = [[AdvertiseMentModel alloc]initWithDictionary:dic error:nil];
//                
//                if (model) {
//                    
//                    [dataArray addObject:model.ad_image];
//                }
//            }
//            
//            if (_getAdvertisementSuccess) {
//                
//                _getAdvertisementSuccess (dataArray);
//            }
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_getAdvertisementFailure) {
//            
//            _getAdvertisementFailure(responseString);
//        }
//        
//    }];
//    
//    
//}

//- (void)getLuanchAdvertisement{
//    
//    [[HttpService sharedInstance]getLanuchAd:nil completionBlock:^(id object) {
//        
//        if (object) {
//            
//            NSMutableArray *ary = object[@"ad"];
//            
//            NSMutableArray *dataArray = [NSMutableArray array];
//            
//            for (NSDictionary *dic in ary) {
//                
//                LuanchAdvertisementModel *model = [[LuanchAdvertisementModel alloc]initWithDictionary:dic error:nil];
//                
//                if (model) {
//                    
//                    [dataArray addObject:model];
//                }
//            }
//            
//            if (_getLanuchAdvertiseSuccess) {
//                
//                _getLanuchAdvertiseSuccess (dataArray);
//            }
//        }
//        
//    } failureBlock:^(NSError *error, NSString *responseString) {
//        
//        if (_getLanuchAdvertiseFailure) {
//            
//            _getLanuchAdvertiseFailure(responseString);
//        }
//        
//    }];
//
//}

- (void)getUserDetailWithID:(NSString *)userId{
    
    NSDictionary *dic = @{@"uid":userId};
    
    [[HttpService sharedInstance]getUserDetail:dic completionBlock:^(id object) {
        
        if (object) {
            
            NSDictionary *dic = object;
            
            UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
            
            if (model) {
                
                if (_getUserDetailSuccess) {
                    
                    _getUserDetailSuccess(model);
                }
                
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_getUserDetailFailure) {
            
            _getUserDetailFailure(responseString);
        }
        
    }];

}

- (void)upDateUserWithDictionary:(NSDictionary *)dic{
    
    
    [[HttpService sharedInstance]updUserDetail:dic completionBlock:^(id object) {
        
        if (object) {
            
            if (_upDateUserDetailSuccess) {
                
                _upDateUserDetailSuccess(object);
            }

        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_upDateUserDetailFailure) {
            
            _upDateUserDetailFailure(responseString);
        }
        
    }];

}

- (void)saveAvatarWithUserId:(NSString *)uid avatarString:(NSString *)avatarString{
    
    NSDictionary *dic = @{@"uid":uid,@"avatar":avatarString};
    
    [[HttpService sharedInstance]updUserAvatar:dic completionBlock:^(id object) {
        
        if (object) {
            
            if (_upDateAvatarSuccess) {
                
                _upDateAvatarSuccess(object);
            }
            
        }
        
    } failureBlock:^(NSError *error, NSString *responseString) {
        
        if (_upDateAvatarFailure) {
            
            _upDateAvatarFailure(responseString);
        }
        
    }];
    
    
    
}

@end
