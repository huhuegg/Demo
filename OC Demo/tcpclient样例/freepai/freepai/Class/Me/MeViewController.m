//
//  MeViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MeViewController.h"
#import "YukeySegmentedControl.h"
#import "MainViewController.h"
#import "MeTableViewCell.h"
#import "UIViewController+CWPopup.h"
#import "CreateGangViewController.h"
#import "YukeyAudioBasicSetting.h"
#import "UIImage+YukeyRounded.h"

@interface MeViewController ()<Me_PersonalInfoViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,YukeySegmentedControlDelegate,CreateGangViewControllerdelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [homePageTitle  setText:[NSString stringWithFormat:@"我"]];
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
    
    YukeySegmentedControl *yukeySegmentedControl = [[YukeySegmentedControl alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30) leftTitle:@"个人信息" centerTitle:@"退出圈子" rightTitle: @"加入圈子"];
    yukeySegmentedControl.delegate = self;
    yukeySegmentedControl.leftButton.selected = YES;
    [self.view addSubview:yukeySegmentedControl];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-140-TabViewHeight)];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
    
    [self initializePersonalInfoView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.contentView = nil;
    self.scrollMsgView =nil;
}

#pragma mark - YukeySegmentedControlDelegate
-(void)selectedButton:(UIButton *)btn
{
    if (btn.tag == 1) {
        [self initializePersonalInfoView];
    }else if (btn.tag == 2){
        [self initializeLeavePartyView];
    }else if (btn.tag == 3){
        [self initializeJoinPartyView];
    }
}


#pragma mark - initializethreedetails
-(void)initializePersonalInfoView
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.personalInfoView = [[Me_PersonalInfoView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.personalInfoView.delegate = self;
    if ([YukeyAudioBasicSetting fileExistsAtPath:[YukeyAudioBasicSetting getImagePathByFileName:@"image.png"]]) {
        self.personalInfoView.headImageView.image = [UIImage imageWithContentsOfFile:[YukeyAudioBasicSetting getImagePathByFileName:@"image.png"]];
    }else{
        self.personalInfoView.headImageView.image = [UIImage imageNamed:@"MeheadIm"];
    }
    if ([[CacheDataManager sharedInstance].userName isEqualToString:@"None"]) {
        self.personalInfoView.accountTitle.text = @"昵称:    无";
    }else{
        self.personalInfoView.accountTitle.text = [NSString stringWithFormat:@"昵称:    %@",[CacheDataManager sharedInstance].userName];
    }
    
    if ([[CacheDataManager sharedInstance].ownerTeamName isEqualToString:@"None"]) {
        self.personalInfoView.partyTitle.text = @"自建圈子:    无";
    }else{
        self.personalInfoView.partyTitle.text = [NSString stringWithFormat:@"自建圈子:    %@",[CacheDataManager sharedInstance].ownerTeamName];
    }
    [self.contentView addSubview:self.personalInfoView];
}

-(void)initializeLeavePartyView
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.leavePartyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.leavePartyTableView.tag = 0;
    self.leavePartyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leavePartyTableView.delegate = self;
    self.leavePartyTableView.dataSource = self;
    self.leavePartyTableView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.leavePartyTableView];
    
    [self refreshleavePartyTableView];
}

