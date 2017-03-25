//
//  TypeViewController.m
//  igame
//
//  Created by Interest on 2017/3/15.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import "TypeViewController.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"
@interface TypeViewController ()

@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)aciton:(UIButton *)sender {
    
    if (sender.tag == 2) {
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
        TabBarViewController *vc = [[TabBarViewController alloc]init];
        delegate.window.rootViewController = vc;

    }else{
        
        [self showHudWithString:@"建设中..."];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
