//
//  YukeyAudioBasicSetting.m
//  TestYukeyVoice
//
//  Created by jiangchao on 14-5-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeyAudioBasicSetting.h"

@implementation YukeyAudioBasicSetting
+(NSString *)getCurrentTimeString
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

+(NSString *)getCacheDirectory
{
    NSString *imageDir = [NSString stringWithFormat:@"%@/Library/Caches/Voice", NSHomeDirectory()];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Voice"];
}

+(NSString *)getImageCacheDirectory
{
    NSString *imageDir = [NSString stringWithFormat:@"%@/Library/Caches/Image", NSHomeDirectory()];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image"];
}

+ (BOOL)fileExistsAtPath:(NSString*)_path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:_path];
}

+(BOOL)deleteFileAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (NSString*)getPathByFileName:(NSString *)fileName{
    NSString* fileDirectory = [[YukeyAudioBasicSetting getCacheDirectory]stringByAppendingPathComponent:fileName];
    return fileDirectory;
}

+(NSString *)getPathByFileName:(NSString *)fileName ofType:(NSString *)type
{
    NSString* fileDirectory = [[[YukeyAudioBasicSetting getCacheDirectory]stringByAppendingPathComponent:fileName]stringByAppendingPathExtension:type];
    return fileDirectory;
}

+(NSString *)getImagePathByFileName:(NSString *)fileName
{
    NSString* fileDirectory = [[YukeyAudioBasicSetting getImageCacheDirectory]stringByAppendingPathComponent:fileName];
    return fileDirectory;
}

+(NSString *)getImagePathByFileName:(NSString *)fileName ofType:(NSString *)type
{
    NSString* fileDirectory = [[[YukeyAudioBasicSetting getImageCacheDirectory]stringByAppendingPathComponent:fileName]stringByAppendingPathExtension:type];
    return fileDirectory;
}


+(NSDictionary *)getAudioRecorderSettingDict
{
    NSMutableDictionary *AudioRecorderSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [AudioRecorderSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [AudioRecorderSetting setValue:[NSNumber numberWithFloat:441000] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [AudioRecorderSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [AudioRecorderSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [AudioRecorderSetting setValue:[NSNumber numberWithInt:AVAudioQualityMedium] forKey:AVEncoderAudioQualityKey];
    //大端还是小端 是内存的组织方式
    //[AudioRecorderSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    //音频编码质量
    //[AudioRecorderSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    return AudioRecorderSetting;
}

@end