-(void)initializeJoinPartyView
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.mysearchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0.0, 0.0, self.contentView.frame.size.width, 40)];
    self.mysearchBar.placeholder=@"Enter Name";
    self.mysearchBar.delegate = self;
    self.mysearchBar.showsCancelButton = YES;
    //theTableView.tableHeaderView = searchBar;
    self.mysearchBar.keyboardType = UIKeyboardTypeDefault;
    //searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    //searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.contentView addSubview: self.mysearchBar];
    
    
    UIButton * aPartyButton =[UIButton buttonWithType:UIButtonTypeCustom];
    aPartyButton.frame = CGRectMake(20, 45, 130, 30);
    [aPartyButton setTitle:@"我求包养" forState:UIControlStateNormal];
    aPartyButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    [aPartyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [aPartyButton addTarget:self action:@selector(aPartyButton_touch) forControlEvents:UIControlEventTouchUpInside];
    aPartyButton.layer.cornerRadius = 4;
    aPartyButton.layer.borderWidth= 1;
    aPartyButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:aPartyButton];
    
    UIButton * bPartyButton =[UIButton buttonWithType:UIButtonTypeCustom];
    bPartyButton.frame = CGRectMake(self.contentView.frame.size.width - 150,45, 130, 30);
    [bPartyButton setTitle:@"我要吞并" forState:UIControlStateNormal];
    bPartyButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    [bPartyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bPartyButton addTarget:self action:@selector(bPartyButton_touch) forControlEvents:UIControlEventTouchUpInside];
    bPartyButton.layer.cornerRadius = 4;
    bPartyButton.layer.borderWidth= 1;
    bPartyButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:bPartyButton];

    self.joinPartyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, self.contentView.frame.size.width, self.contentView.frame.size.height - 80 - 40)];
    self.joinPartyTableView.tag = 1;
    self.joinPartyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.joinPartyTableView.delegate = self;
    self.joinPartyTableView.dataSource = self;
    self.joinPartyTableView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.joinPartyTableView];
    
    UIControl *refresh = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    refresh.center = CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height- 20);
    [refresh addTarget:self action:@selector(refreshJoinPartyTableView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:refresh];
    
    
    UILabel *refreshLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [refreshLeft  setBackgroundColor:[UIColor clearColor]];
    [refreshLeft  setFont:[UIFont fontWithName:@"Arial" size:12]];
    [refreshLeft  setText:[NSString stringWithFormat:@"再换"]];
    refreshLeft.textAlignment = NSTextAlignmentRight;
    [refreshLeft  setTextColor:[UIColor whiteColor]];
    [refresh addSubview:refreshLeft];
    
    UIImageView *refresh_img = [[UIImageView alloc] initWithFrame:CGRectMake(35, 5, 20, 20)];
    refresh_img.image = [UIImage imageNamed:@"joinpartyrefresh"];
    [refresh addSubview:refresh_img];
    
    
    UILabel *refreshRight = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 30, 30)];
    [refreshRight  setBackgroundColor:[UIColor clearColor]];
    [refreshRight  setFont:[UIFont fontWithName:@"Arial" size:12]];
    [refreshRight  setText:[NSString stringWithFormat:@"三个"]];
    refreshRight.textAlignment = NSTextAlignmentLeft;
    [refreshRight  setTextColor:[UIColor whiteColor]];
    [refresh addSubview:refreshRight];

}


#pragma mark - ButtonAction
-(void)leftControl_touch
{
    MainViewController *viewController = (MainViewController *)self.navigationController.parentViewController;
    if (viewController) {
        UINavigationController *homePageNav = (viewController.childViewControllers.count >= 1)?[viewController.childViewControllers objectAtIndex:0]:nil;
        UIViewController *oldViewController=viewController.currentViewController;
        if (homePageNav && oldViewController) {
            [viewController transitionFromViewController:viewController.currentViewController toViewController:homePageNav duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
                [homePageNav popToRootViewControllerAnimated:YES];
            } completion:^(BOOL finished) {
                
                NSArray *items = viewController.tabView.tabItems;
                for (RKTabItem *item in items) {
                    if ( (int)item.tabState == 0) {
                        [item switchState];
                    }
                }
                viewController.tabView.tabItems = items;
                if (finished) {
                    viewController.currentViewController = homePageNav;
                }else{
                    viewController.currentViewController = oldViewController;
                }
            }];
        }
    }
}

-(void)aPartyButton_touch
{
    
}

-(void)bPartyButton_touch
{
    
}

-(void)refreshJoinPartyTableView
{
    
}



