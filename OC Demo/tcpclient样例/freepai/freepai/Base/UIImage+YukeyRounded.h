//
//  UIImage+YukeyRounded.h
//  TestJCmessage
//
//  Created by jiangchao on 14-5-7.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YukeyRounded)

- (UIImage *)createRoundedWithRadius:(CGFloat)radius;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
@end
