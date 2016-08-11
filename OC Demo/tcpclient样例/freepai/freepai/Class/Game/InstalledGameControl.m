//
//  InstalledGameControl.m
//  freepai
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "InstalledGameControl.h"

@implementation InstalledGameControl

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image titile:(NSString *)title URL:(NSString *)urlString
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.url = urlString;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-30)];
        imageView.image = image;
        [self addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
        [titleLabel  setBackgroundColor:[UIColor clearColor]];
        [titleLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
        [titleLabel  setText:title];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:titleLabel];
    }
    return self;
}

@end
