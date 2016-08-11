//
//  YukeyAudioBasicSetting.h
//  TestYukeyVoice
//
//  Created by jiangchao on 14-5-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define kDefaultMaxRecordTime       60
@interface YukeyAudioBasicSetting : NSObject

/**
 生成当前时间字符串
 @returns 当前时间字符串
 */
+ (NSString*)getCurrentTimeString;


/**
 获取缓存路径
 @returns 缓存路径
 */
+ (NSString*)getCacheDirectory;


/**
 获取缓存路径
 @returns 缓存路径
 */
+ (NSString*)getImageCacheDirectory;

/**
 判断文件是否存在
 @param _path 文件路径
 @returns 存在返回yes
 */
+ (BOOL)fileExistsAtPath:(NSString*)_path;


/**
 删除文件
 @param _path 文件路径
 @returns 成功返回yes
 */
+ (BOOL)deleteFileAtPath:(NSString*)_path;

#pragma mark -

/**
 生成文件路径
 @param _fileName 文件名
 @param _type 文件类型
 @returns 文件路径
 */
+ (NSString*)getPathByFileName:(NSString *)fileName;
+ (NSString*)getPathByFileName:(NSString *)fileName ofType:(NSString *)type;


/**
 生成文件路径
 @param _fileName 文件名
 @param _type 文件类型
 @returns 文件路径
 */
+ (NSString*)getImagePathByFileName:(NSString *)fileName;
+ (NSString*)getImagePathByFileName:(NSString *)fileName ofType:(NSString *)type;

/**
 获取录音设置
 @returns 录音设置
 */
+ (NSDictionary*)getAudioRecorderSettingDict;
@end
