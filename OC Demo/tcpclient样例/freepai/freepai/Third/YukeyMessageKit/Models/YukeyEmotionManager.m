//
//  YukeyEmotionManager.m
//  TestMessageKit
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeyEmotionManager.h"

@implementation YukeyEmotionManager
- (void)dealloc {
    [self.emotions removeAllObjects];
    self.emotions = nil;
}
@end
