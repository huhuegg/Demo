//
//  CacheDataManager.m
//  freepai
//
//  Created by huhuegg on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "CacheDataManager.h"
#import "LocalDataManager.h"

@implementation CacheDataManager

+(CacheDataManager *)sharedInstance
{
    static CacheDataManager *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(id)init {
    id p = [super init];
    if (p) {
        
        self.MessageStartID = @"None";
        
        //用户信息
        [self setUserInfo:[@{
                            @"userID":@"",
                            @"userName":@"",
                            @"nickName":@"",
                            @"password":@"",
                            @"regPhoneNum":@"",
                            @"inviteCode":@"",
                            @"resource":@"",
                            @"uuid":@"",
                            @"platform":@"",
                            @"finished":@"",
                            @"userIntegral":@"",
                            @"userActivity":@"",
                            @"userUnderLineCount":@"",
                            @"devicePushToken":@""
                            }mutableCopy]];
        
        //个人消息
        /*
        [self setMsgArray:[@[
                             @{@"msgID":@1,@"msgType":@1,@"msgTypeInfo":@"帮主邀请",@"msgInfo":@"少林1派掌门 我真的不是人1 分钱啦！ 帮我一起做个任务呗 ...... 18:00准时开始哦。"},
                             @{@"msgID":@1,@"msgType":@2,@"msgTypeInfo":@"帮主邀请",@"msgInfo":@"少林2派掌门 我真的不是人2 分钱啦！ 帮我一起做个任务呗 ...... 18:00准时开始哦。"},
                             @{@"msgID":@1,@"msgType":@3,@"msgTypeInfo":@"帮主邀请",@"msgInfo":@"少林3派掌门 我真的不是人3 分钱啦！ 帮我一起做个任务呗 ...... 18:00准时开始哦。"},
                             @{@"msgID":@1,@"msgType":@4,@"msgTypeInfo":@"帮主邀请",@"msgInfo":@"少林派4掌门 我真的不是人5 分钱啦！ 帮我一起做个任务呗 ...... 18:00准时开始哦。"},
                             @{@"msgID":@1,@"msgType":@5,@"msgTypeInfo":@"帮主邀请",@"msgInfo":@"少林派5掌门 我真的不是人5 分钱啦！ 帮我一起做个任务呗 ...... 18:00准时开始哦。"},
        ]mutableCopy]];
        */
         
        //滚动世界消息
        [self setScrollTableCellArr:@[
                                      @"赶快加入'财神'圈子 抢红包哦！",
                                      @"关注杀价活动 每天都有让你❤️的🎁",
                                      @"邀请微信好友 一起happy吧",
                                      @"众多游戏等着你 和好友联机对战吧",
                                      
                                      ]];
        
        //活动内容
        [self setActivityList:@[
                                 @{@"type":@1,@"id":@1,@"title":@"邀请好友",@"gold":@20,@"info":@"--",@"imgUrl":@"http://test.test/image1",@"hot":@1},
                                 @{@"type":@1,@"id":@3,@"title":@"杀价王",@"gold":@5,@"info":@"--",@"imgUrl":@"http://test.test/image3",@"hot":@1},
                                 @{@"type":@1,@"id":@4,@"title":@"自由派红包",@"gold":@5,@"info":@"--",@"imgUrl":@"http://test.test/image4",@"hot":@0},
                                 @{@"type":@1,@"id":@4,@"title":@"游戏任务",@"gold":@5,@"info":@"--",@"imgUrl":@"http://test.test/image4",@"hot":@0},
                                 ]];
        
        /*
        //团队派内容
        [self setTeamPaiList:@[
                               @{@"type":@2,@"id":@1,@"title":@"大红包",@"gold":@15,@"info":@"积分 15",@"imgUrl":@"http://test.test/image5",@"hot":@1},
                               @{@"type":@2,@"id":@2,@"title":@"梦想基金",@"gold":@5,@"info":@"积分 5-20",@"imgUrl":@"http://test.test/image5",@"hot":@0},
                               @{@"type":@2,@"id":@3,@"title":@"最强好声音",@"gold":@5,@"info":@"积分 5-20",@"imgUrl":@"http://test.test/image7",@"hot":@0},
                               @{@"type":@2,@"id":@4,@"title":@"X",@"gold":@15,@"info":@"积分 15",@"imgUrl":@"http://test.test/image8",@"hot":@0},
                               ]];
        //任务派内容
        [self setTaskPaiList:@[
                               @{@"type":@3,@"id":@1,@"title":@"每日签到",@"gold":@15,@"info":@"积分 15",@"imgUrl":@"http://test.test/image8",@"hot":@1},
                               @{@"type":@3,@"id":@2,@"title":@"精彩广告",@"gold":@5,@"info":@"积分 5-20",@"imgUrl":@"http://test.test/image9",@"hot":@1},
                               @{@"type":@3,@"id":@3,@"title":@"自由派游戏",@"gold":@20,@"info":@"积分 20",@"imgUrl":@"http://test.test/image10",@"hot":@1},
                               @{@"type":@3,@"id":@4,@"title":@"火爆APP下载",@"gold":@5,@"info":@"积分 5-20",@"imgUrl":@"http://test.test/image11",@"hot":@1},
                               ]];
        */
        
        //自由派游戏内容
        [self setFreePaiGameList:@[
                               @{@"type":@3,@"id":@1,@"title":@"失落的飞机",@"gold":@15,@"info":@"有688个好友在玩",@"imgUrl":@"http://test.test/image8",@"hot":@0},
                               @{@"type":@3,@"id":@2,@"title":@"江湖",@"gold":@5,@"info":@"有12688个好友在玩",@"imgUrl":@"http://test.test/image9",@"hot":@1},
                               @{@"type":@3,@"id":@3,@"title":@"自由派雷电",@"gold":@20,@"info":@"有288个好友在玩",@"imgUrl":@"http://test.test/image10",@"hot":@1},
                               ]];
        /*
        //火爆APP下载内容
        [self setHotAppList:@[
                              @{@"type":@3,@"id":@1,@"title":@"疯狂的方言11",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h009/h04/img201311061734590_info200X200.png",@"hot":@1,@"downloadUrl":@"https://itunes.apple.com/cn/app/id681769223"},
                              @{@"type":@3,@"id":@2,@"title":@"微信",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h007/h34/img201308140910500.jpg",@"hot":@1,@"downloadUrl":@"http://itunes.apple.com/cn/app/id414478124"},
                              @{@"type":@3,@"id":@3,@"title":@"快播手机版1977",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h004/h73/img201112151011000.jpg",@"hot":@1,@"downloadUrl":@"http://itunes.apple.com/cn/app/id475596116"},
                              @{@"type":@3,@"id":@4,@"title":@"陌陌",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h012/h27/img201404021404010_info144X144.png",@"hot":@1,@"downloadUrl":@"http://itunes.apple.com/cn/app/id448165862"},
                              @{@"type":@3,@"id":@5,@"title":@"瘟疫公司",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h005/h64/img201207241011540.jpg",@"hot":@1,@"downloadUrl":@"http://itunes.apple.com/cn/app/plague-inc./id525818839?mt=8"},
                              @{@"type":@3,@"id":@6,@"title":@"卡通农场",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h005/h56/img201207111532150.jpg",@"hot":@1,@"downloadUrl":@"http://itunes.apple.com/cn/app/hay-day/id506627515?mt=8"},
                              @{@"type":@3,@"id":@7,@"title":@"虚拟伙伴",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h006/h08/img201211101424200.jpg",@"hot":@1,@"downloadUrl":@"http://itunes.apple.com/cn/app/id516708312?mt=8"},
                              @{@"type":@3,@"id":@8,@"title":@"颜色跑酷",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h015/h58/img201406180938430_info200X200.png",@"hot":@1,@"downloadUrl":@"https://itunes.apple.com/cn/app/id682422179?mt=8"},
                              @{@"type":@3,@"id":@9,@"title":@"愤怒的小鸟go",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h009/h49/img201312111916530_info124X124.png",@"hot":@1,@"downloadUrl":@"http://itunes.apple.com/cn/app/id642821482"},
                              @{@"type":@3,@"id":@10,@"title":@"神偷奶爸－小黄人快跑",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h009/h24/img201311191518420562_info240X240.jpg",@"hot":@1,@"downloadUrl":@"https://itunes.apple.com/cn/app/id596402997?mt=8"},
                              @{@"type":@3,@"id":@11,@"title":@"神庙逃亡2柳岩版",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h013/h80/img201404291740200_info144X144.png",@"hot":@1,@"downloadUrl":@"https://itunes.apple.com/cn/app/id572395608"},
                              @{@"type":@3,@"id":@12,@"title":@"UC浏览器",@"gold":@5,@"info":@"--",@"imgUrl":@"http://images.liqucn.com/h007/h28/img201308011532230.jpg",@"hot":@1,@"downloadUrl":@"http://itunes.apple.com/cn/app/uc-liu-lan-qiiphone-ban/id527109739"},
                            ]];
         */
        
        //兑换内容
        [self setExchangeList:@[
                                 @{@"type":@4,@"id":@1,@"itemtype":@1,@"itemname":@"苹果 iPad mini2 ME279CH/A",@"info":@"配备 Retina 显示屏 7.9英寸平板电脑",@"gold":@288800,@"exchange":@2,@"comment":@1,@"imgUrl":@"http://test.test/image11",@"hot":@1},
                                 @{@"type":@4,@"id":@2,@"itemtype":@1,@"itemname":@"jawbone up智能手环",@"info":@"UP 不仅使您的信息可视化，让您了解数字背后的含义",@"gold":@188800,@"exchange":@2,@"comment":@1,@"imgUrl":@"http://test.test/image11",@"hot":@0},
                                 @{@"type":@4,@"id":@3,@"itemtype":@2,@"itemname":@"支付宝提现1元",@"info":@"提现哦，真的是提现哦，支付宝提现哦",@"gold":@100,@"exchange":@299,@"comment":@1,@"imgUrl":@"http://test.test/image11",@"hot":@1},
                                 ]];
        /*
        //广告列表
        [self setAdList:@[
                                 @{@"type":@5,@"id":@1,@"adtype":@1,@"adname":@"广告1",@"gold":@5,@"info":@"积分 5",@"imgUrl":@"http://192.168.83.136:88/video.html?adname=eight%20parts&adid=3&uuid=d0f00eb0844a305aeeeab541a6ab5079",@"hot":@1},
                                 @{@"type":@5,@"id":@2,@"adtype":@2,@"adname":@"广告2-视频",@"gold":@10,@"info":@"积分 10",@"imgUrl":@"http://192.168.83.136:88/video.html?adname=eight%20parts&adid=3&uuid=d0f00eb0844a305aeeeab541a6ab5079",@"hot":@1},
                                 @{@"type":@5,@"id":@3,@"adtype":@1,@"adname":@"广告3",@"gold":@5,@"info":@"积分 5",@"imgUrl":@"http://192.168.83.136:88/video.html?adname=eight%20parts&adid=3&uuid=d0f00eb0844a305aeeeab541a6ab5079",@"hot":@1},
                                 @{@"type":@5,@"id":@4,@"adtype":@2,@"adname":@"广告4-视频",@"gold":@10,@"info":@"积分 10",@"imgUrl":@"http://192.168.83.136:88/video.html?adname=eight%20parts&adid=3&uuid=d0f00eb0844a305aeeeab541a6ab5079",@"hot":@0},
                                 ]];
         */
        
        /*
        //游戏列表
        [self setGameList:@[
                          @{@"type":@6,@"gameid":@"pai_001",@"gamename":@"江湖",@"playingfriends":@28,@"imgUrl":@"http://test.test/image15",@"hot":@1},
                          @{@"type":@6,@"gameid":@"pai_002",@"gamename":@"中国好舞蹈",@"playingfriends":@10,@"imgUrl":@"http://test.test/video16",@"hot":@1},
                          @{@"type":@6,@"gameid":@"pai_003",@"gamename":@"一球成名",@"playingfriends":@10,@"imgUrl":@"http://test.test/image7",@"hot":@1},
                          @{@"type":@6,@"gameid":@"pai_004",@"gamename":@"newgame",@"playingfriends":@100,@"imgUrl":@"http://test.test/video18",@"hot":@0},
                          ]];
         */
        
        //好友游戏排行榜
        /*
        [self setGameFriendBoard:@[
                                   @{@"username":@"姓氏名谁",@"level":@1,@"gold":@9999,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@2,@"gold":@8888,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@3,@"gold":@7777,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@4,@"gold":@6666,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@5,@"gold":@5555,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@6,@"gold":@4444,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@7,@"gold":@3333,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@8,@"gold":@2222,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@9,@"gold":@1111,@"context":@"挑战Ta"},
                                   @{@"username":@"姓氏名谁",@"level":@10,@"gold":@1110,@"context":@"挑战Ta"},
                                   ]];
         */
        self.gameFriendBoard = [[NSArray alloc] init];
        /*
        //昨日活动收入排行榜
        [self setYesterdayActivityPointsList:@[
                                               @{@"activityname":@"每日签到",@"level":@1,@"gold":@9999},
                                               @{@"activityname":@"竞价王",@"level":@2,@"gold":@8888},
                                               @{@"activityname":@"开心答题",@"level":@3,@"gold":@7777},
                                               @{@"activityname":@"自由派游戏",@"level":@4,@"gold":@6666},
                                               @{@"activityname":@"火爆APP下载",@"level":@5,@"gold":@5555},
                                               @{@"activityname":@"精彩广告",@"level":@6,@"gold":@4444},
                                               @{@"activityname":@"梦想基金",@"level":@7,@"gold":@3333},
                                               @{@"activityname":@"大红包",@"level":@8,@"gold":@2222},
                                               @{@"activityname":@"密室逃脱",@"level":@9,@"gold":@1111},
                                               @{@"activityname":@"X",@"level":@10,@"gold":@1110},
                                            ]];
         */
        //上周个人收入排行榜
        [self setLastweekPersonPointsList:@[
                                               @{@"nickname":@"a888",@"level":@888,@"gold":@300}, //my level
                                               @{@"nickname":@"a1",@"level":@1,@"gold":@9999},
                                               @{@"nickname":@"a2",@"level":@2,@"gold":@8888},
                                               @{@"nickname":@"a3",@"level":@3,@"gold":@7777},
                                               @{@"nickname":@"a4",@"level":@4,@"gold":@6666},
                                               @{@"nickname":@"a5",@"level":@5,@"gold":@5555},
                                               @{@"nickname":@"a6",@"level":@6,@"gold":@4444},
                                               @{@"nickname":@"a7",@"level":@7,@"gold":@3333},
                                               @{@"nickname":@"a8",@"level":@8,@"gold":@2222},
                                               @{@"nickname":@"a9",@"level":@9,@"gold":@1111},
                                               @{@"nickname":@"a10",@"level":@10,@"gold":@1110},
                                               ]];
        //上月帮派排行榜
        [self setLastMonthTeamPointList:@[
                                          @{@"teamname":@"team888",@"level":@888,@"gold":@300}, //my team
                                          @{@"teamname":@"team1",@"level":@1,@"gold":@9999},
                                          @{@"teamname":@"team2",@"level":@2,@"gold":@8888},
                                          @{@"teamname":@"team3",@"level":@3,@"gold":@7777},
                                          @{@"teamname":@"team4",@"level":@4,@"gold":@6666},
                                          @{@"teamname":@"team5",@"level":@5,@"gold":@5555},
                                          @{@"teamname":@"team6",@"level":@6,@"gold":@4444},
                                          @{@"teamname":@"team7",@"level":@7,@"gold":@3333},
                                          @{@"teamname":@"team8",@"level":@8,@"gold":@2222},
                                          @{@"teamname":@"team9",@"level":@9,@"gold":@1111},
                                          @{@"teamname":@"team10",@"level":@10,@"gold":@1110},
                                          ]];
        
        //杀价物品列表
        [self setHaggleList:@[
                              @{@"haggleitemid":@1,@"title":@"苹果 iPad mini2 ME279CH/A",@"info":@"配备 Retina 显示屏 7.9英寸平板电脑",@"price":@288800,@"openTime":@"2014-6-16 00:00:00",@"closeTime":@"2014-6-17 00:00:00",@"imgUrl":@"http://test.test/hagleitem1",@"countDownTime":@3},
                              @{@"haggleitemid":@2,@"title":@"jawbone up智能手环",@"info":@"UP 不仅使您的信息可视化，让您了解数字背后的含义",@"price":@188800,@"openTime":@"2014-6-16 00:00:00",@"closeTime":@"2014-6-17 00:00:00",@"imgUrl":@"http://test.test/hagleitem2",@"countDownTime":@38600},
                              ]];
        [self setHaggleRuleInfo:@"活动说明：\n\n杀价王，采用杀价式拍卖进行竞标。\n\n以价格同时满足“唯一”和“最低”两项者为标王。\n\n由于出价要同时满足两个条件，在出价的时候系统会自动给出“顺位状态”的信息，作为参考。\n\n顺位的计算如下：\n1、筛选出“唯一”的出价，对其由低到高的排序\n2、扣除满足“唯一”条件的排序后，再延续排序"];
        
        [self setRedRenvelopeTypeList:@[
                                        @"未领取红包",
                                        @"已领取红包"
                                        ]];
        
        
        /*
        [self setRedRenvelopeDict:@{
                                    @"未领取红包":@[
                                                    @{@"redID":@1,@"from":@"好友一",@"gold":@0,@"status":@0},
                                                    @{@"redID":@2,@"from":@"好友二",@"gold":@0,@"status":@0},
                                                ],
                                    @"未领取红包":@[
                                                    @{@"redID":@3,@"from":@"好友三",@"gold":@30,@"status":@1},
                                                    @{@"redID":@4,@"from":@"好友四",@"gold":@100,@"status":@1},
                                                ],
                                    
                                    }];

        */
        [NSMutableDictionary dictionaryWithObjectsAndKeys:@"v1",@"key1",@"v2",@"key2",nil];
        [self setRedRenvelopeDict:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"未领取红包",@[],@"已领取红包",@[],nil]];
        /*
        [self setRedRenvelopeDict:@{
                                    @"未领取红包":@[],
 
                                    @"已领取红包":@[],
                                    }];
         */
        
        
        //杀价物品列表
        [self setExchangeProjectsList:@[
                              @{@"haggleitemid":@1,@"title":@"苹果 iPad mini2 ME279CH/A",@"info":@"配备 Retina 显示屏 7.9英寸平板电脑",@"price":@2888000,@"exchanged_count":@"2",@"projectstyle":@0},
                              @{@"haggleitemid":@2,@"title":@"jawbone up智能手环",@"info":@"UP 不仅使您的信息可视化，让您了解数字背后的含义",@"price":@1888000,@"exchanged_count":@"2",@"projectstyle":@0},
                                @{@"haggleitemid":@1,@"title":@"支付宝提现1元",@"info":@"提现哦，真的是提现哦，支付宝提现哦",@"price":@1000,@"exchanged_count":@"2",@"projectstyle":@1},
                              ]];
        

        [self setSampleFrinendsList:@[
                                      @{@"account":@"freepai_system",@"nickname":@"自由派系统消息",@"status":@"online",@"lastmsg":@"最后一条自由派系统消息"},
                                      @{@"account":@"freepai_game",@"nickname":@"自由派游戏消息",@"status":@"online",@"lastmsg":@"最后一跳自由派游戏消息"},
                                      @{@"account":@"15901718681",@"nickname":@"姜超",@"status":@"online",@"lastmsg":@"收到的最后一条消息"},
                                      @{@"account":@"18017313798",@"nickname":@"张敏杰",@"status":@"online",@"lastmsg":@"收到的最后一条消息"},
                                      @{@"account":@"u1_username",@"nickname":@"测试用户",@"status":@"online",@"lastmsg":@"收到的最后一条消息"},
                                      
                                      ]];
    
        [self setLastChatFriend:@""];

        return p;
    }
    return nil;
}


