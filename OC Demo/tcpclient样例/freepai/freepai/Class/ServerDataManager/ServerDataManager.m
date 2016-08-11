//
//  ServerDataManager.m
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ServerDataManager.h"
#import "ServerCmdHandler.h"
#import "CacheDataManager.h"
#import "XMPPDataManager.h"

@implementation ServerDataManager

+(ServerDataManager *)sharedInstance
{
    static ServerDataManager *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

//客户端验证码获取端口（ClientGetMobilePhoneTokenAuthorized）
-(void)requestMobileToken:(NSString *)phoneNum completeBlock:(requestRes)completeBlock
{
    NSString *authstr = [NSString stringWithFormat:@"%@+%@", phoneNum, req_getPhoneToken];
    
    NSDictionary* dataParams = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum, @"mobilephone", nil];
    
    [[ServerCmdHandler sharedInstance]sendReqCmd:req_getPhoneToken needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res) {
        if (res && [res isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)res;
            if (operation.response.statusCode == 200) {
                [CacheDataManager sharedInstance].userName = phoneNum;
                [CacheDataManager sharedInstance].regPhoneNum = phoneNum;
            }
        }
        completeBlock(res);
    }];
}


//客户端用户注册接口（ClientAccountRegister）
-(void)requestAccountRegister:(NSString *)phoneNum Username:(NSString *)username Password:(NSString *)password Resource:(NSString *)resource Platform:(NSString *)platform Veriftycode:(NSString *)veriftycode completeBlock:(requestRes)completeBlock
{
    NSString *userName = [BaseTools getEncodeBase64String:[BaseTools getURLStringFromString:username]];
    NSString *passwd = [BaseTools getEncodeBase64String:[BaseTools getURLStringFromString:password]];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@+%@+%@+%@",phoneNum,userName,passwd,resource,platform,veriftycode,req_accountRegister];
    
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum,@"mobilephone",userName,@"username",passwd,@"password",resource,@"resource",platform,@"platform",veriftycode,@"veriftycode", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_accountRegister needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        if (res && [res isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)res;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    [CacheDataManager sharedInstance].userName = username;
                    [CacheDataManager sharedInstance].password = password;
                    [CacheDataManager sharedInstance].inviteCode = [dataObject objectForKey:@"invite_code"];
                    [CacheDataManager sharedInstance].platform = [dataObject objectForKey:@"platform"];
                    [CacheDataManager sharedInstance].uuid = [dataObject objectForKey:@"uuid"];
                    [CacheDataManager sharedInstance].resource =@"None";
                    
                    
                    //try regist and login XMPP
                    NSLog(@"尝试注册XMPP账号");
                    [[XMPPDataManager instance]connectToServer:XMPP_SERVER userName:userName passwd:password];
                    
                }
            }
        }
        completeBlock(res);
        /*
        if (res) {
            if ([res isKindOfClass:[NSDictionary class]]) {
                id dataObject = [res objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    [CacheDataManager sharedInstance].userName = username;
                    [CacheDataManager sharedInstance].password = password;
                    [CacheDataManager sharedInstance].inviteCode = [dataObject objectForKey:@"invite_code"];
                    [CacheDataManager sharedInstance].platform = [dataObject objectForKey:@"platform"];
                    [CacheDataManager sharedInstance].uuid = [dataObject objectForKey:@"uuid"];
                    [CacheDataManager sharedInstance].resource =@"None";
                }
            }
        }
         */
        completeBlock(res);
    }];
}


