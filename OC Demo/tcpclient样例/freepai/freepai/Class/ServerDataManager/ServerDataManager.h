//
//  ServerDataManager.h
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^requestRes)(id reqRes);
@interface ServerDataManager : NSObject

@property NSArray *cellArr;



+ (ServerDataManager *) sharedInstance;


//客户端验证码获取端口（ClientGetMobilePhoneTokenAuthorized）
- (void) requestMobileToken:(NSString*)phoneNum completeBlock:(requestRes)completeBlock;

//客户端用户注册接口（ClientAccountRegister）
- (void) requestAccountRegister:(NSString *)phoneNum Username:(NSString *)username Password:(NSString *)password Resource:(NSString *)resource Platform:(NSString *)platform Veriftycode:(NSString *)veriftycode completeBlock:(requestRes)completeBlock;

//客户端用户登陆接口（ClientUserLogin
- (void) requestUserLogin:(NSString *)username Password:(NSString *)password completeBlock:(requestRes)completeBlock;


//客户端信息完善接口（ClientImproveInformation）
- (void) requestImproveInformation:(NSString *)username Password:(NSString *)password Code:(NSString *)code Pushtoken:(NSString *)pushtoken completeBlock:(requestRes)completeBlock;

//客户端用户推送token完善（ClientPushTokenComplete）
- (void) requestPushTokenComplete:(NSString *)UUID PushToken:(NSString *)pushtoken completeBlock:(requestRes)completeBlock;

//客户端创建门派（ClientUserCreateTeam）
- (void) requestUserCreateTeam:(NSString *)UUID TeamName:(NSString *)teamname completeBlock:(requestRes)completeBlock;

//客户端帮派总人数及活跃度查询（ClientSearchCountAndActivity）
- (void) requestCountAndActivity:(NSString *)UUID LoginResource:(NSString *)loginresource TeamID:(NSString *)teamid completeBlock:(requestRes)completeBlock;

//客户端帮派精确查询（ClientTeamPreciseQuery）
- (void) requestTeamPreciseQuery:(NSString *)UUID LoginResource:(NSString *)loginresource TeamName:(NSString *)teamname completeBlock:(requestRes)completeBlock;

//客户端加入帮派申请（ClientTeamPaperApply）
- (void) requestTeamPaperApply:(NSString *)UUID LoginResource:(NSString *)loginresource TeamID:(NSString *)teamid completeBlock:(requestRes)completeBlock;

//客户端帮派成员列表查询（ClientTeamMemberList）
- (void) requestTeamMemberList:(NSString *)UUID LoginResource:(NSString *)loginresource TeamID:(NSString *)teamid completeBlock:(requestRes)completeBlock;

//客户端自建门派和加入门派查询(ClientUserTeamSelect)
- (void) requestUserTeam:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock;




//////////////////////自由派-消息系统//////////////////////
//6.1系统邮件 主页滚动发送接口（ClientMainPageMessageRoll）
//#define req_MainPageMessageRoll @"ClientMainPageMessageRoll"
-(void) requestMainPageMessageRoll:(NSString *)UUID LoginResource:(NSString *)loginresource ToUUID:(NSString *)touuid Title:(NSString *)title context:(NSString *)context completeBlock:(requestRes)completeBlock;

//6.2系统邮件 主页滚动获取（ClientMainPageMessageRollGet）
//#define req_MainPageMessageRollGet @"ClientMainPageMessageRollGet"
-(void) requestMainPageMessageRollGet:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock;

//6.3系统邮件 消息发送接口（ClientSingleMessageSend）
//#define req_SingleMessageSend @"ClientSingleMessageSend"
-(void) requestSingleMessageSend:(NSString *)UUID LoginResource:(NSString *)loginresource ToUUID:(NSString *)touuid Title:(NSString *)title context:(NSString *)context completeBlock:(requestRes)completeBlock;

//6.4系统邮件 消息盒接口（ClientSingleMessageBox）
//#define req_SingleMessageBox @"ClientSingleMessageBox"
-(void) requestSingleMessageBox:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request Operation:(NSString *)operation startID:(NSString *)startID completeBlock:(requestRes)completeBlock;


