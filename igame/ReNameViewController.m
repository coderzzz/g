//
//  ReNameViewController.m
//  igame
//
//  Created by Interest on 2016/12/19.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "ReNameViewController.h"

@interface ReNameViewController ()

@end

@implementation ReNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Backgroundcolor;
}

- (void)back{
    
    if (self.tf.text.length>0 && [self.delegate respondsToSelector:@selector(didChangeName:title:)] && self.delegate) {
        [self.delegate didChangeName:self.tf.text title:self.title];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