//客户端用户登陆接口（ClientUserLogin）
-(void)requestUserLogin:(NSString *)username Password:(NSString *)password completeBlock:(requestRes)completeBlock
{
    NSString *userName = [BaseTools getEncodeBase64String:[BaseTools getURLStringFromString:username]];
    NSString *passwd = [BaseTools getEncodeBase64String:[BaseTools getURLStringFromString:password]];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@",userName,passwd,req_userLogin];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"username",passwd,@"password", nil];
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_userLogin needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        if (res && [res isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)res;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    if (![[dataObject objectForKey:@"inform"] isEqualToString:@"None"]) {
                        NSData *jsondata = [[dataObject objectForKey:@"inform"] dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary * result = [BaseTools decodeJsonString:jsondata];
                        [CacheDataManager sharedInstance].userActivity = [result objectForKey:@"activity"];
                        [CacheDataManager sharedInstance].userUnderLineCount = [result objectForKey:@"underlingcount"];
                        [CacheDataManager sharedInstance].uuid = [dataObject objectForKey:@"uuid"];
                        [CacheDataManager sharedInstance].inviteCode = [dataObject objectForKey:@"invite_code"];
                        [CacheDataManager sharedInstance].userName = username;
                        [CacheDataManager sharedInstance].regPhoneNum = username;
                        [CacheDataManager sharedInstance].password = password;
                        
                        //try conn XMPP Server
                        [[XMPPDataManager instance]connectToServer:XMPP_SERVER userName:username passwd:password];
                    }
                }
            }
        }
        /*
        if (res) {
            if ([res isKindOfClass:[NSDictionary class]]) {
                id dataObject = [res objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    NSError *error = nil;
                    NSData *jsondata = [[dataObject objectForKey:@"inform"] dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary * result = [NSJSONSerialization JSONObjectWithData:jsondata
                                                                            options:NSJSONReadingMutableLeaves
                                                                              error:&error];
                    
                    
                    [CacheDataManager sharedInstance].userActivity = [result objectForKey:@"activity"];
                    [CacheDataManager sharedInstance].userUnderLineCount = [result objectForKey:@"underlingcount"];
                    
                    [CacheDataManager sharedInstance].uuid = [dataObject objectForKey:@"uuid"];
                    [CacheDataManager sharedInstance].inviteCode = [dataObject objectForKey:@"invite_code"];
                    [CacheDataManager sharedInstance].userName = username;
                    [CacheDataManager sharedInstance].regPhoneNum = username;
                    [CacheDataManager sharedInstance].password = password;
                }
            }
        }
         */
        completeBlock(res);
    }];
}


//客户端信息完善接口（ClientImproveInformation）
-(void)requestImproveInformation:(NSString *)username Password:(NSString *)password Code:(NSString *)code Pushtoken:(NSString *)pushtoken completeBlock:(requestRes)completeBlock
{
    NSString *userName = [BaseTools getEncodeBase64String:[BaseTools getURLStringFromString:username]];
    NSString *passwd = [BaseTools getEncodeBase64String:[BaseTools getURLStringFromString:password]];
    
    NSDictionary *dataDict = @{@"code":code,@"pushtoken":pushtoken};
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",userName,passwd,data,req_improveInformation];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"username",passwd,@"password",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_improveInformation needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//客户端用户推送token完善（ClientPushTokenComplete）
- (void) requestPushTokenComplete:(NSString *)UUID PushToken:(NSString *)pushtoken completeBlock:(requestRes)completeBlock
{
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@",UUID,pushtoken,req_pushTokenComplete];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",pushtoken,@"pushtoken", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_pushTokenComplete needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//客户端创建门派（ClientUserCreateTeam）
-(void)requestUserCreateTeam:(NSString *)UUID TeamName:(NSString *)teamname completeBlock:(requestRes)completeBlock
{
    NSString *base64Team_name = [BaseTools getEncodeBase64String:teamname];
    
    NSDictionary *dataDict = @{@"team_name":[BaseTools getURLStringFromString:base64Team_name]};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@",UUID,data,req_userCreateTeam];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_userCreateTeam needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        if (res && [res isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)res;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    if (![[dataObject objectForKey:@"uuid"] isEqualToString:@"None"] && [[dataObject objectForKey: @"team_id"] intValue] >0 && [[dataObject objectForKey: @"team_count"] intValue] >0) {
                        [CacheDataManager sharedInstance].ownerTeamName = teamname;
                        [CacheDataManager sharedInstance].ownerTeamID = [dataObject objectForKey:@"team_id"];
                        [CacheDataManager sharedInstance].ownerTeamMemberCount = [dataObject objectForKey:@"team_count"];
                    }
                }
            }
        }
        /*
        if (res) {
            if ([res isKindOfClass:[NSDictionary class]]) {
                id dataObject = [res objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    [CacheDataManager sharedInstance].ownerTeamName = teamname;
                    [CacheDataManager sharedInstance].ownerTeamID = [dataObject objectForKey:@"team_id"];
                    [CacheDataManager sharedInstance].ownerTeamMemberCount = [dataObject objectForKey:@"team_count"];
                }
            }
        }
         */
        completeBlock(res);
    }];
}

//客户端帮派总人数及活跃度查询（ClientSearchCountAndActivity）
-(void)requestCountAndActivity:(NSString *)UUID LoginResource:(NSString *)loginresource TeamID:(NSString *)teamid completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"team_id":teamid};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_searchCountAndActivity];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_searchCountAndActivity needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
    
}

//客户端帮派精确查询（ClientTeamPreciseQuery）
- (void) requestTeamPreciseQuery:(NSString *)UUID LoginResource:(NSString *)loginresource TeamName:(NSString *)teamname completeBlock:(requestRes)completeBlock
{
    NSString *base64Team_name = [BaseTools getEncodeBase64String:teamname];
    
    NSDictionary *dataDict = @{@"team_name":[BaseTools getURLStringFromString:base64Team_name]};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_teamPreciseQuery];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_teamPreciseQuery needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//客户端加入帮派申请（ClientTeamPaperApply）
