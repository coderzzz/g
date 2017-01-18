//
//  MySaveViewController.h
//  ZhuZhu
//
//  Created by Carl_Huang on 15/1/24.
//  Copyright (c) 2015年 Vison. All rights reserved.
//

#import "HomeViewController.h"
#import "HMSegmentedControl.h"
@interface MySaveViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UITableView *firstTableview;
@property (strong, nonatomic) IBOutlet UITableView *secondTableview;
@property (strong, nonatomic) IBOutlet UITableView *thirdTableview;
@property (nonatomic,strong) HMSegmentedControl* segmentedControl;




@end
