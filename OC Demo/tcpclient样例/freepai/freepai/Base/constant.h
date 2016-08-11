//
//  constant.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#ifndef freepai_constant_h
#define freepai_constant_h

#define ALERT(title,msg,buttonTitle) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil] show]

/************************RGB取色**********************/
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

/************************日志打印**********************/
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

/************************全局数值**********************/
#define TabViewHeight 48

#define AcceptNetTimeOut 10

#define StatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define FreePaiServerAddress "http://222.73.33.131:50000/"

#define AES_CRYPT_PASS @"freepai@AES"

/************************TCP部分定义**********************/
#define PAI_TCP_SERVER_IP @"222.73.33.131"
#define PAI_TCP_SERVER_PORT 56666

#define TEST_PAI_TCP_SERVER_IP @"127.0.0.1"
#define PAI_PACK_HEAD_LENGTH 52
#define PAI_MAX_LOOP_CHECK_PACK_TIMES 100
#define PAI_MAX_DATA_LENGTH 41942304 //1024*1024*4=4M

/************************XMPP部分定义**********************/
#define XMPP_SERVER @"222.73.60.153"

/************************网络接口参数部分**********************/
#define req_getPhoneToken @"ClientGetMobilePhoneTokenAuthorized"

#define req_accountRegister @"ClientAccountRegister"

#define req_userLogin @"ClientUserLogin"

#define req_improveInformation @"ClientImproveInformation"

#define req_pushTokenComplete @"ClientPushTokenComplete"

#define req_userCreateTeam @"ClientUserCreateTeam"

#define req_searchCountAndActivity @"ClientSearchCountAndActivity"

#define req_teamPreciseQuery @"ClientTeamPreciseQuery"

#define req_teamPaperApply @"ClientTeamPaperApply"

#define req_userTeamSelect @"ClientUserTeamSelect"

#define req_teamMemberList @"ClientTeamMemberList"

#define req_activityList @"ClientActivityListSearch"

#define req_inviteAward @"ClientSearchInviteFriendByUser"

#define req_reportPerDay @"ClientAdvtopicClick"

#define req_wheelAwardList @"ClientSmallAwardListSearch"

#define req_eightPartyStatus @"ClientSearchEightPartyStatusNow"

#define req_registerEightParty @"ClientGrabBossForEightParty"

#define req_eightPartyResult @"ClientEightPartPointRank"

//八大派帮主设置分钱规则
#define req_EightPartyDistributeRule @"ClientBossSetRuleOfMoney"

//邮件消息盒接口
#define req_MailBoxList @"ClientSingleMessageBox"

//一键消息发送接口
#define req_eightPartySendMsg @"ClientMessageEasyMethod"

//普通用户参与八大派消息
#define req_joinEightPartyMsg @"ClientJoinEightParty"


//////////////////////自由派-消息系统//////////////////////
//6.1系统邮件 主页滚动发送接口（ClientMainPageMessageRoll）
#define req_MainPageMessageRoll @"ClientMainPageMessageRoll"

//6.2系统邮件 主页滚动获取（ClientMainPageMessageRollGet）
#define req_MainPageMessageRollGet @"ClientMainPageMessageRollGet"

//6.3系统邮件 消息发送接口（ClientSingleMessageSend）
#define req_SingleMessageSend @"ClientSingleMessageSend"

//6.4系统邮件 消息盒接口（ClientSingleMessageBox）
#define req_SingleMessageBox @"ClientSingleMessageBox"



//////////////////////自由派-排行、活动、积分//////////////////////
//7.2用户查询当前所有可用广告（ClientSearchAllAdv）
#define req_SearchAllAdv @"ClientSearchAllAdv"

//7.3用户查询当前广告状态（ClientSearchAdvStatus）
#define req_SearchAdvStatus @"ClientSearchAdvStatus"

//7.4用户提交当前广告到达率（ClientSearchAdvReach）
#define req_SearchAdvReach @"ClientSearchAdvReach"

//7.5用户查询游戏状态（UserSearchGameStatus）
#define req_UserSearchGameStatus @"UserSearchGameStatus"

//7.6用户提交 游戏到达状态（UserUpdateGameStatus）
#define req_UserUpdateGameStatus @"UserUpdateGameStatus"

//7.8自由派用户积分查询（UserPointOwnerSearch）
#define req_UserPointOwnerSearch @"UserPointOwnerSearch"

//7.9客户端积分修改接口（ClientPointsOperation）
#define req_PointsOperation @"ClientPointsOperation"

//7.11游戏用户成绩排行查询（GameUserScoreBoard）
#define req_GameUserScoreBoard @"GameUserScoreBoard"

//申请发放红包接口(SendMoneyToPeople)
#define req_SendMoneyToPeople @"SendMoneyToPeople"

//用户查询红包接口(GetSendMoneyForMe)
#define req_GetSendMoneyForMe @"GetSendMoneyForMe"

//发送用户查询发送结果接口(SearchMoneyListForSend)
#define req_SearchMoneyListForSend @"SearchMoneyListForSend"

//用户抢红包接口(AttackSendMoneyFast)
#define req_AttackSendMoneyFast @"AttackSendMoneyFast"

//竞价首页查询(PPCFirstPageListSearch)
#define req_PPCFirstPageListSearch @"PPCFirstPageListSearch"

//用户竞价申请(UserBuddingif)
#define req_UserBuddingif @"UserBiddingif"
#endif
