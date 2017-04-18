//
//  gCell.m
//  igame
//
//  Created by sam on 2017/4/13.
//  Copyright © 2017年 Interest. All rights reserved.
//

#import "gCell.h"

@implementation gCell
{
    NSMutableArray *btns;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    btns = [@[self.yearbtn,self.monthbtn,self.daybtn,self.hourbtn,self.minbtn]mutableCopy];
    for (int a=0; a<btns.count; a++) {
        UIButton *btn = btns[a];
        btn.tag = a;
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)action:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(didSelectBtn:)]) {
        
        [self.delegate didSelectBtn:btn];
    }
}

- (void)setCellTextWithList:(NSArray *)list{
    
    for (int a=0; a<list.count; a++) {
        UIButton *btn = btns[a];
        [btn setTitle:list[a] forState:UIControlStateNormal];
    }
    
}

- (void)setBgColorWihtSelect:(BOOL)select{
    
    if (select) {
        
        for (UIButton *btn in btns) {
            [btn setTitleColor:BaseColor forState:UIControlStateNormal];
        }
        self.contentView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:178.0/255.0 blue:156.0/255.0 alpha:.5];
    }else{
        
        for (UIButton *btn in btns) {
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        }
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
