//
//  LocalDataManager.m
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "LocalDataManager.h"
#import "DBOperation.h"

@implementation LocalDataManager
+(LocalDataManager *)sharedInstance
{
    static LocalDataManager *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(void)initializeDB
{
    [[DBOperation sharedInstance] createUserInfoTable];
    [[DBOperation sharedInstance] createOwnerTeamTable];
    [[DBOperation sharedInstance] createMyAccountTable];
    [[DBOperation sharedInstance] createMyAddressTable];
}

-(void)cleanDB
{
    [[DBOperation sharedInstance] cleanUserInfo];
    [[DBOperation sharedInstance] cleanOwnerTeam];
}

-(void)UpdateTableUserInfoWith:(NSString *)username and:(NSString *)password
{
    [[DBOperation sharedInstance] UpdateTableUserInfoWith:username and:password];
}

-(NSString *)searchTableForColumn:(TableColumn)tablecolumn
{
    NSString *sql = [[NSString alloc] init];
    NSString *column = [[NSString alloc] init];
    if (tablecolumn == TableUserInfoColumn_userName) {
        sql = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
        column = @"userName";
    }else if (tablecolumn == TableUserInfoColumn_password){
        sql = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
        column = @"password";
    }else if (tablecolumn == TableUserInfoColumn_regPhoneNum){
        sql = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
        column = @"regPhoneNum";
    }else if (tablecolumn == TableUserInfoColumn_inviteCode){
        sql = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
        column = @"inviteCode";
    }else if (tablecolumn == TableUserInfoColumn_resource){
        sql = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
        column = @"resource";
    }else if (tablecolumn == TableUserInfoColumn_uuid){
        sql = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
        column = @"uuid";
    }else if (tablecolumn == TableUserInfoColumn_platform){
        sql = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
        column = @"platform";
    }else if (tablecolumn == TableUserInfoColumn_finished){
        sql = [NSString stringWithFormat:@"SELECT * FROM UserInfo"];
        column = @"finished";
    }else if (tablecolumn == TableOwnerTeamColumn_ownerTeamID){
        sql = [NSString stringWithFormat:@"SELECT * FROM OwnerTeam"];
        column = @"ownerTeamID";
    }else if (tablecolumn == TableOwnerTeamColumn_ownerTeamName){
        sql = [NSString stringWithFormat:@"SELECT * FROM OwnerTeam"];
        column = @"ownerTeamName";
    }else if (tablecolumn == TableOwnerTeamColumn_teamCount){
        sql = [NSString stringWithFormat:@"SELECT * FROM OwnerTeam"];
        column = @"teamCount";
    }else if (tablecolumn == TableOwnerTeamColumn_teamActivity){
        sql = [NSString stringWithFormat:@"SELECT * FROM OwnerTeam"];
        column = @"teamActivity";
    }
    return [[DBOperation sharedInstance] searchWithSQL:sql Column:column];
}

-(void)updateTableColumn:(TableColumn)tablecolumn WithValue:(NSString *)value
{
    NSString *sql = [[NSString alloc] init];
    if (tablecolumn == TableUserInfoColumn_userName) {
        sql = [NSString stringWithFormat:@"UPDATE UserInfo SET userName = %@",value];
    }else if (tablecolumn == TableUserInfoColumn_password){
        sql = [NSString stringWithFormat:@"UPDATE UserInfo SET password = %@",value];
    }else if (tablecolumn == TableUserInfoColumn_regPhoneNum){
        sql = [NSString stringWithFormat:@"UPDATE UserInfo SET regPhoneNum = %@",value];
    }else if (tablecolumn == TableUserInfoColumn_inviteCode){
        sql = [NSString stringWithFormat:@"UPDATE UserInfo SET inviteCode = %@",value];
    }else if (tablecolumn == TableUserInfoColumn_resource){
        sql = [NSString stringWithFormat:@"UPDATE UserInfo SET resource = %@",value];
    }else if (tablecolumn == TableUserInfoColumn_uuid){
        sql = [NSString stringWithFormat:@"UPDATE UserInfo SET uuid = %@",value];
    }else if (tablecolumn == TableUserInfoColumn_platform){
        sql = [NSString stringWithFormat:@"UPDATE UserInfo SET platform = %@",value];
    }else if (tablecolumn == TableUserInfoColumn_finished){
        sql = [NSString stringWithFormat:@"UPDATE UserInfo SET finished = %@",value];
    }else if (tablecolumn == TableOwnerTeamColumn_ownerTeamID){
        sql = [NSString stringWithFormat:@"UPDATE OwnerTeam SET ownerTeamID = %@",value];
    }else if (tablecolumn == TableOwnerTeamColumn_ownerTeamName){
        sql = [NSString stringWithFormat:@"UPDATE OwnerTeam SET ownerTeamName = %@",value];
    }else if (tablecolumn == TableOwnerTeamColumn_teamCount){
        sql = [NSString stringWithFormat:@"UPDATE OwnerTeam SET teamCount = %@",value];
    }else if (tablecolumn == TableOwnerTeamColumn_teamActivity){
        sql = [NSString stringWithFormat:@"UPDATE OwnerTeam SET teamActivity = %@",value];
    }
    NSLog(@"SQL:%@",sql);
    [[DBOperation sharedInstance] updateWithSQL:sql];
}


@end
