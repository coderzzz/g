//
//  CommonCell.h
//  igame
//
//  Created by Interest on 2016/12/12.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimgv;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *contentlab;
@property (weak, nonatomic) IBOutlet UILabel *datelab;
@property (weak, nonatomic) IBOutlet UIButton *common;
@property (weak, nonatomic) IBOutlet UILabel *buttomline;
@end
