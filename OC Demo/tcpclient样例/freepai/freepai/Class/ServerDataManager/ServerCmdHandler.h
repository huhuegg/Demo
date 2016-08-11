//
//  ServerCmdHander.h
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum : NSUInteger {
    req_get = 0,
    req_post = 1,
} ReqType;

typedef void (^ReqRet)(id res);

@interface ServerCmdHandler : NSObject

@property (strong, nonatomic)AFHTTPRequestOperationManager* httpManager;

+ (ServerCmdHandler *) sharedInstance;

- (void) sendReqCmd:(NSString*)reqCmd needHashStr:(NSString*)needHashStr reqParams:(NSDictionary*)reqParams isGetType:(ReqType)isGetType completBlock:(ReqRet)completBlock;

@end
