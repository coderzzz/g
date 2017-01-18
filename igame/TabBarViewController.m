//
//  TabBarViewController.m
//  iwen
//
//  Created by Interest on 15/10/8.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "TabBarViewController.h"
#import "PersonViewController.h"
#import "BaseNavigationController.h"
#import "GameViewController.h"
#import "HomeViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (id)init{
    
    self = [super init];
    
    if(self){
        
//        [self.view setBackgroundColor:[UIColor whiteColor]];
       
//        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 49)];
//        
//        backview.backgroundColor = BaseColor;
//        
//        [self.tabBar insertSubview:backview atIndex:0];
        
        self.tabBar.opaque = YES;
        self.tabBar.selectionIndicatorImage =[self imageWithColor:BaseColor andSize:CGSizeMake(ScreenWidth/3, 49)];
//        [self.tabBar setBackgroundColor:[UIColor blackColor]];
        UITabBarItem *item1 = [[UITabBarItem alloc] init];
        item1.tag = 1;
        item1.title = @"社区";
        [item1 setImage:[UIImage imageNamed:@"标签栏-社区"]];
        [item1 setSelectedImage:[[UIImage imageNamed:@"标签栏-社区-选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
                             forState:UIControlStateSelected];
       
        
        UITabBarItem *item2 = [[UITabBarItem alloc] init];
        item2.tag = 2;
        item2.title =  @"蓝牙手柄";
        [item2 setImage:[UIImage imageNamed:@"标签栏-蓝牙手柄"]];
        [item2 setSelectedImage:[[UIImage imageNamed:@"标签栏-蓝牙手柄-选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
                             forState:UIControlStateSelected];
       
        
        UITabBarItem *item3 = [[UITabBarItem alloc] init];
        item3.tag = 3;
        item3.title =  @"个人中心";
        [item3 setImage:[UIImage imageNamed:@"标签栏-个人中心"]];
        [item3 setSelectedImage:[[UIImage imageNamed:@"标签栏-个人中心-选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
                             forState:UIControlStateSelected];
      
        HomeViewController *homevc = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
        homevc.title = @"社区";
        BaseNavigationController *helpnav = [[BaseNavigationController alloc]initWithRootViewController:homevc];
        helpnav.tabBarItem =item1;
       
        
        
        GameViewController *gamevc = [[GameViewController alloc]initWithNibName:nil bundle:nil];
        gamevc.title = @"蓝牙手柄";
        BaseNavigationController *homenav = [[BaseNavigationController alloc]initWithRootViewController:gamevc];
        homenav.tabBarItem =item2;
        
        PersonViewController *setvc = [[PersonViewController alloc]initWithNibName:nil bundle:nil];
        setvc.title = @"个人中心";
        BaseNavigationController *setnav = [[BaseNavigationController alloc]initWithRootViewController:setvc];
        setnav.tabBarItem =item3;
        
        self.viewControllers = @[helpnav,homenav,setnav];
        
        self.delegate = self;
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(loginSessionFailure)
//                                                     name:LOGIN_SESSION_FAILURE_NEED_LOGIN
//                                                   object:nil];
        
        return  self;
    }
    return  nil;
}
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height); //  <- Here
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)loadView
{
    [super loadView];
    //修改高度
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tabBarHeight = 49;
    self.tabBar.frame = CGRectMake(0, height-tabBarHeight, width, tabBarHeight);
    self.tabBar.clipsToBounds = YES;
    UIView *transitionView = [[self.view subviews] objectAtIndex:0];
//    transitionView.height = height-tabBarHeight;
    
    CGRect rect = transitionView.frame;
    
    rect.size.height =height-tabBarHeight;
    
    transitionView.frame = rect;
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (UIInterfaceOrientationPortrait==interfaceOrientation);
}


- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }else{
        [super presentModalViewController:modalViewController animated:animated];
    }
}
@end
