//
//  NSString+URLEscapes.h
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEscapes)

- (NSString *)escapedURLString;
- (NSString *)originalURLString;
@end
