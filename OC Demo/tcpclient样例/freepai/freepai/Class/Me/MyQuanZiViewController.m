//
//  MyQuanZiViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MyQuanZiViewController.h"
#import "MeAllTableViewCell.h"
#import "UIViewController+CWPopup.h"
#import "AddMyInfoViewController.h"

@interface MyQuanZiViewController ()<UITableViewDataSource,UITableViewDelegate,AddMyInfoViewControllerDelegate>

@end

@implementation MyQuanZiViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self refreshleavePartyTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addQuanZiList = [[NSMutableArray alloc] init];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"我的圈子"]];
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
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(self.view.frame.size.width- 80, 22, 80, 30);
    [searchButton setTitle:@"搜索圈子" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [searchButton addTarget:self action:@selector(searchButton_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    self.meQuanZiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-55-TabViewHeight)];
    self.meQuanZiTableView.tag = 0;
    self.meQuanZiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meQuanZiTableView.delegate = self;
    self.meQuanZiTableView.dataSource = self;
    self.meQuanZiTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.meQuanZiTableView];
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

-(void)searchButton_touch
{
    AddMyInfoViewController *addMyInfo = [[AddMyInfoViewController alloc] init:SearchQuanZi];
    addMyInfo.delegate= self;
    [self presentPopupViewController:addMyInfo animated:YES completion:^(void) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
        self.tapRecognizer.numberOfTouchesRequired = 1;
        self.tapRecognizer.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:self.tapRecognizer];
    }];
}

-(void)createButton_touch
{
    if (![[CacheDataManager sharedInstance].ownerTeamName isEqualToString:@"None"]) {
        ALERT(@"提示", @"您已有自建的圈子，请勿重复创建", @"好的");
    }else{
        AddMyInfoViewController *addMyInfo = [[AddMyInfoViewController alloc] init:AddMyQuanZi];
        addMyInfo.delegate= self;
        [self presentPopupViewController:addMyInfo animated:YES completion:^(void) {
            self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
            self.tapRecognizer.numberOfTouchesRequired = 1;
            self.tapRecognizer.numberOfTapsRequired = 1;
            [self.view addGestureRecognizer:self.tapRecognizer];
        }];
    }
}

- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            [self.view removeGestureRecognizer:self.tapRecognizer];
        }];
    }
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if ([[CacheDataManager sharedInstance].ownerTeamName isEqualToString:@"None"]) {
            return 0;
        }else{
            return 1;
        }
        
    }else{
        return self.addQuanZiList.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        headView.backgroundColor = [UIColor grayColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 20)];
        [titleLabel  setBackgroundColor:[UIColor clearColor]];
        [titleLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
        [titleLabel  setText:[NSString stringWithFormat:@"我的圈子"]];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [titleLabel  setTextColor:[UIColor whiteColor]];
        [headView addSubview:titleLabel];
        
        UIButton *create = [UIButton buttonWithType:UIButtonTypeCustom];
        create = [[UIButton alloc] initWithFrame:CGRectMake(270, 0, 40, 20)];
        [create setTitle:@"创建圈子" forState:UIControlStateNormal];
        [create setTitleColor:RGB(238, 131, 97) forState:UIControlStateNormal];
        create.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        create.layer.borderColor = RGB(198, 198, 198).CGColor;
        create.layer.borderWidth = 1.5;
        create.layer.cornerRadius =4;
        [create addTarget:self action:@selector(createButton_touch) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:create];
        return headView;
    }else if (section == 1){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        headView.backgroundColor = [UIColor grayColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 20)];
        [titleLabel  setBackgroundColor:[UIColor clearColor]];
        [titleLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
        [titleLabel  setText:[NSString stringWithFormat:@"我加入的的圈子"]];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [titleLabel  setTextColor:[UIColor whiteColor]];
        [headView addSubview:titleLabel];
        return headView;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"MyCreatedQuanZiListCell";
        MeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MeAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.topLabel.text = [CacheDataManager sharedInstance].ownerTeamName;
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellIdentifier = @"MyJoinedQuanZiListCell";
        MeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MeAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.topLabel.text = [self.addQuanZiList objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}

/*
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (indexPath.section == 2) {
 DLog(@"%@",[self.uninstalledGame objectAtIndex:indexPath.row]);
 NSString *gameid = [[self.uninstalledGame objectAtIndex:indexPath.row] objectForKey:@"game_id"];
 UninstalledGameDetailsViewController *uninstallGameDetails = [[UninstalledGameDetailsViewController alloc] init:gameid];
 [self.navigationController pushViewController:uninstallGameDetails animated:YES];
 }
 }
 */

#pragma mark - AddMyInfoViewControllerDelegate
-(void)addQuanZi:(NSString *)quanzi
{
    DLog(@"添加");
    [[ServerDataManager sharedInstance]requestUserCreateTeam:[CacheDataManager sharedInstance].uuid TeamName:quanzi completeBlock:^(id reqRes){
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                DLog(@"%@",dataObject);
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    if (![[dataObject objectForKey:@"uuid"] isEqualToString:@"None"] && [[dataObject objectForKey: @"team_id"] intValue] >0 && [[dataObject objectForKey: @"team_count"] intValue] >0) {
                        [self.meQuanZiTableView reloadData];
                        [self dismissPopup];
                    }else{
                        ALERT(@"对不起", @"创建帮派失败", @"好的");
                    }

                }
            }else{
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                ALERT(status, dataString, @"好的");
            }
        }
        /*
        if ([reqRes isKindOfClass:[NSError class]]) {
            [self showMsgTitleIs:@"创建帮派失败" message:@"请尝试重新创建" buttonText:@"知道了"];
        }else if ([reqRes isKindOfClass:[NSDictionary class]]){
            if ([[reqRes objectForKey:@"code"]intValue] == 0) {
                if ([[CacheDataManager sharedInstance].ownerTeamName isEqualToString:@"None"]) {
                    self.personalInfoView.partyTitle.text = @"自建帮派:    无";
                }else{
                    self.personalInfoView.partyTitle.text = [NSString stringWithFormat:@"自建帮派:    %@",[CacheDataManager sharedInstance].ownerTeamName];
                }
                [self showMsgTitleIs:@"恭喜" message:@"创建帮派成功" buttonText:@"好的"];
            } else {
                [self showMsgTitleIs:@"创建帮派失败" message:@"请尝试重新创建" buttonText:@"知道了"];
            }
        }
         */
    }];
   
}

