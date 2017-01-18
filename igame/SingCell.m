//
//  SingCell.m
//  igame
//
//  Created by Interest on 2016/12/12.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "SingCell.h"

@implementation SingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
