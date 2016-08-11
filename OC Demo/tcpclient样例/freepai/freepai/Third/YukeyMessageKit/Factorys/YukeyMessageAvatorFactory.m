//
//  YukeyMessageAvatorFactory.m
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeyMessageAvatorFactory.h"
#import "UIImage+YukeyRounded.h"

@implementation YukeyMessageAvatorFactory
+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatorType:(YukeyMessageAvatorType)messageAvatorType {
    CGFloat radius = 0.0;
    switch (messageAvatorType) {
        case YukeyMessageAvatorTypeNormal:
            return originImage;
            break;
        case YukeyMessageAvatorTypeCircle:
            radius = originImage.size.width / 2.0;
            break;
        case YukeyMessageAvatorTypeSquare:
            radius = 8;
            break;
        default:
            break;
    }
    UIImage *avator = [originImage createRoundedWithRadius:radius];
    return avator;
}
@end
