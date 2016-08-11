//
//  DBOperation.h
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBOperation : NSObject
+(DBOperation *)sharedInstance;

/************************个人信息表**********************/
//userName(用户名) password(密码) regPhoneNum(注册使用的手机号码) inviteCode(邀请码) resource(广告识别码) uuid(app用户唯一ID) platform(用户登录平台) finished（个人信息完善状态）
-(void)createUserInfoTable;
-(void)cleanUserInfo;

/************************自建帮派信息表**********************/
//ownerTeamID(自建帮派ID) ownerTeamName teamCount（自建帮派总人数）teamActivity(自建帮派活跃度)
-(void)createOwnerTeamTable;
-(void)cleanOwnerTeam;

-(NSString *)searchWithSQL:(NSString *)sql Column:(NSString *)Column;
-(void)updateWithSQL:(NSString *)sql;
-(void)UpdateTableUserInfoWith:(NSString *)username and:(NSString *)password;


/************************我的支付宝账户表**********************/
//Account(支付宝账号)
-(void)createMyAccountTable;
-(void)insertMyAccountTableWithAccount:(NSString *)myaccount;
-(NSMutableArray *)searchTableForMyAccount;
-(void)deleteAccount:(NSString *)account;

/************************我的支付宝账户表**********************/
//person(收货人) postcode(收货人邮编) telephone:(收货人手机号) area:(收货人所属地区) location:(收货人家庭地址)
-(void)createMyAddressTable;
-(void)insertMyAddressTableWithPerson:(NSString *)person PostCode:(NSString *)postcode Tele:(NSString *)telephone Area:(NSString *)area Location:(NSString *)location;
-(NSMutableArray *)searchTableForAllOfMyAddress;
-(void)deleteMyAddressWithPerson:(NSString *)person PostCode:(NSString *)postcode Tele:(NSString *)telephone Area:(NSString *)area Location:(NSString *)location;
@end
