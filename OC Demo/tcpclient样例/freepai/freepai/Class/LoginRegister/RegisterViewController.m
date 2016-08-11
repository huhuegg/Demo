//
//  RegisterViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "RegisterViewController.h"
#import "MainViewController.h"
#import "LocalDataManager.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UILabel *verifyCodeLabel1;
    UILabel *verifyCodeLabel2;
    int secondsCountDown;//验证码超时倒计时
    NSTimer *countDownTimer;
    UIButton * verifyCodeButton;
}

@end

@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [countDownTimer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, 30)];
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"自由派"]];
    homePageTitle.textAlignment = NSTextAlignmentCenter;
    [homePageTitle  setTextColor:RGB(229, 61, 22)];
    [self.view addSubview:homePageTitle];
    
    
    UIControl *leftControl = [[UIControl alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 60, 30)];
    leftControl.backgroundColor = [UIColor clearColor];
    [leftControl addTarget:self action:@selector(leftControl_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftControl];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    leftImageView.image = [UIImage imageNamed:@"homePageLeft"];
    [leftControl addSubview:leftImageView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 40, 30)];
    [leftLabel  setBackgroundColor:[UIColor clearColor]];
    [leftLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [leftLabel  setText:[NSString stringWithFormat:@"返回"]];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [leftLabel  setTextColor:RGB(0, 89, 255)];
    [leftControl addSubview:leftLabel];
    
    
    ScrollMsgView *scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, StatusBarHeight +homePageTitle.frame.size.height, self.view.frame.size.width, 15)];
    scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollMsgView];
    
    
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + homePageTitle.frame.size.height + scrollMsgView.frame.size.height, SCREEN_WIDTH,SCREEN_HEIGHT-StatusBarHeight - homePageTitle.frame.size.height - scrollMsgView.frame.size.height)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    
    UIView *textFieldControl = [[UIView alloc] initWithFrame:CGRectMake(50, 80+StatusBarHeight, 220, 203)];
    textFieldControl.backgroundColor = [UIColor whiteColor];
    textFieldControl.layer.cornerRadius = 12;
    textFieldControl.userInteractionEnabled = YES;
    [textFieldControl.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [textFieldControl.layer setBorderWidth:1.0]; //边框宽度
    [textFieldControl.layer setBorderColor:[RGB(204,204,204) CGColor]]; //边框颜色
    [self.view addSubview:textFieldControl];
    
    
    self.recommCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 112, 180, 30)];
    self.recommCodeTextField.borderStyle = UITextBorderStyleNone;
    self.recommCodeTextField.font = [UIFont fontWithName:@"Arial" size:14];
    self.recommCodeTextField.placeholder = @"推荐码";
    self.recommCodeTextField.delegate = self;
    self.recommCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.recommCodeTextField.textColor = [UIColor grayColor];
    [self.view addSubview:self.recommCodeTextField];
    
    UIView *textFieldControl_middleline_one = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 200, 1)];
    textFieldControl_middleline_one.backgroundColor = [UIColor lightGrayColor];
    [textFieldControl addSubview:textFieldControl_middleline_one];
    
    self.phoneNumTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 162, 180, 30)];
    self.phoneNumTextField.borderStyle = UITextBorderStyleNone;
    self.phoneNumTextField.font = [UIFont fontWithName:@"Arial" size:14];
    self.phoneNumTextField.placeholder = @"手机号";
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneNumTextField.textColor = [UIColor grayColor];
    [self.view addSubview:self.phoneNumTextField];
    
    UIView *textFieldControl_middleline_two = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 200, 1)];
    textFieldControl_middleline_two.backgroundColor = [UIColor lightGrayColor];
    [textFieldControl addSubview:textFieldControl_middleline_two];
    
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 213, 180, 30)];
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.font = [UIFont fontWithName:@"Arial" size:14];
    self.passwordTextField.placeholder = @"密  码";
    self.passwordTextField.delegate = self;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.textColor = [UIColor grayColor];
    [self.view addSubview:self.passwordTextField];
    
    UIView *textFieldControl_middleline_three = [[UIView alloc] initWithFrame:CGRectMake(10, 150, 200, 1)];
    textFieldControl_middleline_three.backgroundColor = [UIColor lightGrayColor];
    [textFieldControl addSubview:textFieldControl_middleline_three];
    
    self.passwordRepeatTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 263, 180, 30)];
    self.passwordRepeatTextField.borderStyle = UITextBorderStyleNone;
    self.passwordRepeatTextField.font = [UIFont fontWithName:@"Arial" size:14];
    self.passwordRepeatTextField.placeholder = @"请填写提现的支付宝账号";
    self.passwordRepeatTextField.delegate = self;
    self.passwordRepeatTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordRepeatTextField.textColor = [UIColor grayColor];
    [self.view addSubview:self.passwordRepeatTextField];
    
    
    
    UIView *verifyCodeControl = [[UIView alloc] initWithFrame:CGRectMake(50, 293+StatusBarHeight, 220, 50)];
    verifyCodeControl.backgroundColor = [UIColor whiteColor];
    verifyCodeControl.layer.cornerRadius = 8;
    verifyCodeControl.userInteractionEnabled = YES;
    [verifyCodeControl.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [verifyCodeControl.layer setBorderWidth:1.0]; //边框宽度
    [verifyCodeControl.layer setBorderColor:[RGB(204,204,204) CGColor]]; //边框颜色
    
    [self.view addSubview:verifyCodeControl];
    
    
    verifyCodeLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 80, 22)];
    [verifyCodeLabel1  setBackgroundColor:[UIColor clearColor]];
    [verifyCodeLabel1  setFont:[UIFont fontWithName:@"Arial" size:12]];
    [verifyCodeLabel1  setText:[NSString stringWithFormat:@"短信获取"]];
    verifyCodeLabel1.textAlignment = NSTextAlignmentCenter;
    [verifyCodeLabel1  setTextColor:RGB(6, 163, 232)];
    [verifyCodeControl addSubview:verifyCodeLabel1];
    
    
    verifyCodeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 80, 20)];
    [verifyCodeLabel2  setBackgroundColor:[UIColor clearColor]];
    [verifyCodeLabel2  setFont:[UIFont fontWithName:@"Arial" size:12]];
    [verifyCodeLabel2  setText:[NSString stringWithFormat:@"验证码"]];
    verifyCodeLabel2.textAlignment = NSTextAlignmentCenter;
    [verifyCodeLabel2  setTextColor:RGB(6, 163, 232)];
    [verifyCodeControl addSubview:verifyCodeLabel2];
    
    UIView *verifyCodeLabelControlLine = [[UIView alloc] initWithFrame:CGRectMake(81, 5, 1, 40)];
    verifyCodeLabelControlLine.backgroundColor = [UIColor lightGrayColor];
    [verifyCodeControl addSubview:verifyCodeLabelControlLine];
    
    self.verifyCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(140, 325, 100, 30)];
    self.verifyCodeTextField.borderStyle = UITextBorderStyleNone;
    self.verifyCodeTextField.tag = 1;
    self.verifyCodeTextField.delegate = self;
    self.verifyCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verifyCodeTextField.secureTextEntry = YES;
    self.verifyCodeTextField.textColor = [UIColor grayColor]; 
    [self.view addSubview:self.verifyCodeTextField];
    
    
    verifyCodeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    verifyCodeButton.frame = CGRectMake(0, 0, 80, 50);
    verifyCodeButton.backgroundColor = [UIColor clearColor];
    verifyCodeButton.layer.cornerRadius = 8;
    [verifyCodeButton addTarget:self action:@selector(verifyCodeButton_touch) forControlEvents:UIControlEventTouchUpInside];
    [verifyCodeControl addSubview:verifyCodeButton];
    
    
    
    UIButton * registerButton =[UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(50, 353 + StatusBarHeight, 220, 40);
    registerButton.backgroundColor = [UIColor whiteColor];
    [registerButton setTitle:@"提交注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    [registerButton setTitleColor:RGB(6, 163, 232) forState:UIControlStateNormal];
    [registerButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [registerButton.layer setBorderWidth:1.0]; //边框宽度
    [registerButton.layer setBorderColor:[RGB(204,204,204) CGColor]];
    [registerButton addTarget:self action:@selector(registerButton_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    
    UILabel *version_one = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT- 40, SCREEN_WIDTH, 20)];
    [version_one  setBackgroundColor:[UIColor whiteColor]];
    [version_one  setFont:[UIFont fontWithName:@"Arial" size:8]];
    [version_one  setText:[NSString stringWithFormat:@"自由派版权所有"]];
    version_one.textAlignment = NSTextAlignmentCenter;
    [version_one  setTextColor:RGB(144, 135, 135)];
    [self.view addSubview:version_one];
    
    
    UILabel *version_two = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT- 25, SCREEN_WIDTH, 20)];
    [version_two  setBackgroundColor:[UIColor whiteColor]];
    [version_two  setFont:[UIFont fontWithName:@"Arial" size:8]];
    [version_two  setText:[NSString stringWithFormat:@"2014"]];
    version_two.textAlignment = NSTextAlignmentCenter;
    [version_two  setTextColor:RGB(144, 135, 135)];
    [self.view addSubview:version_two];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.recommCodeTextField = nil;
    self.phoneNumTextField = nil;
    self.passwordTextField = nil;
    self.passwordRepeatTextField = nil;
    self.verifyCodeTextField = nil;
    verifyCodeLabel1 = nil;
    verifyCodeLabel2 = nil;
    countDownTimer = nil;
    verifyCodeButton = nil;
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取验证码
-(void)verifyCodeButton_touch
{
    [[ServerDataManager sharedInstance] requestMobileToken:self.phoneNumTextField.text completeBlock:^(id reqRes) {
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                secondsCountDown = 120;
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                verifyCodeButton.enabled=NO;
            }else{
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                ALERT(status, dataString, @"好的");
            }
        }
    }];
}

