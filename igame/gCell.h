//
//  gCell.h
//  igame
//
//  Created by sam on 2017/4/13.
//  Copyright © 2017年 Interest. All rights reserved.
//
@protocol gCellDelegate <NSObject>

@optional

- (void)didSelectBtn:(UIButton *)btn;

@end
#import <UIKit/UIKit.h>

@interface gCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *yearbtn;
@property (weak, nonatomic) IBOutlet UIButton *monthbtn;
@property (weak, nonatomic) IBOutlet UIButton *daybtn;
@property (weak, nonatomic) IBOutlet UIButton *hourbtn;
@property (weak, nonatomic) IBOutlet UIButton *minbtn;
@property (weak, nonatomic) id<gCellDelegate>delegate;
- (void)setCellTextWithList:(NSArray *)list;
- (void)setBgColorWihtSelect:(BOOL)select;

@end
