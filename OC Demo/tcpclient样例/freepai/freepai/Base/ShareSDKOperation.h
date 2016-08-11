//
//  ShareSDKOperation.h
//  freepai_client
//
//  Created by jiangchao on 14-5-22.
//  Copyright (c) 2014年 yunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <RennSDK/RennSDK.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <Pinterest/Pinterest.h>
#import "YXApi.h"
#import "constant.h"


@class AGAppDelegate;
@interface ShareSDKOperation : NSObject
{
    AGAppDelegate *_appDelegate;
}


+(ShareSDKOperation *)sharedInstance;

- (void)shareAllButtonClickHandler:(UIView *)sender withContent:(NSString *)content withURL:(NSString *)url withimage:(UIImage *)image withTitle:(NSString *)title;

- (void)shareBySMSClickHandler:(UIButton *)sender;

- (void)shareToSinaWeiboClickHandler:(UIButton *)sender;

- (void)shareToWeixinSessionClickHandler:(UIButton *)sender;

- (void)shareToWeixinTimelineClickHandler:(UIButton *)sender;
@end