//注册提交
-(BOOL)registerButton_touch
{
    [self textFieldAllResignFirstResponder];
    if (!self.phoneNumTextField.text || [self.phoneNumTextField.text isEqualToString:@""]) {
        ALERT(@"警告", @"手机号码不能为空,请输入", @"好的");
        return NO;
    }
    
    if (!self.passwordTextField.text || [self.passwordTextField.text isEqualToString:@""]) {
        ALERT(@"警告", @"密码不能为空,请输入", @"好的");
        return NO;
    }
    
    if (!self.verifyCodeTextField.text || [self.verifyCodeTextField.text isEqualToString:@""]){
        ALERT(@"尚未获得验证码", @"请先点击验证码获取按钮", @"好的");
        return NO;
    }

    [[ServerDataManager sharedInstance] requestAccountRegister:self.phoneNumTextField.text Username:self.phoneNumTextField.text Password:self.passwordTextField.text Resource:@"None" Platform:@"Android" Veriftycode:self.verifyCodeTextField.text completeBlock:^(id reqRes) {
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                [self improveUserInformation];
            }else{
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                ALERT(status, dataString, @"好的");
            }
        }
    }];
    return YES;
}


-(void)timeFireMethod{
    secondsCountDown--;
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [verifyCodeLabel1  setText:[NSString stringWithFormat:@"短信获取"]];
        [verifyCodeLabel2  setText:[NSString stringWithFormat:@"验证码"]];
        verifyCodeButton.enabled=YES;
    } else {
        verifyCodeButton.enabled=NO;
        verifyCodeLabel1.text = [[NSString alloc]initWithFormat:@"%i秒后",secondsCountDown];;
        verifyCodeLabel2.text = @"重新获取";
    }
}


