//
//  YukeyEmotion.h
//  TestMessageKit
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kXHEmotionImageViewSize 60
#define kXHEmotionMinimumLineSpacing 16
@interface YukeyEmotion : NSObject
/**
 *  gif表情的封面图
 */
@property (nonatomic, strong) UIImage *emotionConverPhoto;

/**
 *  gif表情的路径
 */
@property (nonatomic, copy) NSString *emotionPath;
@end
