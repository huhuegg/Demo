//
//  LocalDataManager.h
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
//UserInfo
//userName(用户名) password(密码) regPhoneNum(注册使用的手机号码) inviteCode(邀请码) resource(广告识别码) uuid(app用户唯一ID) platform(用户登录平台) finished（个人信息完善状态）

//OwnerTeam
//ownerTeamID(自建帮派ID) ownerTeamName teamCount（自建帮派总人数）teamActivity(自建帮派活跃度)
typedef enum : NSUInteger {
    TableUserInfoColumn_userName,
    TableUserInfoColumn_password,
    TableUserInfoColumn_regPhoneNum,
    TableUserInfoColumn_inviteCode,
    TableUserInfoColumn_resource,
    TableUserInfoColumn_uuid,
    TableUserInfoColumn_platform,
    TableUserInfoColumn_finished,
    TableOwnerTeamColumn_ownerTeamID,
    TableOwnerTeamColumn_ownerTeamName,
    TableOwnerTeamColumn_teamCount,
    TableOwnerTeamColumn_teamActivity,
} TableColumn;

@interface LocalDataManager : NSObject

+(LocalDataManager *)sharedInstance;

@property NSArray *cellArr;


-(void)initializeDB;
-(void)cleanDB;
-(NSString *)searchTableForColumn:(TableColumn)tablecolumn;
-(void)updateTableColumn:(TableColumn)tablecolumn WithValue:(NSString *)value;

-(void)UpdateTableUserInfoWith:(NSString *)username and:(NSString *)password;
@end
