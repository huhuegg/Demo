//
//  MeItemsControl.m
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MeItemsControl.h"

@implementation MeItemsControl

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image titile:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-60)/2, 15, 60, 60)];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.image = image;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 6;
        [self addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, frame.size.width, 30)];
        [titleLabel  setBackgroundColor:[UIColor clearColor]];
        [titleLabel  setFont:[UIFont fontWithName:@"Arial" size:14]];
        [titleLabel  setText:title];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:titleLabel];
    }
    return self;
}

@end
