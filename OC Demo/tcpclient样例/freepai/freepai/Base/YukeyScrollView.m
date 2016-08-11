//
//  YukeyScrollView.m
//  TestInterface
//
//  Created by jiangchao on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeyScrollView.h"
@interface YukeyScrollView()<UIScrollViewDelegate>
{
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
    NSTimer *_timer;
    int TimeNum;
    BOOL Tend;
}
@end

@implementation YukeyScrollView

- (id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray
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
        
        if (imageArray.count>0) {
            _pageControl = [[UIPageControl alloc] init];
            _pageControl.frame =CGRectMake(frame.size.width - 80, frame.size.height - 20, 80, 20);
            _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
            _pageControl.numberOfPages = imageArray.count;
            _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
            _pageControl.enabled = NO;
            [self addSubview:_pageControl];
            
            _scrollView.contentSize = CGSizeMake(frame.size.width * imageArray.count, 0);
            for (NSString *imageName in imageArray) {
                UIImage *image = [UIImage imageNamed:imageName];
                UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*[imageArray indexOfObject:imageName], 0, frame.size.width, frame.size.height)];
                imageView.image = image;
                [_scrollView addSubview:imageView];
            }
            [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
        }
        
    }

    return self;
}

-(void)dealloc
{
    _pageControl = nil;
    _scrollView = nil;
    _timer = nil;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}


#pragma mark - 5秒换图片
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 5 == 0 ) {
        _pageControl.currentPage++;
        if (!Tend) {
            if (_pageControl.currentPage == _pageControl.numberOfPages-1) {
                Tend = YES;
            }
        }else{
            Tend = NO;
            _pageControl.currentPage = 0;
        }

        
        [UIView animateWithDuration:0.7
                         animations:^{
                             _scrollView.contentOffset = CGPointMake(_pageControl.currentPage*320,0);
                         }];
    }
    TimeNum ++;
}

@end
