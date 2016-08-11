//
//  CacheDataManager.h
//  freepai
//
//  Created by huhuegg on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataConstraintsProtocol.h"

@interface CacheDataManager : NSObject<DataConstraintsProtocol>


//个人信息
@property (strong, nonatomic) NSString*  userName;      //用户名
@property (strong, nonatomic) NSString*  password;      //密码
@property (strong, nonatomic) NSString*  regPhoneNum;   //注册使用的手机号码
@property (strong, nonatomic) NSString*  inviteCode;    //邀请码
@property (strong, nonatomic) NSString*  resource;      //广告识别码
@property (strong, nonatomic) NSString*  uuid;          //app用户唯一ID
@property (strong, nonatomic) NSString*  platform;      //用户登录平台
@property (strong, nonatomic) NSString*  finished;      //个人信息完善状态
@property (strong, nonatomic) NSString *devicePushToken;    //用户推送token
@property (strong, nonatomic) NSString *userIntegral;       //用户积分
@property (strong, nonatomic) NSString *userActivity;       //用户活跃度
@property (strong, nonatomic) NSString *userUnderLineCount; //用户下线人数


//自建帮派
@property (strong, nonatomic) NSString* ownerTeamID;        //自建帮派ID
@property (strong, nonatomic) NSString* ownerTeamName;      //自建帮派名称
@property (strong, nonatomic) NSString* ownerTeamActivity;  //自建帮派活跃度
@property (strong, nonatomic) NSString* ownerTeamIntegral;  //自建帮派积分
@property (strong, nonatomic) NSString* ownerTeamMemberCount;  //自建帮派总人数

@property (strong, nonatomic) NSString* MessageStartID;

@property NSMutableDictionary *userInfo;
@property NSMutableArray *msgArray;

@property NSArray *scrollTableCellArr;

@property (strong,nonatomic) NSArray *activityList;
//@property NSArray *personPaiList;
@property NSArray *teamPaiList;
@property NSArray *taskPaiList;
@property NSArray *exchangeList;
@property NSArray *haggleList;
@property NSArray *adList;
@property NSArray *gameList;

@property NSString *haggleRuleInfo;


@property NSArray *yesterdayActivityPointsList;
@property NSArray *lastweekPersonPointsList;
@property NSArray *lastMonthTeamPointList;

@property NSArray *freePaiGameList;
@property NSArray *hotAppList;
@property NSArray *gameFriendBoard;

@property NSArray *redRenvelopeTypeList;
@property NSMutableDictionary *redRenvelopeDict;

@property NSArray *sampleFrinendsList;
@property NSString *lastChatFriend;

@property NSArray *exchangeProjectsList;

+ (CacheDataManager *) sharedInstance;
-(void)save;
-(void)load;
@end
