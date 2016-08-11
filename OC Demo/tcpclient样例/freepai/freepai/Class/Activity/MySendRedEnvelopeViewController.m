//
//  MySendRedEnvelopeViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MySendRedEnvelopeViewController.h"
#import "ActivityAllTableViewCell.h"

@interface MySendRedEnvelopeViewController ()

@end

@implementation MySendRedEnvelopeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    self.mySendRedEnvelopeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, 320, self.view.frame.size.height-70-TabViewHeight)];
    // self.myPropertyInformationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mySendRedEnvelopeTableView.delegate = self;
    self.mySendRedEnvelopeTableView.dataSource = self;
    self.mySendRedEnvelopeTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mySendRedEnvelopeTableView];
    
    [self reloadMySendRedList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.SendTimeList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *time = [self.SendTimeList objectAtIndex:section];
    DLog(@"%@",[self.SendTimeDetails objectForKey:time]);
    NSArray *temprray = [self.SendTimeDetails objectForKey:time];
    NSDictionary *details = [[NSDictionary alloc] initWithDictionary:temprray[0]];
    NSMutableArray *detailsArray =[[NSMutableArray alloc] init];
    NSEnumerator *keyEnum=[details keyEnumerator];
    for (NSString *key in keyEnum) {
        [detailsArray addObject:key];
    }
    DLog(@"%@",detailsArray);
    return detailsArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    headView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 20)];
    [titleLabel  setBackgroundColor:[UIColor clearColor]];
    [titleLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
    [titleLabel  setText:[self.SendTimeList objectAtIndex:section]];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel  setTextColor:[UIColor whiteColor]];
    [headView addSubview:titleLabel];

    
    NSString *time = [self.SendTimeList objectAtIndex:section];
    DLog(@"%@",[self.SendTimeDetails objectForKey:time]);
    NSArray *temprray = [self.SendTimeDetails objectForKey:time];
    NSDictionary *details = [[NSDictionary alloc] initWithDictionary:temprray[0]];
    NSMutableArray *detailsArray =[[NSMutableArray alloc] init];
    NSEnumerator *keyEnum=[details keyEnumerator];
    for (NSString *key in keyEnum) {
        [detailsArray addObject:key];
    }
    
    UILabel *coutLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 100, 20)];
    [coutLabel  setBackgroundColor:[UIColor clearColor]];
    [coutLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
    [coutLabel  setText:[NSString stringWithFormat:@"红包:%i个",detailsArray.count]];
    coutLabel.textAlignment = NSTextAlignmentRight;
    [coutLabel  setTextColor:[UIColor whiteColor]];
    [headView addSubview:coutLabel];
    return headView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MySendRedEnvelopeListCell";
    ActivityAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ActivityAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    NSString *time = [self.SendTimeList objectAtIndex:indexPath.section];
    DLog(@"%@",[self.SendTimeDetails objectForKey:time]);
    NSArray *temprray = [self.SendTimeDetails objectForKey:time];
    NSDictionary *details = [[NSDictionary alloc] initWithDictionary:temprray[0]];
    NSMutableArray *detailsArray =[[NSMutableArray alloc] init];
    NSEnumerator *keyEnum=[details keyEnumerator];
    for (NSString *key in keyEnum) {
        [detailsArray addObject:key];
    }
    NSString *String = [details objectForKey:[detailsArray objectAtIndex:indexPath.row]];
    NSData *StringData = [String dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *StringDict = [BaseTools decodeJsonString:StringData];
    
    cell.mainLabel.text = [NSString stringWithFormat:@"红包 价格:%@积分",[StringDict objectForKey:@"each_money"]];
    
    if ([[StringDict objectForKey:@"get_user_id"] isEqualToString:@"0"] && [[StringDict objectForKey:@"get_user_uuid"] isEqualToString:@"None"]) {
        cell.secondLabel.text = @"未被领取";
    }else{
        cell.secondLabel.text = [NSString stringWithFormat:@"领取人:%@",[StringDict objectForKey:@"get_user_uuid"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if ([indexPath row] == 0) {
        InviteFriendsViewController *inviteFriends = [[InviteFriendsViewController alloc] init];
        [self.navigationController pushViewController:inviteFriends animated:YES];
    } else if ([indexPath row] == 1) { //杀价王
        KillPriceViewController *killPrice = [[KillPriceViewController alloc] init];
        [self.navigationController pushViewController:killPrice animated:YES];
    }else if ([indexPath row] == 2) { //杀价王
        RedEnvelopeViewController *redEnvelope = [[RedEnvelopeViewController alloc] init];
        [self.navigationController pushViewController:redEnvelope animated:YES];
    }
     */
}

#pragma mark - 其他方法
-(void)reloadMySendRedList
{
    [[ServerDataManager sharedInstance] requestSearchMoneyListForSend:[CacheDataManager sharedInstance].uuid LoginResource:@"None" completeBlock:^(id reqRes) {
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    self.SendTimeList = [[NSMutableArray alloc] init];
                    self.SendTimeDetails = [[NSMutableDictionary alloc] initWithDictionary:dataObject];
                    NSEnumerator *keyEnum=[dataObject keyEnumerator];
                    for (NSString *key in keyEnum) {
                        [self.SendTimeList addObject:key];
                    }
                    DLog(@"%@",self.SendTimeList);
                }
                [self.mySendRedEnvelopeTableView reloadData];
            }else{
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                ALERT(status, dataString, @"好的");
            }
        }
    }];
}

@end
