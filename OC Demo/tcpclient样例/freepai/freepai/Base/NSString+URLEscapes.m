//
//  NSString+URLEscapes.m
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//
#import "NSString+URLEscapes.h"

#define UE_DEBUG 0

int HexCharToInt(const char c) {
    if (c >= '0' && c <= '9') {
        return (c - '0');
    } else if (c >= 'a' && c <= 'f') {
        return (c - 'a' + 10);
    } else if (c >= 'A' && c <= 'F') {
        return (c - 'A' + 10);
    } else {
        return 0;
    }
}

int HexStringToInt(const char *hex) {
    int ret = 0;
    
    if (NULL != hex) {
        int base = 1;
        int ind = strlen(hex) - 1;
        
        while (ind >= 0) {
            ret += base * HexCharToInt(hex[ind--]);
            base *= 0x10;
        }
    }
    
#if UE_DEBUG
    NSLog(@"HexStringToInt: %s -> %d", hex, ret);
#endif
    return ret;
}

@implementation NSString (URLEscapes)

- (NSString *)escapedURLString {
    NSString *ret = self;
    char *src = (char *)[self UTF8String];
    
    if (NULL != src) {
        NSMutableString *tmp = [NSMutableString string];
        int ind = 0;
        
        while (ind < strlen(src)) {
            if (src[ind] < 0
                || (' ' == src[ind]
                    || ':' == src[ind]
                    || '/' == src[ind]
                    || '%' == src[ind]
                    || '#' == src[ind]
                    || ';' == src[ind]
                    || '@' == src[ind]))
            {
#if UE_DEBUG
                NSLog(@"escapedURLString: src[%d] = %d", ind, src[ind]);
#endif
                [tmp appendFormat:@"%%%X", (unsigned char)src[ind++]];
            } else {
                [tmp appendFormat:@"%c", src[ind++]];
            }
        }
        
        ret = tmp;
        
#if UE_DEBUG
        NSLog(@"Escaped string = %@", tmp);
#endif
    }
    
    return ret;
}

- (NSString *)originalURLString {
    NSString *ret = self;
    
    const char *src = [self UTF8String];
    
    if (NULL != src) {
        int src_len = strlen(src);
        char *tmp = (char *)malloc(src_len + 1);
        char word[3] = {0};
        unsigned char c = 0;
        int ind = 0; 
        
        bzero(tmp, src_len + 1); 
        
        while (ind < src_len) { 
            if ('%' == src[ind]) { 
                bzero(word, 3); 
                
                word[0] = src[ind + 1]; 
                word[1] = src[ind + 2]; 
                
                c = (char)HexStringToInt(word); 
                
#if UE_DEBUG 
                NSLog(@"originalURLString: c = %d", c); 
#endif 
                sprintf(tmp, "%s%c", tmp, c); 
                
                ind += 3; 
            } else { 
                sprintf(tmp, "%s%c", tmp, src[ind++]); 
            } 
        } 
        ret = [NSString stringWithUTF8String:tmp]; 
        
#if UE_DEBUG 
        NSLog(@"Original string = %@", ret); 
#endif 
        free(tmp); 
    } 
    
    return ret; 
} 

@end