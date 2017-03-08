//
//  SexViewController.h
//  igame
//
//  Created by Interest on 2016/12/19.
//  Copyright © 2016年 Interest. All rights reserved.
//
@protocol SexViewControllerDelegate <NSObject>
@optional
- (void)didChangeSex:(NSInteger)sex;
@end
#import "BaseViewController.h"
@interface SexViewController : BaseViewController
@property (weak, nonatomic) id<SexViewControllerDelegate> delegate;


@property (copy, nonatomic) NSString *mysex;
@end
