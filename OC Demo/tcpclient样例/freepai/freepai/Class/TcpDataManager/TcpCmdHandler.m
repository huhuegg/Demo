//
//  TcpCmdHandler.m
//  freepai
//
//  Created by admin on 14/6/17.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "TcpCmdHandler.h"
#import "TcpDataManager.h"
#import "GCDAsyncSocket.h"
#import "TcpStruct.h"
//#import <string.h>
//#import <stdlib.h>

@implementation TcpCmdHandler

+(TcpCmdHandler *)instance {
    static TcpCmdHandler *instance = nil;
    /*
     dispatch_once_t 变量只是标识_dispatch_once的执行情况，当once已经被使用时，dispatch_once方法将不执行内容；
     */
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[TcpCmdHandler alloc]init];
    });
    return instance;
}


-(void)connServer {
    NSLog(@"CLASS:%@ connServer",[self class]);
    [[TcpDataManager instance] connServer];
}

-(void)disconnServer {
    NSLog(@"CLASS:%@ disconnServer",[self class]);
    [[TcpDataManager instance]disconnServer];
}

-(BOOL)checkConnectStatus {
    return [[TcpDataManager instance].socket isConnected];
}


-(void)sendExampleCmdWithName:(NSString *)name desc:(NSString *)desc {
    NSMutableData *data=[[NSMutableData alloc]init];
    
    NSData *exampleNameData = [[TcpDataManager instance] stringToData:name length:16];
    NSData *exampleDescData = [[TcpDataManager instance]stringToData:desc length:64];
    
    [data appendData:exampleNameData];
    [data appendData:exampleDescData];
    [[TcpDataManager instance]sendMsgWithData:data cmd:555 ifName:REQ_EXAMPLE_IFNAME];
}



@end
