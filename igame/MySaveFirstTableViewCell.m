//
//  MySaveFirstTableViewCell.m
//  ZhuZhu
//
//  Created by Carl_Huang on 15/1/24.
//  Copyright (c) 2015年 Vison. All rights reserved.
//

#import "MySaveFirstTableViewCell.h"

@implementation MySaveFirstTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.linelab.frame =CGRectMake(0, 79.4, ScreenWidth, 0.6);
}
@end
