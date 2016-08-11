//
//  MyAccountViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MeAllTableViewCell.h"
#import "UIViewController+CWPopup.h"
#import "AddMyInfoViewController.h"

@interface MyAccountViewController ()<UITableViewDataSource,UITableViewDelegate,AddMyInfoViewControllerDelegate>

@end

@implementation MyAccountViewController

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
    DLog(@"%i",[[DBOperation sharedInstance] searchTableForMyAccount].count);
    
    self.accountList = [[NSMutableArray alloc] initWithArray:[[DBOperation sharedInstance] searchTableForMyAccount]];
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
    [homePageTitle  setText:[NSString stringWithFormat:@"我的支付宝"]];
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
    // Do any additional setup after loading the view.
    
    self.meAccountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-55-TabViewHeight)];
    self.meAccountTableView.tag = 0;
    self.meAccountTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meAccountTableView.delegate = self;
    self.meAccountTableView.dataSource = self;
    self.meAccountTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.meAccountTableView];
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

-(void)addButton_Touch
{
    AddMyInfoViewController *addMyInfo = [[AddMyInfoViewController alloc] init:AddMyAccount];
    addMyInfo.delegate= self;
    [self presentPopupViewController:addMyInfo animated:YES completion:^(void) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
        self.tapRecognizer.numberOfTouchesRequired = 1;
        self.tapRecognizer.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:self.tapRecognizer];
    }];
}


- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            [self.view removeGestureRecognizer:self.tapRecognizer];
        }];
    }
}



#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.accountList.count;
    }else{
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    headView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 20)];
    [titleLabel  setBackgroundColor:[UIColor clearColor]];
    [titleLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
    [titleLabel  setText:[NSString stringWithFormat:@"已绑定的支付宝账号"]];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel  setTextColor:[UIColor whiteColor]];
    [headView addSubview:titleLabel];
    if (section == 0) {
        return headView;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else {
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"MyAccountListCell";
        MeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MeAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.bottomLabel.text = [self.accountList objectAtIndex:indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellIdentifier = @"MyAccountButtonCell";
        MeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MeAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        [cell.addButton addTarget:self action:@selector(addButton_Touch) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

#pragma mark - AddMyInfoViewControllerDelegate
-(void)addAccount:(NSString *)account
{
    [[DBOperation sharedInstance] insertMyAccountTableWithAccount:account];
    self.accountList = [[NSMutableArray alloc] initWithArray:[[DBOperation sharedInstance] searchTableForMyAccount]];
    [self.meAccountTableView reloadData];
    [self dismissPopup];
}
@end