- (void) requestTeamPaperApply:(NSString *)UUID LoginResource:(NSString *)loginresource TeamID:(NSString *)teamid completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"team_id":teamid};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_teamPaperApply];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_teamPaperApply needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//客户端帮派成员列表查询（ClientTeamMemberList）
- (void) requestTeamMemberList:(NSString *)UUID LoginResource:(NSString *)loginresource TeamID:(NSString *)teamid completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"team_id":teamid};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_teamMemberList];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_teamMemberList needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//客户端自建门派和加入门派查询(ClientUserTeamSelect)
- (void) requestUserTeam:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":request};
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_userTeamSelect];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_userTeamSelect needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        if (res && [res isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)res;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    if ([[dataObject objectForKey:@"self_party_id"] intValue]>0) {
                        [CacheDataManager sharedInstance].ownerTeamID = [dataObject objectForKey:@"self_party_id"];
                        NSString * strFromURL = [BaseTools getStringFromURLString:[dataObject objectForKey:@"self_party_name"]];
                        [CacheDataManager sharedInstance].ownerTeamName = [BaseTools getDecodeBase64String:strFromURL];
                    }
                }
            }
        }
        /*
        if (res) {
            if ([res isKindOfClass:[NSDictionary class]]) {
                id dataObject = [res objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    if ([[dataObject objectForKey:@"self_party_id"] intValue]>0) {
                        [CacheDataManager sharedInstance].ownerTeamID = [dataObject objectForKey:@"self_party_id"];
                        NSString * strFromURL = [BaseTools getStringFromURLString:[dataObject objectForKey:@"self_party_name"]];
                        [CacheDataManager sharedInstance].ownerTeamName = [BaseTools getDecodeBase64String:strFromURL];
                    }
                }
            }
        }
         */
        completeBlock(res);
    }];
}





//////////////////////自由派-消息系统//////////////////////
//6.1系统邮件 主页滚动发送接口（ClientMainPageMessageRoll）
//#define req_MainPageMessageRoll @"ClientMainPageMessageRoll"
-(void) requestMainPageMessageRoll:(NSString *)UUID LoginResource:(NSString *)loginresource ToUUID:(NSString *)touuid Title:(NSString *)title context:(NSString *)context completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"to_uuid":touuid,@"title":title,@"context":context};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_MainPageMessageRoll];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_MainPageMessageRoll needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//6.2系统邮件 主页滚动获取（ClientMainPageMessageRollGet）
//#define req_MainPageMessageRollGet @"ClientMainPageMessageRollGet"
-(void) requestMainPageMessageRollGet:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":request};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_MainPageMessageRollGet];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_MainPageMessageRollGet needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//6.3系统邮件 消息发送接口（ClientSingleMessageSend）
//#define req_SingleMessageSend @"ClientSingleMessageSend"
-(void) requestSingleMessageSend:(NSString *)UUID LoginResource:(NSString *)loginresource ToUUID:(NSString *)touuid Title:(NSString *)title context:(NSString *)context completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"to_uuid":touuid,@"title":title,@"context":context};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_MainPageMessageRoll];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_MainPageMessageRoll needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//6.4系统邮件 消息盒接口（ClientSingleMessageBox）
//#define req_SingleMessageBox @"ClientSingleMessageBox"
-(void) requestSingleMessageBox:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request Operation:(NSString *)operation startID:(NSString *)startID completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":request,@"operation":operation,@"start_id":startID};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_SingleMessageBox];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_SingleMessageBox needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}



//////////////////////自由派-排行、活动、积分//////////////////////
//7.2用户查询当前所有可用广告（ClientSearchAllAdv）
//#define req_SearchAllAdv @"ClientSearchAllAdv"
-(void) requestSearchAllAdv:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":request};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_SearchAllAdv];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_SearchAllAdv needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//7.3用户查询当前广告状态（ClientSearchAdvStatus）
//#define req_SearchAdvStatus @"ClientSearchAdvStatus"
-(void) requestSearchAdvStatus:(NSString *)UUID LoginResource:(NSString *)loginresource AdvID:(NSString *)AdvID completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"adv_id":AdvID};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_SearchAdvStatus];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_SearchAdvStatus needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//7.4用户提交当前广告到达率（ClientSearchAdvReach）
//#define req_SearchAdvReach @"ClientSearchAdvReach"
-(void) requestSearchAdvReach:(NSString *)UUID LoginResource:(NSString *)loginresource AdvID:(NSString *)AdvID completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"adv_id":AdvID};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_SearchAdvReach];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_SearchAdvReach needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//7.5用户查询游戏状态（UserSearchGameStatus）
//#define req_UserSearchGameStatus @"UserSearchGameStatus"
-(void) requestUserSearchGameStatus:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":request};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_UserSearchGameStatus];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_UserSearchGameStatus needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//7.6用户提交 游戏到达状态（UserUpdateGameStatus）
//#define req_UserUpdateGameStatus @"UserUpdateGameStatus"
-(void) requestUserUpdateGameStatus:(NSString *)UUID LoginResource:(NSString *)loginresource GameID:(NSString *)GameID completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"game_id":GameID};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_UserUpdateGameStatus];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_UserUpdateGameStatus needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}


