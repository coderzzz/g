//
//  LoginCell.m
//  igame
//
//  Created by Interest on 2016/12/8.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "LoginCell.h"
#import "UIButton+Corner.h"
@implementation LoginCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.wordbtn cornerRadius:4];
    self.wordbtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.wordbtn.layer.borderWidth = 1;
    self.wordbtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