#pragma mark - UITextFieldDelegate
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self textFieldAllResignFirstResponder];
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
    [self.recommCodeTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.passwordRepeatTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
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


#pragma mark - 其他方法


//完善用户信息
-(void)improveUserInformation
{
    NSString *code;
    NSString *deviceToken;
    if ([self.recommCodeTextField.text isEqualToString:@""] || !self.recommCodeTextField.text) {
        code = @"None";
    }else{
        code = self.recommCodeTextField.text;
    }
    
    if ([CacheDataManager sharedInstance].devicePushToken) {
        deviceToken = [CacheDataManager sharedInstance].devicePushToken;
    }else{
        deviceToken = @"None";
    }
    
    [[ServerDataManager sharedInstance] requestImproveInformation:_phoneNumTextField.text Password:_passwordTextField.text Code:code Pushtoken:deviceToken completeBlock:^(id reqRes){
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                [self loginAndJumpToMainView];
            }else{
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
               // ALERT(status, dataString, @"好的");
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:status message:dataString delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
                [alerView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    [self improveUserInformation];
                }];
            }
        }
    }];
}


//登录到主页面
-(void) loginAndJumpToMainView {
    NSString *userName = [CacheDataManager sharedInstance].userName;
    NSString *password = [CacheDataManager sharedInstance].password;
    [[CacheDataManager sharedInstance]save];
    
    NSLog(@"loginAndJumpToMainView userName:%@ Password:%@",userName,password);
    
    [[ServerDataManager sharedInstance]requestUserLogin:userName Password:password completeBlock:^(id reqRes){
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    int finished = [[dataObject objectForKey:@"finished"] intValue];
                    if (finished == 2 || finished == 3) {
                        [[CacheDataManager sharedInstance]save];
                        MainViewController *mainViewController = [[MainViewController alloc] init];
                        if (mainViewController) {
                            [self presentViewController:mainViewController animated:YES completion:nil];
                        }
                    }else{
                        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"finished!=2、3" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
                        [alerView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                            [self loginAndJumpToMainView];
                        }];
                    }
                }
            }else{
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                //ALERT(status, dataString, @"好的");
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:status message:dataString delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
                [alerView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    [self loginAndJumpToMainView];
                }];
            }
        }
    }];
    
}
@end
