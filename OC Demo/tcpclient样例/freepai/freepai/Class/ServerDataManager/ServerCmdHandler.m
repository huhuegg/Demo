//
//  ServerCmdHander.m
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ServerCmdHandler.h"

@implementation ServerCmdHandler

+(ServerCmdHandler *)sharedInstance
{
    static ServerCmdHandler *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(id)init
{
    id p = [super init];
    if (p) {
        if (self.httpManager == nil) {
            self.httpManager = [AFHTTPRequestOperationManager manager];
            self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            [self.httpManager.requestSerializer setTimeoutInterval:AcceptNetTimeOut];
        }
        return p;
    }
    return nil;
}

-(void)sendReqCmd:(NSString *)reqCmd needHashStr:(NSString *)needHashStr reqParams:(NSDictionary *)reqParams isGetType:(ReqType)isGetType completBlock:(ReqRet)completBlock
{
    NSString* urlStr = [NSString stringWithFormat:@"%s%@", FreePaiServerAddress, reqCmd];
    NSString* currentTimeStamp = [BaseTools getNowTimeStamp];
    
    needHashStr = [NSString stringWithFormat:@"%@+%@", currentTimeStamp, needHashStr];
    
    NSString* authmd5 = [BaseTools md5Sum:needHashStr];
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:reqParams];
    if (dic) {
        [dic setObject:authmd5 forKey:@"auth"];
        [dic setObject:currentTimeStamp forKey:@"timestamp"];
    }
    if (isGetType == req_post) {
        if (_httpManager) {
            [_httpManager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                completBlock(operation);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                completBlock(operation);
            }];
        }
    }
    else {
        if (_httpManager) {
            [_httpManager GET:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                completBlock(operation);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                completBlock(operation);
            }];
        }
    }
}
@end