//////////////////////自由派-排行、活动、积分//////////////////////
//7.2用户查询当前所有可用广告（ClientSearchAllAdv）
//#define req_SearchAllAdv @"ClientSearchAllAdv"
-(void) requestSearchAllAdv:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock;

//7.3用户查询当前广告状态（ClientSearchAdvStatus）
//#define req_SearchAdvStatus @"ClientSearchAdvStatus"
-(void) requestSearchAdvStatus:(NSString *)UUID LoginResource:(NSString *)loginresource AdvID:(NSString *)AdvID completeBlock:(requestRes)completeBlock;

//7.4用户提交当前广告到达率（ClientSearchAdvReach）
//#define req_SearchAdvReach @"ClientSearchAdvReach"
-(void) requestSearchAdvReach:(NSString *)UUID LoginResource:(NSString *)loginresource AdvID:(NSString *)AdvID completeBlock:(requestRes)completeBlock;

//7.5用户查询游戏状态（UserSearchGameStatus）
//#define req_UserSearchGameStatus @"UserSearchGameStatus"
-(void) requestUserSearchGameStatus:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock;

//7.6用户提交 游戏到达状态（UserUpdateGameStatus）
//#define req_UserUpdateGameStatus @"UserUpdateGameStatus"
-(void) requestUserUpdateGameStatus:(NSString *)UUID LoginResource:(NSString *)loginresource GameID:(NSString *)GameID completeBlock:(requestRes)completeBlock;


//7.8自由派用户积分查询（UserPointOwnerSearch）
//#define req_UserPointOwnerSearch @"UserPointOwnerSearch"
-(void) requestUserPointOwnerSearch:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock;

//7.9客户端积分修改接口（ClientPointsOperation）
//#define req_PointsOperation @"ClientPointsOperation"
-(void) requestPointsOperation:(NSString *)UUID LoginResource:(NSString *)loginresource GameID:(NSString *)GameID Operation:(NSString *)operation Count:(NSString *)count completeBlock:(requestRes)completeBlock;

//7.11游戏用户成绩排行查询（GameUserScoreBoard）
//#define req_GameUserScoreBoard @"GameUserScoreBoard"
-(void) requestGameUserScoreBoard:(NSString *)UUID LoginResource:(NSString *)loginresource GameID:(NSString *)GameID completeBlock:(requestRes)completeBlock;


//申请发放红包接口(SendMoneyToPeople)
-(void) requestSendMoneyToPeople:(NSString *)UUID LoginResource:(NSString *)loginresource money:(NSString *)money count:(NSString *)count priority:(NSString *)priority completeBlock:(requestRes)completeBlock;

//用户查询红包接口(GetSendMoneyForMe)
-(void) requestGetSendMoneyForMe:(NSString *)UUID LoginResource:(NSString *)loginresource completeBlock:(requestRes)completeBlock;


//发送用户查询发送结果接口(SearchMoneyListForSend)
-(void) requestSearchMoneyListForSend:(NSString *)UUID LoginResource:(NSString *)loginresource completeBlock:(requestRes)completeBlock;

//用户抢红包接口(AttackSendMoneyFast)
-(void)requestAttackSendMoneyFast:(NSString *)UUID LoginResource:(NSString *)loginresource BelongUserID:(NSString *)BelongUserID SendTimeSP:(NSString *)sendtimesp completeBlock:(requestRes)completeBlock;

//竞价首页查询(PPCFirstPageListSearch)
-(void)requestPPCFirstPageList:(NSString *)UUID LoginResource:(NSString *)loginresource Request:(NSString *)request completeBlock:(requestRes)completeBlock;

//用户竞价申请(UserBuddingif)
-(void)requestUserBuddingif:(NSString *)UUID LoginResource:(NSString *)loginresource BiddingID:(NSString *)BiddingID Price:(NSString *)Price completeBlock:(requestRes)completeBlock;
@end
