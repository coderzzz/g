//
//  GameViewController.m
//  igame
//
//  Created by Interest on 2016/12/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "GameViewController.h"
#import "ChildrenViewController.h"
#import "ConnectViewController.h"
#import "RecordViewController.h"
#import "BatteryViewController.h"
@interface GameViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIView *contentview;
@property (weak, nonatomic) IBOutlet UIView *funtionview;
@property (weak, nonatomic) IBOutlet UIButton *datebtn;
@property (weak, nonatomic) IBOutlet UIButton *usebtn;
@end

@implementation GameViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentview.backgroundColor = BaseColor;
    [self.usebtn setTitleColor:BaseColor forState:UIControlStateNormal];;
    [self.datebtn setTitleColor:BaseColor forState:UIControlStateNormal];
    NSString *date = [[NSDate date]formatDateString:nil];
    [self.datebtn setTitle:date forState:UIControlStateNormal];
    
    
    if (self.view.frame.size.height >450) {
        
        self.contentview.frame  = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49);
        [self.scrollview addSubview:self.contentview];
    }
    else{
        self.contentview.frame  = CGRectMake(0, 0, ScreenWidth, 450);
        [self.scrollview addSubview:self.contentview];
    }
  
}
- (IBAction)action:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        ChildrenViewController *vc = [[ChildrenViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 5 || sender.tag == 6){

        RecordViewController *vc = [[RecordViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 4){
        
        BatteryViewController *vc = [[BatteryViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

    else{
        
        ConnectViewController *vc = [[ConnectViewController alloc]init];
        vc.type = [NSString stringWithFormat:@"%ld",(long)sender.tag];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}




@end
