//
//  YukeyMessageFactory.h
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//
//输出message气泡背景(朝向，内间距)
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YukeyBubbleMessageType) {
    YukeyBubbleMessageTypeSending = 0,
    YukeyBubbleMessageTypeReceiving
};//接收 发送

typedef NS_ENUM(NSInteger, YukeyBubbleImageViewStyle) {
    YukeyBubbleImageViewStyleWeChat = 0
};

typedef NS_ENUM(NSInteger, YukeyBubbleMessageMediaType) {
    YukeyBubbleMessageMediaTypeText = 0,    //文本
    YukeyBubbleMessageMediaTypePhoto = 1,   //图片
    YukeyBubbleMessageMediaTypeVideo = 2,   //视频
    YukeyBubbleMessageMediaTypeVoice = 3,   //语音
    YukeyBubbleMessageMediaTypeEmotion = 4, //地图
    YukeyBubbleMessageMediaTypeLocalPosition = 5,
};//消息的各种类型

@interface YukeyMessageBubbleFactory : NSObject

+ (UIImage *)bubbleImageViewForType:(YukeyBubbleMessageType)type
                              style:(YukeyBubbleImageViewStyle)style
                          meidaType:(YukeyBubbleMessageMediaType)mediaType;
@end
