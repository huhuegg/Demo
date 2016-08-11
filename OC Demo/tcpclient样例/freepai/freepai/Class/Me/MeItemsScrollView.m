//
//  MeItemsScrollView.m
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MeItemsScrollView.h"
#import "MeItemsControl.h"

@interface MeItemsScrollView()
{
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
}
@end

@implementation MeItemsScrollView
- (id)initWithFrame:(CGRect)frame itemsArray:(NSArray *)itemsArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview: _scrollView];
        
        if (itemsArray.count> 0) {
            int count;
            if (itemsArray.count%3 == 0) {
                count = itemsArray.count/3;
            }else{
                count = (int)(itemsArray.count/3) +1;
            }
            _pageControl = [[UIPageControl alloc] init];
            _pageControl.frame =CGRectMake(0, 0, 80, 20);
            _pageControl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-15);
            _pageControl.numberOfPages = count;
            _pageControl.enabled = NO;
            //[self addSubview:_pageControl];
            
            
            
            
            _scrollView.contentSize = CGSizeMake(frame.size.width * count, 0);
            float itemwidth = 320/3;
            for (NSString *imageName in itemsArray) {
                UIImage *headImage;
                if ([imageName isEqualToString:@"我的支付宝"]) {
                    headImage = [UIImage imageNamed:@"MyOne"];
                }else if ([imageName isEqualToString:@"我的收货地址"]){
                    headImage = [UIImage imageNamed:@"MyTwo"];
                }else if ([imageName isEqualToString:@"我的圈子"]){
                    headImage = [UIImage imageNamed:@"MyThree"];
                }else{
                    headImage = [BaseTools randomUIImage];
                }
                MeItemsControl *meItemsControl = [[MeItemsControl alloc] initWithFrame:CGRectMake([itemsArray indexOfObject:imageName]*itemwidth, 0, itemwidth, itemwidth) image:headImage titile:imageName];
                meItemsControl.mainTitle = imageName;
                [meItemsControl addTarget:self action:@selector(meItemsControl_touch:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:meItemsControl];
            }
        }
    }
    
    return self;

}

-(void)meItemsControl_touch:(id)sender
{
    MeItemsControl *meItemsControl = (MeItemsControl *)sender;
    [self.delegate touchTheItemWithTitle:meItemsControl.mainTitle];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}



@end
