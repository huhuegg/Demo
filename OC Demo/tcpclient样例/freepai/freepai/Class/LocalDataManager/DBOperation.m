//
//  DBOperation.m
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "DBOperation.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"

@interface DBOperation()
{
    FMDatabase *DB;
}
@end

@implementation DBOperation
+(DBOperation *)sharedInstance
{
    static DBOperation *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"FreePai.db"];
        DB = [FMDatabase databaseWithPath:dbPath];
        DLog(@"dbPath:%@",dbPath);
    }
    return self;
}

/************************个人信息表**********************/
//userName(用户名) password(密码) regPhoneNum(注册使用的手机号码) inviteCode(邀请码) resource(广告识别码) uuid(app用户唯一ID) platform(用户登录平台) finished（个人信息完善状态）
-(void)createUserInfoTable {
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        if ([DB executeUpdate:@"CREATE TABLE IF NOT EXISTS UserInfo(userName text,password text,regPhoneNum text,inviteCode text,resource text,uuid text,platform text,finished text)"]) {
            NSLog(@"创建用户信息表成功");
            if ([self isEmptyTable:@"UserInfo"]) {
                [DB executeUpdate:@"INSERT INTO UserInfo (userName,password,regPhoneNum,inviteCode,resource,uuid,platform,finished) values('None','None','None','None','None','None','None','None')"];
            }
        } else {
            NSLog(@"创建用户信息表失败");
        }
        [DB close];
    }
}

-(void)cleanUserInfo{
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        if ([DB executeUpdate:@"DELETE FROM UserInfo"]) {
            NSLog(@"清空用户信息表成功");
        } else {
            NSLog(@"清空用户信息表失败");
        }
        [DB close];
    }
}

/************************自建帮派信息表**********************/
//ownerTeamID(自建帮派ID) ownerTeamName teamCount（自建帮派总人数）teamActivity(自建帮派活跃度)
-(void)createOwnerTeamTable {
    if (![DB open]) {
        NSLog(@"Could not open db.");
    } else {
        if ([DB executeUpdate:@"CREATE TABLE IF NOT EXISTS OwnerTeam(ownerTeamID text,ownerTeamName text,teamCount text,teamActivity text)"]) {
            NSLog(@"创建自建帮派表成功");
            if ([self isEmptyTable:@"OwnerTeam"]) {
                [DB executeUpdate:@"INSERT INTO OwnerTeam (ownerTeamID,ownerTeamName,teamCount,teamActivity) values('None','None','None','None')"];
            }
        } else {
            NSLog(@"创建自建帮派表失败");
        }
        [DB close];
    }
    
}

-(void)cleanOwnerTeam {
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else {
        if ([DB executeUpdate:@"DELETE FROM OwnerTeam"]) {
            NSLog(@"清空自建帮派表成功");
        } else {
            NSLog(@"清空自建帮派表失败");
        }
        [DB close];
    }
}

-(NSString *)searchWithSQL:(NSString *)sql Column:(NSString *)Column
{
    NSString *String = [[NSString alloc] init];
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        FMResultSet *rs = [DB executeQuery:sql];
        while ([rs next]) {
            String = [rs stringForColumn:Column];
        }
        [DB close];
    }
    return String;
}

-(void)updateWithSQL:(NSString *)sql
{
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        [DB executeUpdate:sql];
        //[DB close];
    }
}


-(void)UpdateTableUserInfoWith:(NSString *)username and:(NSString *)password
{
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        [DB executeUpdate:@"UPDATE UserInfo SET userName = ?,password = ?",username,password];
        [DB close];
    }
}


/************************我的支付宝账户表**********************/
//Account(支付宝账号)
-(void)createMyAccountTable
{
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        [DB executeUpdate:@"CREATE TABLE IF NOT EXISTS MyAccount(Account text)"];
        [DB close];
    }
}

-(void)insertMyAccountTableWithAccount:(NSString *)myaccount
{
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        [DB executeUpdate:@"INSERT INTO MyAccount(Account) VALUES(?)",myaccount];
        [DB close];
    }
}

