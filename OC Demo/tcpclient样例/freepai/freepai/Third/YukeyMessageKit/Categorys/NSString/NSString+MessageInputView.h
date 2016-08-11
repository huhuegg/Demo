//
//  NSString+MessageInputView.h
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MessageInputView)
- (NSString *)stringByTrimingWhitespace;


- (NSUInteger)numberOfLines;
@end
