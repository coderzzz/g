//
//  BaseNavigationController.m
//  iwen
//
//  Created by Interest on 15/10/10.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "BaseNavigationController.h"



@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
       
//        [self setBarClear];
//        [self.navigationBar setBarTintColor:[UIColor colorWithRed:254.0/255.0 green:251.0/255.0 blue:246.0/255.0 alpha:1]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
//        [self.view setBackgroundColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"select_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    }
    return self;
}


@end
