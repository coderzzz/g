//
//  SignContenCell.h
//  igame
//
//  Created by Interest on 2016/12/12.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignContenCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *toplinelab;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *contenlab;
@property (weak, nonatomic) IBOutlet UIButton *signbtn;

@property (weak, nonatomic) IBOutlet UILabel *darklinelab;
@property (weak, nonatomic) IBOutlet UILabel *buttomlinelab;

@end
