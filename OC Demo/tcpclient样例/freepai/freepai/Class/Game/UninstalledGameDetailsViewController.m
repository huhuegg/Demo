//
//  UninstalledGameDetailsViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "UninstalledGameDetailsViewController.h"
#import "YukeyScrollView.h"
#import "UninstalledGameFriendBoardTableViewCell.h"

@interface UninstalledGameDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton * detailsButton;
    UIButton * friendBoardButton;
    NSString *gameID;
}

@end

@implementation UninstalledGameDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init:(NSString *)gid
{
    self = [super init];
    if (self) {
        gameID = gid;
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
    [homePageTitle  setText:[NSString stringWithFormat:@"任务派"]];
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
    
    UIControl *rightControl = [[UIControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width- 60, 22, 60, 30)];
    rightControl.backgroundColor = [UIColor whiteColor];
    [rightControl addTarget:self action:@selector(rightControl_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightControl];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 5, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"homePageRight"];
    [rightControl addSubview:rightImageView];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightLabel  setBackgroundColor:[UIColor whiteColor]];
    [rightLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [rightLabel  setText:[NSString stringWithFormat:@"下载游戏"]];
    rightLabel.textAlignment = NSTextAlignmentLeft;
    [rightLabel  setTextColor:RGB(0, 89, 255)];
    [rightControl addSubview:rightLabel];

    
    
    //滚动世界消息
    self.scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    self.scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView];
    
    
    YukeyScrollView *yukeyScrollView = [[YukeyScrollView alloc] initWithFrame:CGRectMake(0, 67, 320, 150) withImageArray:@[@"one",@"two",@"three",@"four"]];
    yukeyScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:yukeyScrollView];
    // Do any additional setup after loading the view.
    
    
    detailsButton =[UIButton buttonWithType:UIButtonTypeCustom];
    detailsButton.frame = CGRectMake(5, 220, 150, 40);
    detailsButton.backgroundColor = [UIColor whiteColor];
    detailsButton.tag = 1;
    detailsButton.selected = YES;
    [detailsButton setTitle:@"详细介绍" forState:UIControlStateNormal];
    detailsButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [detailsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [detailsButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    detailsButton.layer.cornerRadius = 4;
    detailsButton.layer.borderWidth= 1;
    detailsButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:detailsButton];
    
    friendBoardButton =[UIButton buttonWithType:UIButtonTypeCustom];
    friendBoardButton.frame = CGRectMake(self.view.frame.size.width - 155,220, 150, 40);
    friendBoardButton.backgroundColor = RGB(6, 163, 232);
    friendBoardButton.tag = 2;
    friendBoardButton.selected = NO;
    [friendBoardButton setTitle:@"朋友排名" forState:UIControlStateNormal];
    friendBoardButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [friendBoardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [friendBoardButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    friendBoardButton.layer.cornerRadius = 4;
    friendBoardButton.layer.borderWidth= 1;
    friendBoardButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:friendBoardButton];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, SCREEN_HEIGHT - 270 - TabViewHeight)];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
    
    [self initializeDetails];
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

-(void)rightControl_touch
{
    
}

-(void)buttonTouch:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button) {
        if (button.tag == 1) {
            if (!button.selected) {
                detailsButton.backgroundColor = [UIColor whiteColor];
                friendBoardButton.backgroundColor = RGB(6, 163, 232);
                detailsButton.selected = YES;
                friendBoardButton.selected = NO;
                [self initializeDetails];
            }
        }else if(button.tag == 2){
            if (!button.selected) {
                friendBoardButton.backgroundColor = [UIColor whiteColor];
                detailsButton.backgroundColor = RGB(6, 163, 232);
                detailsButton.selected = NO;
                friendBoardButton.selected = YES;
                [self initializeFriendBoard];
            }
        }
    }
}

#pragma mark - 其他方法
-(void)initializeDetails
{
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIScrollView *detailsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    detailsScrollView.backgroundColor = [UIColor clearColor];
    detailsScrollView.showsHorizontalScrollIndicator = NO;
    detailsScrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:detailsScrollView];
    
    UIScrollView *detailsImageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 140)];
    detailsImageScrollView.backgroundColor = [UIColor clearColor];
    detailsImageScrollView.showsHorizontalScrollIndicator = NO;
    detailsImageScrollView.showsVerticalScrollIndicator = NO;
    [detailsScrollView addSubview:detailsImageScrollView];
    
    for (int i = 0; i<6; i++) {
        UIImageView *gameIMG = [[UIImageView alloc] initWithFrame:CGRectMake(10+i*100, 5, 90, 130)];
        gameIMG.image = [UIImage imageNamed:@"GameDetailsDefault"];
        [detailsImageScrollView addSubview:gameIMG];
        if (10 + i*100 > self.contentView.frame.size.width) {
            detailsImageScrollView.contentSize = CGSizeMake(10+i*100, 140);
        }else{
            detailsImageScrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height);
        }
        
    }
    
    UITextView * detailsTextView =[[UITextView alloc] initWithFrame:CGRectMake(0, 140, self.contentView.frame.size.width, 60)];
    detailsTextView.backgroundColor = [UIColor clearColor];
    detailsTextView.userInteractionEnabled = NO;
    detailsTextView.selectable = NO;
    detailsTextView.scrollEnabled = NO;
    detailsTextView.text = @"内容摘要\n失落的飞机，是自由派最新力作。";
    [detailsScrollView addSubview:detailsTextView];
    
    detailsScrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, detailsImageScrollView.frame.size.height + detailsTextView.frame.size.height);
    
}

-(void)initializeFriendBoard
{
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    /*
    UILabel *friendBoardTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 30)];
    [friendBoardTitle  setBackgroundColor:[UIColor clearColor]];
    [friendBoardTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [friendBoardTitle  setText:[NSString stringWithFormat:@"您在朋友中的积分排名是  XXX"]];
    friendBoardTitle.textAlignment = NSTextAlignmentCenter;
    [friendBoardTitle  setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:friendBoardTitle];
     */
    
    self.friendBoardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,  self.contentView.frame.size.width, self.contentView.frame.size.height-30)];
    // self.myPropertyInformationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.friendBoardTableView.delegate = self;
    self.friendBoardTableView.dataSource = self;
    self.friendBoardTableView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.friendBoardTableView];
    
    [self gotOrderOfGame];
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
    UninstalledGameFriendBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UninstalledGameFriendBoardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                [CacheDataManager sharedInstance].gameFriendBoard = [dataObject objectForKey:@"details"];
                [self.friendBoardTableView reloadData];
            }
        }
    }];
}

@end
