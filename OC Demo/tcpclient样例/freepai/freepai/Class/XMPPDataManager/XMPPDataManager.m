//
//  XMPPDataManager.m
//  xmppTest
//
//  Created by admin on 14/6/27.
//  Copyright (c) 2014年 me.ieggs. All rights reserved.
//

#import "XMPPDataManager.h"

@implementation XMPPDataManager
@synthesize xmppRoster;
@synthesize xmppRosterstorage;
@synthesize xmppRoom;
@synthesize xmppRoomCoreDataStorate;

+(XMPPDataManager *)instance {
    static XMPPDataManager *instance = nil;
    /*
     dispatch_once_t 变量只是标识_dispatch_once的执行情况，当once已经被使用时，dispatch_once方法将不执行内容；
     */
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[XMPPDataManager alloc]init];
        instance.notificationCenter = [NSNotificationCenter defaultCenter];
    });
    return instance;
}

-(void)setupStream{
    NSLog(@"setupStream:初始化XMPPStream");
    //初始化XMPPStream
    _xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];

    //设置后台也进行连接
    _xmppStream.enableBackgroundingOnSocket = YES;
    
    
    xmppRosterstorage = [[XMPPRosterCoreDataStorage alloc]init];
    
    xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:xmppRosterstorage];
    
    [xmppRoster activate:_xmppStream];
    
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    

}

//设置为在线
-(void)goOnline{
    NSLog(@"goOnline:设置状态为在线");
    //发送在线状态
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
    
}

//设置为离线
-(void)goOffline{
    NSLog(@"onOffline:设置状态为离线");
    //发送下线状态
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
    
}

//连接服务器
-(BOOL)connectToServer:(NSString *)serverAddr userName:(NSString *)userName passwd:(NSString *)passwd {
    NSLog(@"connect:连接服务器");
    [self setupStream];
    _serverAddr = serverAddr;
    _userName = userName;
    _passwd = passwd;
    
    
    if (![_xmppStream isDisconnected]) {
        return YES;
    }
    
    NSString *jidStr = [[NSString alloc]initWithFormat:@"%@@%@",_userName,XMPP_SERVER];
    //设置用户
    [_xmppStream setMyJID:[XMPPJID jidWithString:jidStr]];
    
    NSLog(@"设置当前用户为:%@",jidStr);
    //设置服务器
    [_xmppStream setHostName:_serverAddr];
    NSLog(@"设置服务器地址为:%@",_serverAddr);
    
    [self setPasswd:_passwd];
    
    //连接服务器
    NSError *error = nil;
    if (![_xmppStream connectWithTimeout:10 error:&error]) {
        NSLog(@"无法连接到 %@", _serverAddr);
        return NO;
    }
    
    return YES;
    
}

//断开连接
-(void)disconnect{
    NSLog(@"设置用户状态为离线");
    [self goOffline];
    NSLog(@"disconnect:断开与服务器连接");
    [_xmppStream disconnect];
    
}



- (void)xmppStreamWillConnect:(XMPPStream *)sender {
    NSLog(@"xmppStreamWillConnect");
}


//连接服务器
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"xmppStreamDidConnect:已连接到服务器");
    _isOpen = YES;
    [self registPasswd];
}

//注册
-(void)registPasswd{
    NSError *error = nil;
    [_xmppStream registerWithPassword:_passwd error:&error];
    NSLog(@"账号%@ 注册,密码:%@",_userName,_passwd);
}

//没有注册成功
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error {
    NSLog(@"没有注册成功:%@",[error stringValue]);
    [self authPasswd];
}

//注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender {
    NSLog(@"注册成功");
    [self authPasswd];
}

//密码验证
-(void)authPasswd {
    NSError *error = nil;
    //验证密码
    [[self xmppStream] authenticateWithPassword:_passwd error:&error];
    NSLog(@"密码验证:%@",error);
}

//密码验证不成功
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error {
    NSLog(@"xmppStreamDidAuthenticate:用户的密码验证失败");
}

//密码验证成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"xmppStreamDidAuthenticate:用户的密码验证成功");
    [self.notificationCenter postNotificationName:@"alreadyAuth" object:_userName];
    [self goOffline];
}

