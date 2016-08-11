//
//  BaseTools.m
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "BaseTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NSString+URLEscapes.h"
#import "GTMBase64.h"
#import "AESCrypt.h"

@implementation BaseTools

//获取当前时间戳
+(NSString *)getNowTimeStamp
{
    NSDate* currentDate = [NSDate date];
    NSString* currentTimeStamp = [NSString stringWithFormat:@"%lu", (long)[currentDate timeIntervalSince1970]];
    
    return currentTimeStamp;
}

//计算MD5
+(NSString *)md5Sum:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *md5 = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
    
    //NSString *string2 = [string substringToIndex:2];//2为长度
    return [[md5 lowercaseStringWithLocale:[NSLocale currentLocale]] substringToIndex:32]; //转换为小写，截取前32位字符
}


//URL转码
+(NSString *)getURLStringFromString:(NSString *)string
{
    return [string escapedURLString];
}

+(NSString *)newgetURLStringFromString:(NSString *)string
{
    NSString *outputStr = ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)string,NULL,(CFStringRef)@"!*'();:@&=+$,%#[]",kCFStringEncodingUTF8));
    return outputStr;
}

//URL解码
+(NSString *)getStringFromURLString:(NSString *)URLString
{
    return [URLString originalURLString];
}

//Base64加密
+(NSString *)getEncodeBase64String:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [GTMBase64 stringByEncodingData:data];
}

//Base64解密
+(NSString *)getDecodeBase64String:(NSString *)string
{
    NSData *data = [GTMBase64 decodeString:string];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

//AES加密
+(NSString *)getAESEncodeString:(NSString *)string;
{
    return [AESCrypt encrypt:string password:AES_CRYPT_PASS];
}

//AES解密
+(NSString *)getAESDecodeString:(NSString *)string
{
    return [AESCrypt decrypt:string password:AES_CRYPT_PASS];
}



//获取随机UIImage
+(UIImage *)randomUIImage
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"u%i",arc4random() % 12]];
    return image;
}

//获取当前的ViewController
+(UIViewController *)getCurrentRootViewController {
    UIViewController *result;
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    return result;
}


//Json解析
+(NSDictionary *)decodeJsonString:(NSData*)data
{
    NSError *error = nil;
    NSDictionary *dictFromJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error == nil) {
        return dictFromJson;
    }else{
        DLog(@"%@",error);
        DLog(@"Json解析失败");
    }
    return nil;
}


//解析URL结构体
+(NSDictionary *)decodeUrl:(NSURL *)url
{
    NSString *urlstring = [url query];
    NSArray *array = [urlstring componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (array && array.count >0) {
        for (int i=0; i<array.count; i++) {
            NSString *details = [array objectAtIndex:i];
            NSArray *detailsArray = [details componentsSeparatedByString:@"="];
            if (detailsArray && detailsArray.count >0) {
                [dict setObject:[detailsArray lastObject] forKey:[detailsArray objectAtIndex:0]];
            }
        }
        return dict;
    }else{
        return nil;
    }
}
@end