-(NSMutableArray *)searchTableForMyAccount
{
    NSMutableArray *accountList = [[NSMutableArray alloc] init];
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        FMResultSet *rs = [DB executeQuery:@"SELECT Account FROM MyAccount"];
        while ([rs next]) {
            NSString *account = [rs stringForColumn:@"Account"];
            [accountList addObject:account];
        }
        [DB close];
    }
    return accountList;
}

-(void)deleteAccount:(NSString *)account
{
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        [DB executeUpdate:@"DELETE FROM MyAccount Where Accout = ?",account];
        [DB close];
    }
}

/************************我的支付宝账户表**********************/
//person(收货人) postcode(收货人邮编) telephone:(收货人手机号) area:(收货人所属地区) location:(收货人家庭地址)
-(void)createMyAddressTable
{
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        //[DB executeUpdate:@"CREATE TABLE IF NOT EXISTS MyAddress(Person text,Postcode text,Telephone text,Area text,Location text)"];
        [DB executeUpdate:@"CREATE TABLE IF NOT EXISTS MyAddress(Person text,Postcode text,Telephone text,Area text,Location text)"];
        [DB close];
    }
}

-(void)insertMyAddressTableWithPerson:(NSString *)person PostCode:(NSString *)postcode Tele:(NSString *)telephone Area:(NSString *)area Location:(NSString *)location
{
    DLog(@"%@,%@,%@,%@,%@",person,postcode,telephone,area,location);
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
       // [DB executeUpdate:@"INSERT INTO MyAddress(Person,Postcode,Telephone,Area,Location)) VALUES(?,?,?,?,?)",person,postcode,telephone,area,location];
        [DB executeUpdate:@"INSERT INTO MyAddress(Person,Postcode,Telephone,Area,Location) VALUES(?,?,?,?,?)",person,postcode,telephone,area,location];
        [DB close];
    }
}

-(NSMutableArray *)searchTableForAllOfMyAddress
{
    NSMutableArray *addressList = [[NSMutableArray alloc] init];
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        FMResultSet *rs = [DB executeQuery:@"SELECT * FROM MyAddress"];
        while ([rs next]) {
            NSMutableDictionary *addressDict = [[NSMutableDictionary alloc] init];
            NSString *person = [rs stringForColumn:@"Person"];
            NSString *postcode = [rs stringForColumn:@"Postcode"];
            NSString *telephone = [rs stringForColumn:@"Telephone"];
            NSString *area = [rs stringForColumn:@"Area"];
            NSString *location = [rs stringForColumn:@"Location"];
            [addressDict setObject:person forKey:@"person"];
            [addressDict setObject:postcode forKey:@"postcode"];
            [addressDict setObject:telephone forKey:@"telephone"];
            [addressDict setObject:area forKey:@"area"];
            [addressDict setObject:location forKey:@"location"];
            [addressList addObject:addressDict];
        }
        [DB close];
    }
    return addressList;
}

-(void)deleteMyAddressWithPerson:(NSString *)person PostCode:(NSString *)postcode Tele:(NSString *)telephone Area:(NSString *)area Location:(NSString *)location
{
    if (![DB open]) {
        NSLog(@"Could not open db.");
    }else{
        [DB executeUpdate:@"DELETE FROM MyAddress Where Person = ? and Postcode = ? and Telephone = ? and Area = ? and Location = ?",person,postcode,telephone,area,location];
        [DB close];
    }
}


-(BOOL)isEmptyTable:(NSString *)tableName {
    BOOL status;
    if (![DB open]) {
        status = NO;
        NSLog(@"Could not open db.");
    }else{
        NSString *sql = [[NSString alloc]initWithFormat:@"select count(*) from %@",tableName];
        NSString *Count = [DB stringForQuery:sql];
        if ([Count intValue] == 0) {
            status = YES;
        }else{
            status = NO;
        }
    }
    return status;
}

@end
