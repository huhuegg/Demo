//
//  ReceivedRedEnvelopeViewController.m
//  freepai
//
//  Created by admin on 14/6/25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ReceivedRedEnvelopeViewController.h"
#import "ScrollMsgView.h"
#import "CacheDataManager.h"
#import "ServerDataManager.h"
#import "ReceivedRedEnvelopeTableViewCell.h"
#import "recvRedEnvelopeButton.h"

@interface ReceivedRedEnvelopeViewController ()

@end

@implementation ReceivedRedEnvelopeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"派红包"]];
    homePageTitle.textAlignment = NSTextAlignmentCenter;
    [homePageTitle  setTextColor:RGB(229, 61, 22)];
    [self.view addSubview:homePageTitle];
    
    UIControl *leftControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 22, 60, 30)];
    leftControl.backgroundColor = [UIColor whiteColor];
    [leftControl addTarget:self action:@selector(leftControl_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftControl];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    leftImageView.image = [UIImage imageNamed:@"homePageLeft"];
    [leftControl addSubview:leftImageView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 40, 30)];
    [leftLabel  setBackgroundColor:[UIColor whiteColor]];
    [leftLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [leftLabel  setText:[NSString stringWithFormat:@"返回"]];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [leftLabel  setTextColor:RGB(0, 89, 255)];
    [leftControl addSubview:leftLabel];
    
    
    //滚动世界消息
    self.scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    self.scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView];
    
    _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 67, self.view.bounds.size.width, self.view.bounds.size.height-67)];
    
    //必须设置deletate dataSource
    _tbView.delegate=self;
    _tbView.dataSource=self;
    //去除cell之间的横线
    _tbView.separatorStyle = NO;
    _tbView.rowHeight = 45;
    
    [self.view addSubview:_tbView];
    [self readList];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)readList {
    NSLog(@"read List, requestGetSendMoneyForMe uuid:%@",[CacheDataManager sharedInstance].uuid);
    [[ServerDataManager sharedInstance] requestGetSendMoneyForMe:[CacheDataManager sharedInstance].uuid LoginResource:@"None" completeBlock:^(id reqRes) {
        //NSLog(@"read List return:%@",reqRes);
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            NSLog(@"requestGetSendMoneyForMe return status:%i",operation.response.statusCode);
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                NSLog(@"dataObject class:%@",[dataObject class]);
                if ([dataObject isKindOfClass:[NSNull class]]) {
                    NSLog(@"没有任何未领取或已领取红包记录");
                }
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    if ([dataObject objectForKey:@"no_details"]){
                        [[CacheDataManager sharedInstance].redRenvelopeDict setValue:[dataObject objectForKey:@"no_details"] forKey:@"未领取红包"];
                    } else {
                        [[CacheDataManager sharedInstance].redRenvelopeDict setValue:@[] forKey:@"未领取红包"];
                    }
                    DLog(@"未领取红包:%@",[dataObject objectForKey:@"no_details"]);
                    if ([dataObject objectForKey:@"yes_details"]) {
                        [[CacheDataManager sharedInstance].redRenvelopeDict setValue:[dataObject objectForKey:@"yes_details"] forKey:@"已领取红包"];
                    } else {
                        [[CacheDataManager sharedInstance].redRenvelopeDict setValue:@[] forKey:@"已领取红包"];
                    }
                }
            }else{
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                ALERT(status, dataString, @"好的");
            }
        }
        [self.tbView reloadData];
        
    }];
}


//定义有多少section标题
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"numberOfSectionsInTableView:%i",[CacheDataManager sharedInstance].redRenvelopeTypeList.count);
    return [CacheDataManager sharedInstance].redRenvelopeTypeList.count;
}

//每个section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [CacheDataManager sharedInstance].redRenvelopeTypeList[section];
    
}

//定义每个section包含的记录条数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"tableView numberOfRowsInSection  section:%i",section);
    NSArray *tmpSectionArr = [[CacheDataManager sharedInstance].redRenvelopeDict objectForKey:[CacheDataManager sharedInstance].redRenvelopeTypeList[section]];
    return tmpSectionArr.count;
}


