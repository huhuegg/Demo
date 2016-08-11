//
//  BaseTools.h
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTools : NSObject

//获取当前时间戳
+ (NSString *)getNowTimeStamp;

//计算MD5
+ (NSString*) md5Sum:(NSString*)string;

//URL转码
+(NSString *)getURLStringFromString:(NSString *)string;

+(NSString *)newgetURLStringFromString:(NSString *)string;

//URL解码
+(NSString *)getStringFromURLString:(NSString *)URLString;

//Base64加密
+(NSString *)getEncodeBase64String:(NSString *)string;

//Base64解密
+(NSString *)getDecodeBase64String:(NSString *)string;

//AES加密
+(NSString *)getAESEncodeString:(NSString *)string;

//AES解密
+(NSString *)getAESDecodeString:(NSString *)string;

//获取随机UIImage
+(UIImage *)randomUIImage;


//获取当前的ViewController
+(UIViewController *)getCurrentRootViewController;

//Json解析
+(NSDictionary *)decodeJsonString:(NSData*)data;

//解析URL结构体
+(NSDictionary *)decodeUrl:(NSURL *)url;
@end
