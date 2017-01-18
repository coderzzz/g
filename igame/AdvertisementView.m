//
//  AdvertisementView.m
//  iwen
//
//  Created by Interest on 15/10/19.
//  Copyright (c) 2015年 Interest. All rights reserved.
//

#import "AdvertisementView.h"
#import "UIImageView+WebCache.h"

#define  PlaceholderImage [UIImage imageNamed:@"1"]

@implementation AdvertisementView 

{
    CGRect     scrollviewFrame;
    
    NSInteger  currentPage;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        scrollviewFrame = frame;
        
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(scrollviewFrame.size.width * 3,scrollviewFrame.size.height);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate  = self;
        
        for (int a = 0; a<3; a++) {
            
            UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * a, 0, scrollviewFrame.size.width, scrollviewFrame.size.height)];
            
            imagv.contentMode = UIViewContentModeScaleAspectFill;
            
            imagv.layer.masksToBounds = YES;
            [self addSubview:imagv];
            
        }
        
        currentPage = 0;
        
        [self updateImage];
        
        [self startTime];
    }
    
    return self;
}

- (void)setUrlArray:(NSMutableArray *)urlArray{
    
    if (urlArray) {
        
        _urlArray = urlArray;
        
        [self updateImage];
    }
    
}


- (void)startTime{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)nextAction{
    
    [self setContentOffset:CGPointMake(scrollviewFrame.size.width * 2, 0) animated:YES];
    
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}



- (void) updateImage{
    
   
    for (NSUInteger i = 0; i < self.subviews.count; i++) {
        UIImageView *imagV = self.subviews[i];
        NSInteger index = currentPage;
        if (i == 0) {
            index--;
        }else if(i == 2)
        {
            index++;
        }
        if (index < 0) {
            index = self.urlArray.count - 1;
        }else if(index >= self.urlArray.count )
        {
            index = 0;
        }
        
        imagV.tag = index;
//        imagV.image = [UIImage imageNamed:self.urlArray[index]];
        
        [imagV sd_setImageWithURL:[NSURL URLWithString:self.urlArray[index]] placeholderImage:PlaceholderImage options:SDWebImageRetryFailed];
        
        
    }
    
    [self setContentOffset:CGPointMake(scrollviewFrame.size.width, 0)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger page = 0;
    
    CGFloat minDistance = MAXFLOAT;
    
    for (int i = 0; i< self.subviews.count; i++) {
        
        UIImageView *imagev = self.subviews[i];
        
        CGFloat    distance = 0;
        
        distance = ABS(imagev.frame.origin.x-self.contentOffset.x
                       );
        
        if (distance<minDistance) {
            
            minDistance = distance;
            
            page = imagev.tag;
        }
        
    }
    
    currentPage = page;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTime];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self updateImage];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self updateImage];
    
}


@end