-(void)searchQuanZi:(NSString *)quanzi
{
    DLog(@"搜索");
    [self searchOneTeam:quanzi];
    [self dismissPopup];
}


#pragma mark - 其他方法
//查找我加入过的帮派
-(void)refreshleavePartyTableView
{
    if (![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestUserTeam:[CacheDataManager sharedInstance].uuid LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
            if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
                AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
                if (operation.response.statusCode == 200) {
                    NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                    id dataObject = [dict objectForKey:@"dataObject"];
                    if ([dataObject isKindOfClass:[NSDictionary class]]) {
                        DLog(@"%@",dataObject);
                        self.addQuanZiList = [[NSMutableArray alloc] init];
                        NSArray *details = [dataObject objectForKey:@"details"];
                        if (details.count > 0) {
                            for (NSDictionary *teamdict in details) {
                                NSString *team_name = [teamdict objectForKey:@"join_team_name"];
                                DLog(@"%@",team_name);
                                [self.addQuanZiList addObject:[BaseTools getDecodeBase64String:[BaseTools getStringFromURLString:team_name]]];
                            }
                        }
                        DLog(@"%@",self.addQuanZiList);
                        [self.meQuanZiTableView reloadData];
                    }
                }else{
                    NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                    NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                    ALERT(status, dataString, @"好的");
                }
            }
            /*
            if (reqRes) {
                if ([reqRes isKindOfClass:[NSError class]]) {
                    self.leavePartyList = [[NSMutableArray alloc] init];
                    [self.leavePartyTableView reloadData];
                }else if ([reqRes isKindOfClass:[NSDictionary class]]){
                    if ([[reqRes objectForKey:@"code"]intValue] == 0) {
                        id dict  = [reqRes objectForKey:@"dataObject"];
                        if ([dict isKindOfClass:[NSDictionary class]]) {
                            self.leavePartyList = [[NSMutableArray alloc] init];
                            NSArray *details = [dict objectForKey:@"details"];
                            if (details.count > 0) {
                                for (NSDictionary *teamdict in details) {
                                    NSString *team_name = [teamdict objectForKey:@"join_team_name"];
                                    [self.leavePartyList addObject:[BaseTools getDecodeBase64String:[BaseTools getStringFromURLString:team_name]]];
                                }
                            }
                        }
                        [self.leavePartyTableView reloadData];
                    } else {
                        self.leavePartyList = [[NSMutableArray alloc] init];
                        [self.leavePartyTableView reloadData];
                    }
                }
            }
             */
        }];
    }
}

//查找单个帮派
-(void)searchOneTeam:(NSString *)teamName
{
    if (![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestTeamPreciseQuery:[CacheDataManager sharedInstance].uuid LoginResource:@"None" TeamName:teamName completeBlock:^(id reqRes) {
            if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
                AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
                if (operation.response.statusCode == 200) {
                    NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                    id dataObject = [dict objectForKey:@"dataObject"];
                    if ([dataObject isKindOfClass:[NSDictionary class]]) {
                        NSString *messageDetails = [NSString stringWithFormat:@"活跃度:%@\n总人数:%@\n帮主:%@",[dataObject objectForKey:@"team_activity"],[dataObject objectForKey:@"team_count"],[dataObject objectForKey:@"team_leader"]];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"帮派名:%@",teamName]
                                                                            message:messageDetails
                                                                           delegate:self
                                                                  cancelButtonTitle:@"取消"
                                                                  otherButtonTitles:@"加入",nil];
                        [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                            if (buttonIndex == 0) {
                                
                            }else if (buttonIndex == 1){
                                [self addGang:[dataObject objectForKey:@"team_id"]];
                            }
                            
                        }];
                    }
                }else{
                    NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                    NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                    ALERT(status, dataString, @"好的");
                }
            }
        }];
    }
}

//加入帮派
-(void)addGang:(NSString *)teamID
{
    if (![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestTeamPaperApply:[CacheDataManager sharedInstance].uuid  LoginResource:@"None" TeamID:teamID completeBlock:^(id reqRes) {
            
            if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
                AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
                if (operation.response.statusCode == 200) {
                    NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                    id dataObject = [dict objectForKey:@"dataObject"];
                    if ([dataObject isKindOfClass:[NSDictionary class]]) {
                        NSString *status = [dataObject objectForKey:@"add_status"];
                        if ([status intValue] == 0) {
                            [self refreshleavePartyTableView];
                            ALERT(@"恭喜", @"你已成功加入该帮会",@"好的");
                        }else if ([status intValue] == 1){
                            ALERT(@"对不起", @"你已是帮会成员,无法重复加入", @"好的");
                        }else if ([status intValue] == -1){
                            ALERT(@"对不起", @"你无法加入该帮会", @"好的");
                        }
                    }
                }else{
                    NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                    NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                    ALERT(status, dataString, @"好的");
                }
            }
        }];
    }
}


@end
