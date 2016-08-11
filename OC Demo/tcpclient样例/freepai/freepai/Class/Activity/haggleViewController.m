//
//  haggleViewController.m
//  freepai
//
//  Created by admin on 14/6/16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "haggleViewController.h"
#import "MZTimerLabel.h"

@interface haggleViewController ()
{
    NSString *_recommand_price;
    NSString *_eachpoints;
    NSString *_overtime;
    NSString *_attackLabel;
    NSString *_projectid;
    MZTimerLabel *_timeCountDown;
}

@end

@implementation haggleViewController

-(id)init:(NSDictionary *)details
{
    self = [super init];
    if (self) {
        if (details) {
            DLog(@"%@",details);
            _recommand_price = [details objectForKey:@"recommand_price"];
            _eachpoints = [details objectForKey:@"eachpoints"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd HH:mm:ss"];
            NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[[details objectForKey:@"overtime"] integerValue]];
            _overtime = [formatter stringFromDate:endDate];
            _attackLabel = [details objectForKey:@"AttackLabel"];
            _projectid = [details objectForKey:@"auto_id"];
        }
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.scrollMsgView) {
        [self.scrollMsgView startRefreshData];
        [self.scrollMsgView startScrolling];
    }
    [self getNoeProjectResizeTime];
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
    [self setIsActive:YES];
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
    [homePageTitle  setText:[NSString stringWithFormat:@"杀价王-规则"]];
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
    
    //image
    UIImage *image = [UIImage imageNamed:@"About"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 100, 100)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    //
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(120, 100, self.view.frame.size.width - 140, 20)];
    price.text = [NSString stringWithFormat:@"建议售价：%@",_recommand_price];
    [price  setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.view addSubview:price];
    
    UILabel *needPoint = [[UILabel alloc] initWithFrame:CGRectMake(120, 100+20, self.view.frame.size.width - 140, 20)];
    needPoint.text = [NSString stringWithFormat:@"所需点数：%@点",_eachpoints];
    [needPoint  setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.view addSubview:needPoint];
    
    UILabel *minPoint = [[UILabel alloc] initWithFrame:CGRectMake(120, 100+20+20, self.view.frame.size.width - 140, 20)];
    minPoint.text = @"杀价低价：1点以上";
    [minPoint  setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.view addSubview:minPoint];
    
    UILabel *endTime = [[UILabel alloc] initWithFrame:CGRectMake(120, 100+20+20+20, self.view.frame.size.width - 140, 20)];
    endTime.text = [NSString stringWithFormat:@"结束时间：%@",_overtime];
    [endTime  setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.view addSubview:endTime];
    
    UILabel *first = [[UILabel alloc] initWithFrame:CGRectMake(120, 100+20+20+20+20, self.view.frame.size.width - 140, 20)];
    first.text = [NSString stringWithFormat:@"当前第一价格: %@",_attackLabel];
    [first  setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.view addSubview:first];
    
    UILabel *endTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 100, 40)];
    endTitle1.text = @"距离结束还有";
    [endTitle1  setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.view addSubview:endTitle1];
    
    _timeCountDown = [[MZTimerLabel alloc] initWithFrame:CGRectMake(130, 200, 120, 40)];
    _timeCountDown.timerType = MZTimerLabelTypeTimer;
    [self.view addSubview:_timeCountDown];
    //do some styling
    _timeCountDown.timeLabel.backgroundColor = [UIColor clearColor];
    //timeCountDown.timeLabel.font = [UIFont systemFontOfSize:28.0f];
    //timeCountDown.timeLabel.textColor = [UIColor brownColor];
    _timeCountDown.timeLabel.textAlignment = NSTextAlignmentCenter; //UITextAlignmentCenter is deprecated in iOS 7.0
    //fire
    _timeCountDown.delegate = self;
    [_timeCountDown setCountDownTime:0];
    
    UILabel *endTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(270, 200, 40, 40)];
    endTitle2.text = @"秒";
    [endTitle2  setFont:[UIFont fontWithName:@"Arial" size:14]];
    [self.view addSubview:endTitle2];
    
    _inputPriceTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 240, 120, 40)];
    _inputPriceTextField.borderStyle = UITextBorderStyleNone;
    _inputPriceTextField.font = [UIFont fontWithName:@"Arial" size:16];
    _inputPriceTextField.placeholder = @"杀价金额";
    _inputPriceTextField.delegate = self;
    _inputPriceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _inputPriceTextField.textColor = [UIColor grayColor];
    _inputPriceTextField.userInteractionEnabled = YES;
    [_inputPriceTextField.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [_inputPriceTextField.layer setBorderWidth:1.0]; //边框宽度
    [_inputPriceTextField.layer setBorderColor:[RGB(204,204,204) CGColor]]; //边框颜色
    [self.view addSubview:_inputPriceTextField];
    
    UIButton *haggelButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 240, 120, 40)];
    [haggelButton setTitleColor:RGB(12,180,234) forState:UIControlStateNormal];
    
    [haggelButton setTitle:@"出价" forState:UIControlStateNormal];
    haggelButton.userInteractionEnabled = YES;
    [haggelButton.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [haggelButton.layer setBorderWidth:1.0]; //边框宽度
    [haggelButton.layer setBorderColor:[RGB(204,204,204) CGColor]]; //边框颜色
    [haggelButton addTarget:self action:@selector(haggelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:haggelButton];
    
}



#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)haggelButtonClicked {
    NSLog(@"haggelButtonClicked");
    if ([self isActive]) {
        [self textFieldShouldReturn:_inputPriceTextField];
        if ([_inputPriceTextField.text length] > 0) {
            //出价
            /*
             NSString *msg = [NSString stringWithFormat:@"出价积分为:%@",_inputPriceTextField.text];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
             [alertView show];
             */
            [self userBidding];
        } else {
            NSString *msg = [NSString stringWithFormat:@"请填写出价积分数"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        
    } else {
        NSString *msg = [NSString stringWithFormat:@"IPAD mini杀价活动已经结束了！"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
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
    [_inputPriceTextField resignFirstResponder];
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(void)getNoeProjectResizeTime
{
    [[ServerDataManager sharedInstance] requestPPCFirstPageList:[CacheDataManager sharedInstance].uuid LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    NSMutableArray *projectsList = [[NSMutableArray alloc] initWithArray:[dataObject objectForKey:@"details"]];
                    for (NSDictionary *dict in projectsList) {
                        if ([[dict objectForKey:@"auto_id"] intValue] == [_projectid intValue]) {
                            [_timeCountDown setCountDownTime:[[dict objectForKey:@"resizetime"] intValue]];
                            [_timeCountDown start];
                        }
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

-(void)userBidding
{
    [[ServerDataManager sharedInstance] requestUserBuddingif:[CacheDataManager sharedInstance].uuid LoginResource:@"None" BiddingID:_projectid Price:[NSString stringWithFormat:@"%i",(int)[_inputPriceTextField.text intValue]] completeBlock:^(id reqRes) {
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                DLog(@"%@",dataObject);
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    NSString *action = [dataObject objectForKey:@"action"];
                    NSString *overall = [dataObject objectForKey:@"overall"];
                    NSString *one_price = [dataObject objectForKey:@"one_price"];
                    NSString *message = [NSString stringWithFormat:@"您的当前顺位:%@\n当前第一顺位价格为:%@",overall,one_price];
                    if ([action intValue] ==0) {
                        ALERT(@"出价成功", message, @"好的");
                    }else{
                        ALERT(@"很遗憾", @"您的出价失败,请重新尝试", @"好的");
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

@end
