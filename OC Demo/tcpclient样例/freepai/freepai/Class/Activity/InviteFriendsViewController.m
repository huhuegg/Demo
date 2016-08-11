//
//  InviteFriendsViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "InviteFriendsViewController.h"
#import "YukeyScrollView.h"
#import "ShareSDKOperation.h"

//动画时间
#define kAnimationDuration 0
//view高度
#define kViewHeight 56

@interface InviteFriendsViewController ()<UITextViewDelegate>

@end

@implementation InviteFriendsViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
   // bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"邀请好友"]];
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
    
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    testView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testView];
    
    YukeyScrollView *yukeyScrollView = [[YukeyScrollView alloc] initWithFrame:CGRectMake(0, 67, 320, 150) withImageArray:@[@"one",@"two",@"three",@"four"]];
    yukeyScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:yukeyScrollView];
    
    UILabel *inviteTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 320, 30)];
    [inviteTitle  setBackgroundColor:[UIColor clearColor]];
    [inviteTitle  setFont:[UIFont fontWithName:@"Arial" size:14]];
    [inviteTitle  setText:[NSString stringWithFormat:@"邀友留言"]];
    inviteTitle.textAlignment = NSTextAlignmentCenter;
    [inviteTitle  setTextColor:[UIColor blackColor]];
    [self.view addSubview:inviteTitle];
    
    
    //添加键盘的监听事件
    
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
    
    self.InviteWordsTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 250, 300, 50)];
    self.InviteWordsTextView.backgroundColor = [UIColor clearColor];
    self.InviteWordsTextView.delegate = self;
    self.InviteWordsTextView.scrollEnabled= YES;
    self.InviteWordsTextView.textColor = [UIColor lightGrayColor];
    self.InviteWordsTextView.text = @"  我是xxx，快来帮帮我呀 ！ 我要送你很多，很多，很多的积分 ！";
    self.InviteWordsTextView.layer.cornerRadius = 6;
    self.InviteWordsTextView.layer.borderWidth = 0.5;
    self.InviteWordsTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.InviteWordsTextView.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.InviteWordsTextView];
    
    NSArray *sharePlatArray = @[@"通讯录",@"新浪微博",@"微信好友",@"微信朋友圈"];
    for (NSString *name in sharePlatArray) {
        int index = (int)[sharePlatArray indexOfObject:name];
        
        UIControl *shareControl = [[UIControl alloc] initWithFrame:CGRectMake(80*index, 305, 80, 50)];
        shareControl.backgroundColor = RGB(0, 89, 255);
        shareControl.tag = index;
        [shareControl addTarget:self action:@selector(shareControl_touch:) forControlEvents:UIControlEventTouchUpInside];
        shareControl.layer.borderColor = [UIColor lightGrayColor].CGColor;
        shareControl.layer.borderWidth = 0.5;
        [self.view addSubview:shareControl];
        
        UILabel *shareControlTop = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
        [shareControlTop  setBackgroundColor:[UIColor clearColor]];
        [shareControlTop  setFont:[UIFont fontWithName:@"Arial" size:12]];
        [shareControlTop  setText:name];
        shareControlTop.textAlignment = NSTextAlignmentCenter;
        [shareControlTop  setTextColor:[UIColor blackColor]];
        [shareControl addSubview:shareControlTop];
        
        UILabel *shareControlBottom = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 80, 25)];
        [shareControlBottom  setBackgroundColor:[UIColor clearColor]];
        [shareControlBottom  setFont:[UIFont fontWithName:@"Arial" size:12]];
        if (index == 0) {
             [shareControlBottom  setText:@"10积分"];
        }else if (index == 1){
             [shareControlBottom  setText:@"30积分"];
        }else if (index == 2){
             [shareControlBottom  setText:@"30积分"];
        }else if (index == 3){
             [shareControlBottom  setText:@"20积分"];
        }
       
        shareControlBottom.textAlignment = NSTextAlignmentCenter;
        [shareControlBottom  setTextColor:[UIColor blackColor]];
        [shareControl addSubview:shareControlBottom];
    }
    
    UILabel *BottomLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 360, 320, 15)];
    [BottomLabel1  setBackgroundColor:[UIColor clearColor]];
    [BottomLabel1  setFont:[UIFont fontWithName:@"Arial" size:10]];
    [BottomLabel1  setText:@"每个由您邀请的好友，都将在以后的日子里"];
    BottomLabel1.textAlignment = NSTextAlignmentCenter;
    [BottomLabel1  setTextColor:[UIColor blackColor]];
    [self.view addSubview:BottomLabel1];
    
    UILabel *BottomLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 375, 320, 15)];
    [BottomLabel2  setBackgroundColor:[UIColor clearColor]];
    [BottomLabel2  setFont:[UIFont fontWithName:@"Arial" size:10]];
    [BottomLabel2  setText:@"与你并肩战斗，分享很多很多的胜利果实"];
    BottomLabel2.textAlignment = NSTextAlignmentCenter;
    [BottomLabel2  setTextColor:[UIColor blackColor]];
    [self.view addSubview:BottomLabel2];
    
    UILabel *BottomLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 390, 320, 15)];
    [BottomLabel3  setBackgroundColor:[UIColor clearColor]];
    [BottomLabel3  setFont:[UIFont fontWithName:@"Arial" size:10]];
    [BottomLabel3  setText:@"你还等什么，快找小伙伴儿来分金币吧"];
    BottomLabel3.textAlignment = NSTextAlignmentCenter;
    [BottomLabel3  setTextColor:[UIColor blackColor]];
    [self.view addSubview:BottomLabel3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareControl_touch:(id)sender
{
    if ([sender isKindOfClass:[UIControl class]]) {
        UIControl *control = (UIControl *)sender;
        if (control.tag == 0) {
            [[ShareSDKOperation sharedInstance] shareBySMSClickHandler:sender];
        }else if (control.tag == 1){
            [[ShareSDKOperation  sharedInstance] shareToSinaWeiboClickHandler:sender];
        }else if (control.tag == 2){
            [[ShareSDKOperation sharedInstance] shareToWeixinSessionClickHandler:sender];
        }else if (control.tag == 3){
            [[ShareSDKOperation sharedInstance] shareToWeixinTimelineClickHandler:sender];
        }
    }
}


#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder]; return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self.InviteWordsTextView resignFirstResponder];
}



// 键盘弹出时
-(void)keyboardDidShow:(NSNotification *)notification
{
    
    //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    
    [keyboardObject getValue:&keyboardRect];
    
    //调整放置有textView的view的位置
    
    //设置动画
    [UIView beginAnimations:nil context:nil];
    
    //定义动画时间
    [UIView setAnimationDuration:kAnimationDuration];
    
    //设置view的frame，往上平移
    [self.view setFrame:CGRectMake(0, -kViewHeight, 320, self.view.frame.size.height)];
    
    [UIView commitAnimations];
    
}


//键盘消失时
-(void)keyboardDidHidden
{
    //定义动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往下平移
    [self.view setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [UIView commitAnimations];
}
@end
