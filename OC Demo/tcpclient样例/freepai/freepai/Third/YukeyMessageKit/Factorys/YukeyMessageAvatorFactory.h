//
//  YukeyMessageAvatorFactory.h
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

// 头像大小以及头像与其他控件的距离
static CGFloat const kYukeyAvatarImageSize = 40.0f;
static CGFloat const kYukeyAlbumAvatorSpacing = 15.0f;

typedef NS_ENUM(NSInteger, YukeyMessageAvatorType) {
    YukeyMessageAvatorTypeNormal = 0,
    YukeyMessageAvatorTypeSquare,
    YukeyMessageAvatorTypeCircle
};

@interface YukeyMessageAvatorFactory : NSObject

+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatorType:(YukeyMessageAvatorType)type;
@end
