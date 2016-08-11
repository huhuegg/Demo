//
//  GameScoreBoardViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-18.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "GameScoreBoardViewController.h"
#import "YukeyScrollView.h"
#import "GameScoreBoardTableViewCell.h"

@interface GameScoreBoardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *gameID;
    NSString *gameName;
}

@end

@implementation GameScoreBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init:(NSString *)gid name:(NSString *)name
{
    self = [super init];
    if (self) {
        gameID = gid;
        gameName = name;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.scrollMsgView) {
        [self.scrollMsgView startRefreshData];
        [self.scrollMsgView startScrolling];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (self.scrollMsgView) {
        [self.scrollMsgView stopRefreshData];
        [self.scrollMsgView stopScrolling];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [homePageTitle  setText:[NSString stringWithFormat:@"%@排行榜",gameName]];
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
    
    
    YukeyScrollView *yukeyScrollView = [[YukeyScrollView alloc] initWithFrame:CGRectMake(0, 67, 320, 150) withImageArray:@[@"one",@"two",@"three",@"four"]];
    yukeyScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:yukeyScrollView];
    // Do any additional setup after loading the view.
    
    
    
    
    self.friendBoardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220,  self.view.frame.size.width, self.view.frame.size.height-220-TabViewHeight)];
    // self.myPropertyInformationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.friendBoardTableView.delegate = self;
    self.friendBoardTableView.dataSource = self;
    self.friendBoardTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.friendBoardTableView];
    
    [self gotOrderOfGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CacheDataManager sharedInstance].gameFriendBoard.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    GameScoreBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GameScoreBoardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    id dict = [[CacheDataManager sharedInstance].gameFriendBoard objectAtIndex:[indexPath row]];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        //DLog(@"%@",dict);
        
        
        NSEnumerator *keyEnum=[dict keyEnumerator];//获取key的枚举器
        for(NSString *key in keyEnum){
            DLog(@"%@",key);
            cell.orderLabel.text = [NSString stringWithFormat:@"No.%i",[key intValue]+1];
            NSArray *tempArray = [[dict objectForKey:key] componentsSeparatedByString:@"-"];
            DLog(@"%@",tempArray);
            cell.nameLabel.text = [NSString stringWithFormat:@"%@",[tempArray firstObject]];
            cell.scoreLabel.text = [NSString stringWithFormat:@"%@",[tempArray lastObject]];
            cell.rightButton.text = @"挑战Ta";
        }
        /*
         cell.orderLabel.text = [NSString stringWithFormat:@"No.%d",[indexPath row]+1];
         NSArray *tempArray = [[dict objectForKey:@""]]
         cell.nameLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"username"]];
         cell.scoreLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"gold"]];
         cell.rightButton.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"context"]];
         */
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)gotOrderOfGame
{
    NSLog(@"%@",gameID);
    [[ServerDataManager sharedInstance] requestGameUserScoreBoard:[CacheDataManager sharedInstance].uuid LoginResource:@"None" GameID:gameID completeBlock:^(id reqRes) {
        if (reqRes) {
            if ([reqRes isKindOfClass:[NSDictionary class]]) {
                id dict = [reqRes objectForKey:@"dataObject"];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    [CacheDataManager sharedInstance].gameFriendBoard = [dict objectForKey:@"details"];
                    [self.friendBoardTableView reloadData];
                }
            }
        }
    }];
}


@end
