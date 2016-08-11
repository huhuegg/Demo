//
//  YukeyFileAttribute.m
//  TestMessageKit
//
//  Created by jiangchao on 14-6-30.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeyFileAttribute.h"

@implementation YukeyFileAttribute
- (id)initWithPath:(NSString *)filePath attributes:(NSDictionary *)attributes {
    self = [super init];
    if(self){
        self.filePath = filePath;
        self.fileAttributes = attributes;
    }
    return self;
}

- (NSDate *)fileModificationDate {
    return [_fileAttributes fileModificationDate];
}

- (NSString *)description {
    return self.filePath;
}
@end
