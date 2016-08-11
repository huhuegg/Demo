//
//  YukeyMessageDisplayTextView.m
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeyMessageDisplayTextView.h"

@implementation YukeyMessageDisplayTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
}

- (void)dealloc {
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end