//7.8自由派用户积分查询（UserPointOwnerSearch）
//#define req_UserPointOwnerSearch @"UserPointOwnerSearch"
-(void) requestUserPointOwnerSearch:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":request};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_UserPointOwnerSearch];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_UserPointOwnerSearch needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        if (res && [res isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)res;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    [CacheDataManager sharedInstance].userIntegral = [dataObject objectForKey:@"now"];
                }
            }
        }
        /*
        if (res) {
            DLog(@"%@",res);
            if ([res isKindOfClass:[NSDictionary class]]) {
                id dataObject = [res objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    [CacheDataManager sharedInstance].userIntegral = [dataObject objectForKey:@"now"];
                    DLog(@"%@", [CacheDataManager sharedInstance].userIntegral);
                }
            }
        }
         */
        completeBlock(res);
    }];
}

//7.9客户端积分修改接口（ClientPointsOperation）
//#define req_PointsOperation @"ClientPointsOperation"
-(void) requestPointsOperation:(NSString *)UUID LoginResource:(NSString *)loginresource GameID:(NSString *)GameID Operation:(NSString *)operation Count:(NSString *)count completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"game_id":GameID,@"operation":operation,@"count":count};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_PointsOperation];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_PointsOperation needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//7.11游戏用户成绩排行查询（GameUserScoreBoard）
//#define req_GameUserScoreBoard @"GameUserScoreBoard"
-(void) requestGameUserScoreBoard:(NSString *)UUID LoginResource:(NSString *)loginresource GameID:(NSString *)GameID completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"game_id":GameID,@"user_id":UUID};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_GameUserScoreBoard];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_GameUserScoreBoard needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//申请发放红包接口(SendMoneyToPeople)
-(void) requestSendMoneyToPeople:(NSString *)UUID LoginResource:(NSString *)loginresource money:(NSString *)money count:(NSString *)count priority:(NSString *)priority completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"money":money,@"count":count,@"priority":priority};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_SendMoneyToPeople];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_SendMoneyToPeople needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//用户查询红包接口(GetSendMoneyForMe)
-(void) requestGetSendMoneyForMe:(NSString *)UUID LoginResource:(NSString *)loginresource completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":@"None"};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_GetSendMoneyForMe];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_GetSendMoneyForMe needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//发送用户查询发送结果接口(SearchMoneyListForSend)
-(void) requestSearchMoneyListForSend:(NSString *)UUID LoginResource:(NSString *)loginresource completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":@"None"};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_SearchMoneyListForSend];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_SearchMoneyListForSend needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];

}


//用户抢红包接口(AttackSendMoneyFast)
-(void)requestAttackSendMoneyFast:(NSString *)UUID LoginResource:(NSString *)loginresource BelongUserID:(NSString *)BelongUserID SendTimeSP:(NSString *)sendtimesp completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"belong_user_id":BelongUserID,@"get_timestamp":sendtimesp};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_AttackSendMoneyFast];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_AttackSendMoneyFast needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//竞价首页查询(PPCFirstPageListSearch)
-(void)requestPPCFirstPageList:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"request":request};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_PPCFirstPageListSearch];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_PPCFirstPageListSearch needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}

//用户竞价申请(UserBuddingif)
-(void)requestUserBuddingif:(NSString *)UUID LoginResource:(NSString *)loginresource BiddingID:(NSString *)BiddingID Price:(NSString *)Price completeBlock:(requestRes)completeBlock
{
    NSDictionary *dataDict = @{@"bidding_id":BiddingID,@"price":Price};
    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *authstr = [NSString stringWithFormat:@"%@+%@+%@+%@",UUID,loginresource,data,req_UserBuddingif];
    
    NSDictionary *dataParams = [NSDictionary dictionaryWithObjectsAndKeys:UUID,@"uuid",loginresource,@"loginResource",data,@"data", nil];
    
    [[ServerCmdHandler sharedInstance] sendReqCmd:req_UserBuddingif needHashStr:authstr reqParams:dataParams isGetType:req_post completBlock:^(id res){
        completeBlock(res);
    }];
}
@end
