//
//  XMPPDataManager.h
//  xmppTest
//
//  Created by admin on 14/6/27.
//  Copyright (c) 2014年 me.ieggs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

/*
 XMPP中常用对象们：
 
 XMPPStream：xmpp基础服务类
 XMPPRoster：好友列表类
 XMPPRosterCoreDataStorage：好友列表（用户账号）在core data中的操作类
 XMPPvCardCoreDataStorage：好友名片（昵称，签名，性别，年龄等信息）在core data中的操作类
 XMPPvCardTemp：好友名片实体类，从数据库里取出来的都是它
 xmppvCardAvatarModule：好友头像
 XMPPReconnect：如果失去连接,自动重连
 XMPPRoom：提供多用户聊天支持
 XMPPPubSub：发布订阅
 
*/

@interface XMPPDataManager : NSObject<XMPPRosterDelegate>
@property NSNotificationCenter *notificationCenter;

@property NSString *serverAddr;
@property NSString *userName;
@property NSString *passwd;


@property XMPPStream *xmppStream;
@property BOOL isOpen; //xmppStream status
@property XMPPRoster *xmppRoster;
@property XMPPRosterCoreDataStorage  *xmppRosterstorage;
@property XMPPRoom *xmppRoom;
@property XMPPRoomCoreDataStorage *xmppRoomCoreDataStorate;

/*
@property XMPPJID *roomJID;
@property XMPPRoom *xmppRoom;
*/
 
+(XMPPDataManager *)instance;
//-(void)setupStream;
-(void)goOnline;
-(void)goOffline;
-(BOOL)connectToServer:(NSString *)serverAddr userName:(NSString *)userName passwd:(NSString *)passwd;
-(void)disconnect;
-(void)sendMsg:(NSString *)msg type:(NSString *)type from:(NSString *)from to:(NSString *)to;
- (void)addFriend:(NSString *)name;
-(void)createChatRoom;
@end
