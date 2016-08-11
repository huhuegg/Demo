//
//  TcpDataManager.h
//  freepai
//
//  Created by admin on 14/6/17.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "TcpStruct.h"



@interface TcpDataManager : NSObject


@property (strong,nonatomic) GCDAsyncSocket *socket;
@property (strong,nonatomic) NSMutableData *buffer;
@property NSMutableArray *receivedPackArr;
@property int packLength;
@property int loopCheckPackTimes;

+(TcpDataManager *)instance;
-(void)connServer;
-(void)disconnServer;

-(void)sendMsgWithData:(NSData *)contextData cmd:(int)cmdCode ifName:(NSString *)ifName;

-(NSData *)stringToData:(NSString *)str length:(int)length;
-(NSMutableData *)expandData:(NSData *)data length:(int)length;
@end
