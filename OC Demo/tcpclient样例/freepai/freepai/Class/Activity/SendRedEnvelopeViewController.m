//
//  SendRedEnvelopeViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "SendRedEnvelopeViewController.h"

@interface SendRedEnvelopeViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UITextField *scoreField;
    UITextField *countField;
    UITextView *messageView;
}

@property (nonatomic,strong) UIView *contentView;
@end

@implementation SendRedEnvelopeViewController

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
    
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 320, self.view.frame.size.height-70-TabViewHeight)];
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    
    [self setUpContentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpContentView
{
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 130, 30)];
    [scoreLabel  setBackgroundColor:[UIColor whiteColor]];
    [scoreLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [scoreLabel  setText:[NSString stringWithFormat:@"使用积分"]];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [scoreLabel  setTextColor:[UIColor blackColor]];
    [_contentView addSubview:scoreLabel];
    
    scoreField = [[UITextField alloc]initWithFrame:CGRectMake(150, 15, 130, 30)];
    scoreField.borderStyle = UITextBorderStyleRoundedRect;
    scoreField.placeholder = @"";
    scoreField.delegate = self;
    scoreField.clearButtonMode = UITextFieldViewModeWhileEditing;
    scoreField.textColor = [UIColor grayColor]; //灰色
    [_contentView addSubview:scoreField];
    
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, 130, 30)];
    [countLabel  setBackgroundColor:[UIColor whiteColor]];
    [countLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [countLabel  setText:[NSString stringWithFormat:@"红包个数"]];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [countLabel  setTextColor:[UIColor blackColor]];
    [_contentView addSubview:countLabel];
    

    countField = [[UITextField alloc]initWithFrame:CGRectMake(150, 55, 130, 30)];
    countField.borderStyle = UITextBorderStyleRoundedRect;
    countField.placeholder = @"";
    countField.delegate = self;
    countField.clearButtonMode = UITextFieldViewModeWhileEditing;
    countField.textColor = [UIColor grayColor]; //灰色
    [_contentView addSubview:countField];
    
    messageView = [[UITextView alloc] initWithFrame:CGRectMake(30, 95, 260, 80)];
    messageView.delegate = self;
    messageView.backgroundColor = [UIColor whiteColor];
    messageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    messageView.layer.borderWidth = 0.5;
    messageView.layer.cornerRadius = 4;
    messageView.returnKeyType = UIReturnKeyDone;
    [_contentView addSubview:messageView];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(60, 200, 200, 40);
    [sendButton setTitle:@"发红包" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [sendButton addTarget:self action:@selector(sendButton_touch) forControlEvents:UIControlEventTouchUpInside];
    sendButton.layer.cornerRadius = 4;
    sendButton.layer.borderColor = [UIColor grayColor].CGColor;
    sendButton.layer.borderWidth = 1;
    [_contentView addSubview:sendButton];
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)sendButton_touch
{
    DLog(@"here");
    if ([CacheDataManager sharedInstance].uuid && ![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestSendMoneyToPeople:[CacheDataManager sharedInstance].uuid LoginResource:@"None" money:scoreField.text count:countField.text priority:@"2" completeBlock:^(id reqRes) {
            DLog(@"%@",reqRes);
            if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
                AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
                if (operation.response.statusCode == 200) {
                    NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                    id dataObject = [dict objectForKey:@"dataObject"];
                    if ([dataObject isKindOfClass:[NSDictionary class]]) {
                        int action = [[dataObject objectForKey:@"action"] intValue];
                        if (action == 0) {
                            ALERT(@"恭喜", @"发送红包成功", @"好的");
                        }else if (action == 1){
                            ALERT(@"提示", @"今日您已发送过红包,请明日再试", @"好的");
                        }else if (action == 2){
                            ALERT(@"对不起", @"您还没有自己的圈子,请先创建自己的圈子", @"好的");
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
    return YES;
}


#pragma mark - UITextFieldDelegate
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [scoreField resignFirstResponder];
    [countField resignFirstResponder];
    [messageView resignFirstResponder];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
	self.view.frame = rect;
	[UIView commitAnimations];
	[textField resignFirstResponder];
	return YES;
}

-(void)textFieldAllResignFirstResponder
{
    NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
	self.view.frame = rect;
	[UIView commitAnimations];
    [scoreField resignFirstResponder];
    [countField resignFirstResponder];
    [messageView resignFirstResponder];
}

#define Move_Height 110
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGRect frame = textField.frame;
	int offset =frame.origin.y + Move_Height - (self.view.frame.size.height - 216.0);
	NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width = self.view.frame.size.width;
	float height = self.view.frame.size.height;
	if (offset >0) {
		CGRect rect =CGRectMake(0.0f, -offset, width, height);
		self.view.frame =rect;
	}
	[UIView commitAnimations];
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
@end
