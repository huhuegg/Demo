//
//  YukeyMessageFactory.m
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeyMessageBubbleFactory.h"
#import "YukeyMacro.h"

@implementation YukeyMessageBubbleFactory

+ (UIImage *)bubbleImageViewForType:(YukeyBubbleMessageType)type
                              style:(YukeyBubbleImageViewStyle)style
                          meidaType:(YukeyBubbleMessageMediaType)mediaType {
    NSString *messageTypeString;
    
    switch (style) {
        case YukeyBubbleImageViewStyleWeChat:
            // 类似微信的
            messageTypeString = @"weChatBubble";
            break;
        default:
            break;
    }
    
    switch (type) {
        case YukeyBubbleMessageTypeSending:
            // 发送
            messageTypeString = [messageTypeString stringByAppendingString:@"_Sending"];
            break;
        case YukeyBubbleMessageTypeReceiving:
            // 接收
            messageTypeString = [messageTypeString stringByAppendingString:@"_Receiving"];
            break;
        default:
            break;
    }
    
    switch (mediaType) {
        case YukeyBubbleMessageMediaTypePhoto:
        case YukeyBubbleMessageMediaTypeVideo:
            messageTypeString = [messageTypeString stringByAppendingString:@"_Solid"];
            break;
        case YukeyBubbleMessageMediaTypeText:
        case YukeyBubbleMessageMediaTypeVoice:
            messageTypeString = [messageTypeString stringByAppendingString:@"_Solid"];
            break;
        default:
            break;
    }
    
    
    UIImage *bublleImage = [UIImage imageNamed:messageTypeString];
    UIEdgeInsets bubbleImageEdgeInsets = [self bubbleImageEdgeInsetsWithStyle:style];
    return XH_STRETCH_IMAGE(bublleImage, bubbleImageEdgeInsets);
}

+ (UIEdgeInsets)bubbleImageEdgeInsetsWithStyle:(YukeyBubbleImageViewStyle)style {
    UIEdgeInsets edgeInsets;
    switch (style) {
        case YukeyBubbleImageViewStyleWeChat:
            // 类似微信的
            edgeInsets = UIEdgeInsetsMake(30, 28, 85, 28);
            break;
        default:
            break;
    }
    return edgeInsets;
}
@end