//绘制Cell
- (ReceivedRedEnvelopeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableview cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"Cell";
    
    int sectionIndex = indexPath.section;
    NSString *sectionKey = [CacheDataManager sharedInstance].redRenvelopeTypeList[sectionIndex];
    
    //初始化cell并指定其类型，也可自定义cell
    ReceivedRedEnvelopeTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell =  [[ReceivedRedEnvelopeTableViewCell alloc]initWithFrame:CGRectZero];
        //设定行选中状态为None
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.tag = indexPath.row;
        
        NSArray *dataArr = [[CacheDataManager sharedInstance].redRenvelopeDict objectForKey:sectionKey];
        NSLog(@"trace dataArr:%@",dataArr);
        NSDictionary *dict = dataArr[indexPath.row];
        NSString *belong_user_id = [dict objectForKey:@"belong_user_id"];
        //NSString *user_id = [dict objectForKey:@"user_id"];
        NSString *get_timestamp = [dict objectForKey:@"get_timestamp"];
        NSString *get_money=@"0";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateFormat:@"YYYY-MM-dd HH:mm::ss"];
        [formatter setDateFormat:@"MM-dd"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[get_timestamp intValue]];
        NSString *timeStr = [formatter stringFromDate:date];
        
        if (sectionIndex == 1) {
            get_money = [dict objectForKey:@"get_money"];
        }
        
        cell.sendInfo = [[UILabel alloc]init];
        cell.sendInfo.text=[[NSString alloc]initWithFormat:@"%@ %@发的群红包",timeStr,belong_user_id];
        cell.sendInfo.frame = CGRectMake(10, 10, cell.frame.size.width-50, cell.frame.size.height-20);
        [cell addSubview:cell.sendInfo];
        
        if ([get_money intValue] == 0) {
            cell.recvButton = [[recvRedEnvelopeButton alloc]init];
            cell.recvButton.recvTime = get_timestamp;
            cell.recvButton.recvFrom = belong_user_id;
            cell.recvButton.frame = CGRectMake(cell.frame.size.width-90, 10, 80, cell.frame.size.height-20);
            cell.recvButton.tag = cell.tag;
        
            cell.recvButton.backgroundColor =[UIColor redColor];
            [cell.recvButton setTitle:@"领取红包" forState:UIControlStateNormal];
            [cell.recvButton addTarget:self action:@selector(recvRedEnvelopeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cell.recvButton];
        } else {
            cell.recvInfo = [[UILabel alloc]init];
            cell.recvInfo.frame = CGRectMake(cell.frame.size.width-90, 10, 80, cell.frame.size.height-20);
            cell.recvInfo.tag = cell.tag;
            cell.recvInfo.textColor = [UIColor blueColor];
            [cell.recvInfo setText:[[NSString alloc]initWithFormat:@"%@积分",get_money]];
            [cell addSubview:cell.recvInfo];
        }
        
        
        
    }
    return cell;
    
}

-(void) recvRedEnvelopeClicked:(id)sender {
    if ([sender isKindOfClass:[recvRedEnvelopeButton class]]) {
        recvRedEnvelopeButton *bt = (recvRedEnvelopeButton *)sender;
        [[ServerDataManager sharedInstance] requestAttackSendMoneyFast:[CacheDataManager sharedInstance].uuid LoginResource:@"None" BelongUserID:bt.recvFrom SendTimeSP:bt.recvTime completeBlock:^(id reqRes) {
            if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
                AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
                NSLog(@"requestAttackSendMoneyFast return status:%i",operation.response.statusCode);
                if (operation.response.statusCode == 200) {
                    //抢红包成功
                    NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                    id dataObject = [dict objectForKey:@"dataObject"];
                    
                    if (dataObject) {
                        NSString *alertMessage = [[NSString alloc]initWithFormat:@"抢到%@发的拼手气红包%@积分",bt.recvFrom,dataObject];
                        UIAlertView *alert = nil;
                        alert = [[UIAlertView alloc]initWithTitle:nil message:alertMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                        [alert show];
                        //刷新数据
                        [self readList];
                    }
                }else{
                    //抢红包失败
                    NSString *alertMessage = [[NSString alloc]initWithFormat:@"%@发的拼手气红包已经抢完啦！",bt.recvFrom];
                    UIAlertView *alert = nil;
                    alert = [[UIAlertView alloc]initWithTitle:nil message:alertMessage delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                    [alert show];
                }
            }
        }];
    }

}

@end
