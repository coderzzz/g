//
//  BaseViewController.m
//  iwen
//
//  Created by Interest on 15/10/10.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
#import <objc/message.h>
@interface BaseViewController ()

@end


@implementation BaseViewController

{
    MBProgressHUD *mbpHud;
}

- (id)init{
    self = [super init];
    if (self) {
    
        
        self.edgesForExtendedLayout =  UIRectEdgeNone;
        self.navigationItem.leftBarButtonItem = self.commonbackItem;
        
    }
    return self;
}
- (UIBarButtonItem *)commonbackItem{
    
    if (_commonbackItem  == nil) {
        
        UIButton *blogItem         = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [blogItem setImage:[UIImage imageNamed:@"智能手柄-返回"] forState:UIControlStateNormal];
        [blogItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _commonbackItem = [[UIBarButtonItem alloc]initWithCustomView:blogItem];
        
        
    }
    
    return _commonbackItem;
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =Backgroundcolor;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
  
    
    
//    self.navigationItem.leftBarButtonItem = self.commonbackItem;
    // Do any additional setup after loading the view.
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
- (void)showHud{
    
    
    AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    mbpHud =[[MBProgressHUD alloc]initWithView:dele.window];
    
    [dele.window addSubview:mbpHud];
    
     [mbpHud show:YES];
    
    
}

- (void)hideHud{
    
    
    [mbpHud hide:YES];
     mbpHud = nil;
}

- (void)showHudWithString:(NSString *)string{
    
    
    AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:dele.window];
    
    [dele.window addSubview:hud];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.labelText = string;
    
    [hud show:YES];
    
    [hud hide:YES afterDelay:1.2];
    
    
}

@end
