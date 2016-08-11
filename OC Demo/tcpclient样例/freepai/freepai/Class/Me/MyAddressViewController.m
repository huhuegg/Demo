//
//  MyAddressViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MyAddressViewController.h"
#import "MyAddressTableViewCell.h"
#import "UIViewController+CWPopup.h"
#import "AddMyInfoViewController.h"
#import "MainViewController.h"

@interface MyAddressViewController ()<UITableViewDataSource,UITableViewDelegate,AddMyInfoViewControllerDelegate>
{
    UIButton *_addAddressButton;
}
@end

@implementation MyAddressViewController

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
    self.addressList = [[NSMutableArray alloc] initWithArray:[[DBOperation sharedInstance] searchTableForAllOfMyAddress]];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"我的收货地址"]];
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
    
    self.meAddressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-60-TabViewHeight)];
    self.meAddressTableView.tag = 0;
    self.meAddressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.meAddressTableView.delegate = self;
    self.meAddressTableView.dataSource = self;
    self.meAddressTableView.scrollsToTop = YES;
    self.meAddressTableView.backgroundColor = [UIColor clearColor];
    self.meAddressTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.view addSubview:self.meAddressTableView];

    
    _addAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addAddressButton.frame = CGRectMake(0, 0, 40, 40);
    _addAddressButton.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT-25-TabViewHeight);
    [_addAddressButton setImage:[UIImage imageNamed:@"AddAddressButton"] forState:UIControlStateNormal];
    [_addAddressButton setImage:[UIImage imageNamed:@"AddAddressButton"] forState:UIControlStateHighlighted];
    [_addAddressButton addTarget:self action:@selector(addAddress_touch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addAddressButton];
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

-(void)addAddress_touch:(UIButton *)sender
{
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim1.duration = 0.4f;
    anim1.fromValue = nil;
    anim1.toValue = [NSNumber numberWithFloat:0.6f];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim1.fillMode = kCAFillModeForwards;
    anim1.removedOnCompletion = NO;
    [_addAddressButton.layer addAnimation:anim1 forKey:nil];
    
    AddMyInfoViewController *addMyInfo = [[AddMyInfoViewController alloc] init:AddMyAddress];
    addMyInfo.delegate= self;
    [self presentPopupViewController:addMyInfo animated:YES completion:^(void) {
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
        self.tapRecognizer.numberOfTouchesRequired = 1;
        self.tapRecognizer.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:self.tapRecognizer];
    }];
}

-(void)addButton_Touch
{
    AddMyInfoViewController *addMyInfo = [[AddMyInfoViewController alloc] init:AddMyAddress];
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
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim1.duration = 0.4f;
    anim1.fromValue = nil;
    anim1.toValue = [NSNumber numberWithFloat:1.f];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim1.fillMode = kCAFillModeForwards;
    anim1.removedOnCompletion = NO;
    [_addAddressButton.layer addAnimation:anim1 forKey:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyAddressListCell";
    MyAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MyAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dict = [self.addressList objectAtIndex:indexPath.row];
    [cell animationLogoImg];
    cell.name.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"person"]];
    cell.telephone.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"telephone"]];
    cell.address.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"location"]];
    return cell;
}

 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark - AddMyInfoViewControllerDelegate
-(void)addAddressWithPerson:(NSString *)person PostCode:(NSString *)postcode Tele:(NSString *)telephone Area:(NSString *)area Location:(NSString *)location
{
    [[DBOperation sharedInstance] insertMyAddressTableWithPerson:person PostCode:postcode Tele:telephone Area:area Location:location];
    self.addressList = [[NSMutableArray alloc] initWithArray:[[DBOperation sharedInstance] searchTableForAllOfMyAddress]];
    [self.meAddressTableView reloadData];
    [self dismissPopup];
}
@end
