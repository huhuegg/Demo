//
//  TcpCmdHandler.h
//  freepai
//
//  Created by admin on 14/6/17.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TcpCmdHandler : NSObject

+(TcpCmdHandler *)instance;

-(void)connServer;
-(void)disconnServer;
-(BOOL)checkConnectStatus;

-(void)sendExampleCmdWithName:(NSString *)name desc:(NSString *)desc;
@end
