//
//  LoginViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-9.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
#import "TcpCmdHandler.h"
#import "CacheDataManager.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    int request_count;
}

@end

@implementation LoginViewController

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
    //个人信息表
    [[CacheDataManager sharedInstance] load];
    [[TcpCmdHandler instance] connServer];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.height - 22)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"自由派"]];
    homePageTitle.textAlignment = NSTextAlignmentCenter;
    [homePageTitle  setTextColor:[UIColor redColor]];
    [bg_ImageView addSubview:homePageTitle];
    
    
    ScrollMsgView *scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollMsgView];
    
    
    
    UIView *textFieldControl = [[UIView alloc] initWithFrame:CGRectMake(50, 80, 220, 101)];
    textFieldControl.backgroundColor = [UIColor whiteColor];
    textFieldControl.layer.cornerRadius = 12;
    textFieldControl.userInteractionEnabled = YES;
    [textFieldControl.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [textFieldControl.layer setBorderWidth:1.0]; //边框宽度
    [textFieldControl.layer setBorderColor:[RGB(204,204,204) CGColor]]; //边框颜色
    [self.view addSubview:textFieldControl];
    
    
    self.userNameField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, 180, 30)];
    self.userNameField.borderStyle = UITextBorderStyleNone;
    self.userNameField.placeholder = @"手机号";
    self.userNameField.delegate = self;
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameField.textColor = [UIColor grayColor]; //灰色
    NSLog(@"read cache userName:%@",[CacheDataManager sharedInstance].userName);
    if ([CacheDataManager sharedInstance].userName && ![[CacheDataManager sharedInstance].userName isEqualToString:@"None"]) {
        self.userNameField.text = [CacheDataManager sharedInstance].userName;
    }

    [textFieldControl addSubview:self.userNameField];
    
    UIView *textFieldControl_middleline = [[UIView alloc] initWithFrame:CGRectMake(10, 50, 200, 1)];
    textFieldControl_middleline.backgroundColor = [UIColor lightGrayColor];
    [textFieldControl addSubview:textFieldControl_middleline];

    self.passWordField = [[UITextField alloc]initWithFrame:CGRectMake(20, 61, 180, 30)];
    self.passWordField.borderStyle = UITextBorderStyleNone;
    self.passWordField.placeholder = @"密  码";
    self.passWordField.delegate = self;
    self.passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordField.secureTextEntry = YES;
    self.passWordField.textColor = [UIColor grayColor]; //灰色
    NSLog(@"read cache password:%@",[CacheDataManager sharedInstance].password);
    if ([CacheDataManager sharedInstance].password && ![[CacheDataManager sharedInstance].password isEqualToString:@"None"]) {
        self.passWordField.text = [CacheDataManager sharedInstance].password;
    }
    [textFieldControl addSubview:self.passWordField];
    
    
    UIButton * loginButton =[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(50, 220, 220, 40);
    loginButton.backgroundColor = [UIColor whiteColor];
    [loginButton setTitle:@"登  陆" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    [loginButton setTitleColor:RGB(12,180,234) forState:UIControlStateNormal];
    [loginButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [loginButton.layer setBorderWidth:1.0]; //边框宽度
    [loginButton.layer setBorderColor:[RGB(204,204,204) CGColor]];
    [loginButton addTarget:self action:@selector(loginButton_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
 
    UILabel *version_one = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT- 40, SCREEN_WIDTH, 20)];
    [version_one  setBackgroundColor:[UIColor whiteColor]];
    [version_one  setFont:[UIFont fontWithName:@"Arial" size:10]];
    [version_one  setText:[NSString stringWithFormat:@"自由派版权所有"]];
    version_one.textAlignment = NSTextAlignmentCenter;
    [version_one  setTextColor:RGB(204,204,204)];
    [self.view addSubview:version_one];
 
    
    UILabel *version_two = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT- 25, SCREEN_WIDTH, 20)];
    [version_two  setBackgroundColor:[UIColor whiteColor]];
    [version_two  setFont:[UIFont fontWithName:@"Arial" size:10]];
    [version_two  setText:[NSString stringWithFormat:@"2014"]];
    version_two.textAlignment = NSTextAlignmentCenter;
    [version_two  setTextColor:RGB(204,204,204)];
    [self.view addSubview:version_two];
    
    
    UIButton * registerButton =[UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(0, 0, 220, 40);
    registerButton.center = CGPointMake(self.view.center.x, bg_ImageView.frame.size.height - 80);
    [registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    [registerButton setTitleColor:RGB(12,180,234) forState:UIControlStateNormal];
    [registerButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [registerButton.layer setBorderWidth:1.0]; //边框宽度
    [registerButton.layer setBorderColor:[RGB(204,204,204) CGColor]];
    [registerButton addTarget:self action:@selector(registerButton_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    if (self.userNameField.text.length>0 && self.passWordField.text.length>0) {
        [self loginButton_touch];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.userNameField = nil;
    self.passWordField = nil;
}

#pragma mark - ButtonAction
-(BOOL)loginButton_touch
{
    
    [self.userNameField resignFirstResponder];
    [self.passWordField resignFirstResponder];
    if (!self.userNameField.text || [self.userNameField.text isEqualToString:@""]) {
        ALERT(@"警告", @"手机号码不能为空,请输入", @"好的");
        return NO;
    }
    
    if (!self.passWordField.text || [self.passWordField.text isEqualToString:@""]) {
        ALERT(@"警告", @"密码不能为空,请输入", @"好的");
        return NO;
    }
    
    [[ServerDataManager sharedInstance] requestUserLogin:self.userNameField.text Password:self.passWordField.text completeBlock:^(id reqRes) {
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    int finished = [[dataObject objectForKey:@"finished"] intValue];
                    if (finished == 2 || finished == 3) {
                        [[CacheDataManager sharedInstance] save];
                        MainViewController *mainViewController = [[MainViewController alloc] init];
                        if (mainViewController) {
                            [self presentViewController:mainViewController animated:YES completion:nil];
                        }
                        [self getUserTeams];
                       // [self getUserIntegral];
                    }else{
                        ALERT(@"登录失败", @"finished=0、不等于2或者3", @"好的");
                    }
                }
            }else{
                /*
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                ALERT(status, dataString, @"好的");
                 */
            }
        }
    }];
    return YES;
}

-(void)registerButton_touch
{
    NSLog(@"reg button clicked");
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    [self presentViewController:registerViewController animated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userNameField resignFirstResponder];
    [self.passWordField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userNameField resignFirstResponder];
    [self.passWordField resignFirstResponder];
}

#pragma mark - 其他方法
-(void)showMsgTitleIs:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:buttonText
                                              otherButtonTitles:nil];
    [alertView show];
    
}

//获取自建帮派信息
-(void)getUserTeams
{
    if ([CacheDataManager sharedInstance].uuid && ![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestUserTeam:[CacheDataManager sharedInstance].uuid  LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
            if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
                AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
                if (operation.response.statusCode == 200) {
                    NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                    id dataObject = [dict objectForKey:@"dataObject"];
                    DLog(@"%@",dataObject);
                }
            }
        }];
    }
}

/*
//获取自建帮派信息
-(void)getUserTeams
{
    if ([CacheDataManager sharedInstance].uuid && ![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestUserTeam:[CacheDataManager sharedInstance].uuid  LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
            if ([reqRes isKindOfClass:[NSError class]]) {
                if (request_count <= 3) {
                    [self getUserTeams];
                }
                request_count ++;
            }else if ([reqRes isKindOfClass:[NSDictionary class]]){
                if ([[reqRes objectForKey:@"code"]intValue] != 0) {
                    if (request_count <= 3) {
                        [self getUserTeams];
                    }
                    request_count ++;
                }
            }
        }];
    }
}


-(void)getUserIntegral
{
    if ([CacheDataManager sharedInstance].uuid && ![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestUserPointOwnerSearch:[CacheDataManager sharedInstance].uuid  LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
            DLog(@"%@",reqRes);
        }];
    }
}
 */


@end