#pragma mark - DataConstraintsProtocol

-(void)save
{
    NSLog(@"CacheDataManager username:%@ password:%@",_userName,_password);
    [[LocalDataManager sharedInstance] UpdateTableUserInfoWith:_userName and:_password];
}

-(void)load
{
    //个人信息表
    self.userName = [[LocalDataManager sharedInstance] searchTableForColumn:TableUserInfoColumn_userName];
    self.password = [[LocalDataManager sharedInstance] searchTableForColumn:TableUserInfoColumn_password];
    self.regPhoneNum = [[LocalDataManager sharedInstance] searchTableForColumn:TableUserInfoColumn_regPhoneNum];
    self.inviteCode = [[LocalDataManager sharedInstance] searchTableForColumn:TableUserInfoColumn_inviteCode];
    self.resource = [[LocalDataManager sharedInstance] searchTableForColumn:TableUserInfoColumn_resource];
    self.uuid = [[LocalDataManager sharedInstance] searchTableForColumn:TableUserInfoColumn_uuid];
    self.platform = [[LocalDataManager sharedInstance] searchTableForColumn:TableUserInfoColumn_platform];
    self.finished = [[LocalDataManager sharedInstance] searchTableForColumn:TableUserInfoColumn_finished];
    
    //自建帮派信息表
    self.ownerTeamID = [[LocalDataManager sharedInstance] searchTableForColumn:TableOwnerTeamColumn_ownerTeamID];
    self.ownerTeamName = [[LocalDataManager sharedInstance] searchTableForColumn:TableOwnerTeamColumn_ownerTeamName];
    self.ownerTeamMemberCount = [[LocalDataManager sharedInstance] searchTableForColumn:TableOwnerTeamColumn_teamCount];
    self.ownerTeamActivity = [[LocalDataManager sharedInstance] searchTableForColumn:TableOwnerTeamColumn_teamActivity];
}
@end
