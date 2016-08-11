//
//  YukeyMessageVoiceFactory.h
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YukeyMessageBubbleFactory.h"

@interface YukeyMessageVoiceFactory : NSObject

+ (UIImageView *)messageVoiceAnimationImageViewWithBubbleMessageType:(YukeyBubbleMessageType)type;
@end
