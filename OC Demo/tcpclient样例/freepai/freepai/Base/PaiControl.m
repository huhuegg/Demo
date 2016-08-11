//
//  PaiControl.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "PaiControl.h"

@implementation PaiControl


-(id)initWithFrame:(CGRect)frame withUrl:(NSString *)Url mainImage:(UIImage *)mainimage  rightTopImage:(UIImage *)rightTopimage PaiType:(PaiControlType)type PaiStatus:(PaiControlStatus)status
{
    self = [super initWithFrame:frame];
    if (self) {
        if (mainimage) {
            UIImageView *mainImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            mainImageView.image = mainimage;
            [self addSubview:mainImageView];
        }
        
        if (rightTopimage) {
            UIImageView *rightTopImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            rightTopImageView.image = rightTopimage;
            [self addSubview:rightTopImageView];
        }
        
        self.paistatus = status;
        self.changeURL = Url;

    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