#pragma mark - Me_PersonalInfoViewDelegate
-(void)personalInfoHeadButtonTouch
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相片库中选择", nil];
    if (self.navigationController.parentViewController.view) {
        [actionSheet showInView:self.navigationController.parentViewController.view];
    }
    
}

-(void)personalInfoAccountButtonTouch
{
    
}

-(void)personalInfoPartyButtonTouch
{
    CreateGangViewController *createGang = [[CreateGangViewController alloc] init];
    createGang.delegate= self;
    [self presentPopupViewController:createGang animated:YES completion:^(void) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
        self.tapRecognizer.numberOfTouchesRequired = 1;
        self.tapRecognizer.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:self.tapRecognizer];
    }];
}

-(void)personalInfoRealNameButtonTouch
{
    
}

-(void)personalInfoIDButtonTouch
{
    
}

#pragma mark - UISearchBarDelegate
//search Button clicked....
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    NSLog( @"%s,%d" , __FUNCTION__ , __LINE__ );
    [self searchOneTeam:searchBar.text];
    [searchBar resignFirstResponder];
}

//cancel button clicked...
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar                    // called when cancel button pressed
{
    NSLog( @"%s,%d" , __FUNCTION__ , __LINE__ );
    
    [searchBar resignFirstResponder];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return self.leavePartyList.count;
    }
    return self.joinPartyList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 0) {
        return 50;
    }
    return self.joinPartyTableView.frame.size.height/3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 0) {
        static NSString *membercellIdentifier = @"leavePartyCell";
        MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:membercellIdentifier];
        if (cell == nil) {
            cell = [[MeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:membercellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = [self.leavePartyList objectAtIndex:[indexPath row]];
        return cell;
    }else if (tableView.tag == 1){
        static NSString *cellIdentifier = @"joinPartyCell";
        MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = [self.joinPartyList objectAtIndex:[indexPath row]];
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - CreateGangViewControllerdelegate
-(void)createGang:(NSString *)name
{
    [[ServerDataManager sharedInstance]requestUserCreateTeam:[CacheDataManager sharedInstance].uuid TeamName:name completeBlock:^(id reqRes){
        if ([reqRes isKindOfClass:[NSError class]]) {
            [self showMsgTitleIs:@"创建圈子失败" message:@"请尝试重新创建" buttonText:@"知道了"];
        }else if ([reqRes isKindOfClass:[NSDictionary class]]){
            if ([[reqRes objectForKey:@"code"]intValue] == 0) {
                if ([[CacheDataManager sharedInstance].ownerTeamName isEqualToString:@"None"]) {
                    self.personalInfoView.partyTitle.text = @"自建圈子:    无";
                }else{
                    self.personalInfoView.partyTitle.text = [NSString stringWithFormat:@"自建圈子:    %@",[CacheDataManager sharedInstance].ownerTeamName];
                }
                [self showMsgTitleIs:@"恭喜" message:@"创建圈子成功" buttonText:@"好的"];
            } else {
                [self showMsgTitleIs:@"创建圈子失败" message:@"请尝试重新创建" buttonText:@"知道了"];
            }
        }
    }];
}


#pragma mark - IBActionSheet/UIActionSheet Delegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DLog(@"%i",buttonIndex);
    if (buttonIndex == 1) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        //设置图片源(相簿)
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //设置代理
        picker.delegate = self;
        //设置可以编辑
        picker.allowsEditing = YES;
        //打开拾取器界面
        [self presentViewController:picker animated:YES completion:nil];
    }else if(buttonIndex == 0){
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    DLog(@"%d",picker.sourceType);
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    NSData *data;
    if (UIImagePNGRepresentation([image imageByScalingToSize:CGSizeMake(90, 90)]) == nil) {
        data = UIImageJPEGRepresentation([image imageByScalingToSize:CGSizeMake(90, 90)], 1);
    } else {
        data = UIImagePNGRepresentation([image imageByScalingToSize:CGSizeMake(90, 90)]);
    }
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([YukeyAudioBasicSetting fileExistsAtPath:[YukeyAudioBasicSetting getImagePathByFileName:@"image.png"]]) {
        [YukeyAudioBasicSetting deleteFileAtPath:[YukeyAudioBasicSetting getImagePathByFileName:@"image.png"]];
    }
    
    [fileManager createFileAtPath:[[YukeyAudioBasicSetting getImageCacheDirectory] stringByAppendingString:@"/image.png"] contents:data attributes:nil];
    
    
    if ([YukeyAudioBasicSetting fileExistsAtPath:[YukeyAudioBasicSetting getImagePathByFileName:@"image.png"]]) {
        self.personalInfoView.headImageView.image = [UIImage imageWithContentsOfFile:[YukeyAudioBasicSetting getImagePathByFileName:@"image.png"]];
    }
    
    //选择框消失
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//取消选择图片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    DLog(@"cannel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 其他方法
-(void)showMsgTitleIs:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:buttonText
                                              otherButtonTitles:nil];
    [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        [self dismissPopup];
    }];
    
}

- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            [self.view removeGestureRecognizer:self.tapRecognizer];
        }];
    }
}

//查找我加入过的帮派
-(void)refreshleavePartyTableView
{
    if (![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestUserTeam:[CacheDataManager sharedInstance].uuid LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
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
        }];
    }
}

//查找单个帮派
-(void)searchOneTeam:(NSString *)teamName
{
    if (![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestTeamPreciseQuery:[CacheDataManager sharedInstance].uuid LoginResource:@"None" TeamName:teamName completeBlock:^(id reqRes) {
            DLog(@"查找单个圈子:%@",reqRes);
            if (reqRes) {
                if ([reqRes isKindOfClass:[NSError class]]) {
                    [self showMsgTitleIs:@"提示" message:@"未找到圈子" buttonText:@"好的"];
                }else if ([reqRes isKindOfClass:[NSDictionary class]]){
                    if ([[reqRes objectForKey:@"code"]intValue] == 0) {
                        id dataObject = [reqRes objectForKey:@"dataObject"];
                        if ([dataObject isKindOfClass:[NSDictionary class]]) {
                            NSString *messageDetails = [NSString stringWithFormat:@"活跃度:%@\n总人数:%@\n帮主:%@",[dataObject objectForKey:@"team_activity"],[dataObject objectForKey:@"team_count"],[dataObject objectForKey:@"team_leader"]];
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"圈子名:%@",teamName]
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
                    } else {
                         [self showMsgTitleIs:@"提示" message:@"未找到该圈子" buttonText:@"好的"];
                    }
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
            if (reqRes) {
                DLog(@"加入圈子:%@",reqRes);
                if ([reqRes isKindOfClass:[NSError class]]) {
                    [self showMsgTitleIs:@"提示" message:@"加入圈子失败,请重新尝试" buttonText:@"好的"];
                }else if ([reqRes isKindOfClass:[NSDictionary class]]){
                    if ([[reqRes objectForKey:@"code"]intValue] == 0) {
                        id dataObject = [reqRes objectForKey:@"dataObject"];
                        NSString *status = [dataObject objectForKey:@"add_status"];
                        if ([status intValue] == 0) {
                            [self showMsgTitleIs:@"恭喜" message:@"你已成功加入该圈子" buttonText:@"好的"];
                        }else if ([status intValue] == 1){
                            [self showMsgTitleIs:@"对不起" message:@"你已是圈子成员,无法重复加入" buttonText:@"好的"];
                        }else if ([status intValue] == -1){
                            [self showMsgTitleIs:@"对不起" message:@"你无法加入该圈子" buttonText:@"好的"];
                        }
                    } else {
                        [self showMsgTitleIs:@"提示" message:@"加入圈子失败,请重新尝试" buttonText:@"好的"];
                    }
                }
            }
        }];
    }
}

@end