//收到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    NSLog(@"didReceiveMessage:收到消息");
    
    NSLog(@"message = %@", message);
    /*
     //系统消息 暂未处理
     <message xmlns="jabber:client" from="openfire.ieggs.me"><body>3</body></message>
     
     //聊天消息
     <message xmlns="jabber:client" type="chat" id="purple1940b71a" to="user3@openfire.ieggs.me/26e4caf0" from="user1@openfire.ieggs.me/admindeMac-mini"><active xmlns="http://jabber.org/protocol/chatstates"/><body>from</body></message>
     */

    NSString *type = [[message attributeForName:@"type"] stringValue];
    NSString * fromAccount = [[message attributeForName:@"from"] stringValue];
    
    //消息内容
    NSString *msg = [[message elementForName:@"body"] stringValue];
    if (msg) {
        //NSLog(@"[XMPPDataManager] %@ => %@  msg:%@",fromAccount,toAccount,msg);
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSString * toAccount = [[message attributeForName:@"to"] stringValue];
        [dict setObject:type forKey:@"type"];
        [dict setObject:fromAccount forKey:@"fromAccount"];
        [dict setObject:toAccount forKey:@"toAccount"];
        [dict setObject:msg forKey:@"msg"];

        [self.notificationCenter postNotificationName:@"msgReceived" object:dict];
    }
}


//收到好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    NSLog(@"didReceivePresence:收到好友状态");
    /*
     在无好友的时候 from 和 to 内容一致
     <presence xmlns="jabber:client" from="user3@openfire.ieggs.me/754d253a" to="user3@openfire.ieggs.me/754d253a"/>
    */
    NSLog(@"presence = %@", presence);
    
    /* test error
     //获取好友列表
    NSLog(@"获取好友列表");
    [_xmppRoster fetchRoster];
    */

    
    
    //取得好友状态
    NSString *presenceType = [presence type]; //online/offline
    //当前用户
    NSString *userId = [[sender myJID] user];
    //在线用户
    NSString *presenceFromUser = [[presence from] user];
    
    if (![presenceFromUser isEqualToString:userId]) {
        
        //在线状态
        if ([presenceType isEqualToString:@"available"]) {
            
            //用户列表委托(后面讲)
            //[chatDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"nqc1338a"]];
            
        }else if ([presenceType isEqualToString:@"unavailable"]) {
            //用户列表委托(后面讲)
            //[chatDelegate buddyWentOffline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"nqc1338a"]];
        }
        
    }
    
}

//发送消息
-(void)sendMsg:(NSString *)msg type:(NSString *)type from:(NSString *)from to:(NSString *)to {
    NSLog(@"sendMsg msg:%@ from:%@ to:%@",msg,from,to);
    NSString *jidFrom = [[NSString alloc]initWithFormat:@"%@@%@",from,XMPP_SERVER];
    NSString *jidTo = [[NSString alloc]initWithFormat:@"%@@%@",to,XMPP_SERVER];
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:msg];
    
    //生成XML消息文档
    NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
    //消息类型
    [mes addAttributeWithName:@"type" stringValue:@"chat"];
    //发送给谁
    [mes addAttributeWithName:@"to" stringValue:jidTo];
    //由谁发送
    [mes addAttributeWithName:@"from" stringValue:jidFrom];
    //组合
    [mes addChild:body];
    
    //发送消息
    [_xmppStream sendElement:mes];
    

}


//获取到一个好友节点 ?????
- (void)xmppRoster:(XMPPRoster *)sender didRecieveRosterItem:(NSXMLElement *)item {
    NSLog(@"获取到一个好友节点");
}


//获取完好友列表
- (void)xmppRosterDidEndPopulating:(XMPPRoster *)sender {
    NSLog(@"获取好友列表操作完成:%@",sender);
}

//添加好友 ok
- (void)addFriend:(NSString *)name
{
    XMPPJID *jid = [XMPPJID jidWithString:name];
    NSLog(@"添加好友:%@",jid);
    [xmppRoster addUser:jid withNickname:@"nickname"];
    
}

//收到添加好友的请求 ok
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    NSLog(@"收到添加好友的请求");
    //取得好友状态
    NSString *presenceType = [NSString stringWithFormat:@"%@", [presence type]]; //online/offline
    //请求的用户
    NSString *presenceFromUser =[NSString stringWithFormat:@"%@", [[presence from] user]];
    NSLog(@"请求来自用户%@ 状态:%@",presenceFromUser ,presenceType);
    
    NSLog(@"presence2:%@  sender2:%@",presence,sender);
    
    XMPPJID *jid = [XMPPJID jidWithString:presenceFromUser];
    //接收添加好友请求
    [xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
    
}

//初始化聊天室 ???
-(void)createChatRoom {
    //初始化聊天室
    NSLog(@"初始化聊天室");
    XMPPJID *roomJID = [XMPPJID jidWithString:@"createChatRoom1"];

    xmppRoomCoreDataStorate = [[XMPPRoomCoreDataStorage alloc]initWithInMemoryStore];
    xmppRoom = [[XMPPRoom alloc] initWithRoomStorage:xmppRoomCoreDataStorate jid:roomJID];
    
    [xmppRoom activate:_xmppStream];
    [xmppRoom addDelegate:self delegateQueue:dispatch_get_main_queue()];

}

//创建聊天室成功 ???
- (void)xmppRoomDidCreate:(XMPPRoom *)sender
{
    NSLog(@"创建聊天室成功");
}



@end
