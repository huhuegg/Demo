//
//  YukeyBubblePhotoImageView.h
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YukeyMessageBubbleFactory.h"

@interface YukeyBubblePhotoImageView : UIView
/**
 *  发送后，需要显示的图片消息的图片，或者是视频的封面
 */
@property (nonatomic, strong) UIImage *messagePhoto;

/**
 *  加载网络图片的时候，需要用到转圈的控件
 */
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

/**
 *
 *
 *  @param messagePhoto
 *  @param bubbleMessageType
 */
/**
 *  根据目标图片配置三角形具体位置
 *
 *  @param messagePhoto      目标图片
 *  @param thumbnailUrl      目标图片缩略图的URL链接
 *  @param originPhotoUrl    目标图片原图的URL链接
 *  @param bubbleMessageType 目标消息类型
 */
- (void)configureMessagePhoto:(UIImage *)messagePhoto thumbnailUrl:(NSString *)thumbnailUrl originPhotoUrl:(NSString *)originPhotoUrl onBubbleMessageType:(YukeyBubbleMessageType)bubbleMessageType;

/**
 *  获取消息类型比如发送或接收
 *
 *  @return 消息类型
 */
- (YukeyBubbleMessageType)getBubbleMessageType;
@end
