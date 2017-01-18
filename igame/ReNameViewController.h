//
//  ReNameViewController.h
//  igame
//
//  Created by Interest on 2016/12/19.
//  Copyright © 2016年 Interest. All rights reserved.
//
@protocol ReNameViewControllerDelegate <NSObject>
@optional
- (void)didChangeName:(NSString *)name title:(NSString *)title;
@end
#import "BaseViewController.h"
@interface ReNameViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) id<ReNameViewControllerDelegate> delegate;
@end
