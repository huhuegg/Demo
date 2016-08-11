//
//  AddMyInfoViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "AddMyInfoViewController.h"

@interface AddMyInfoViewController ()<UITextFieldDelegate>
{
    BOOL Ismove;
    float AllHeight;
}

@end

@implementation AddMyInfoViewController

-(id)init:(AddMyInfoStyle)style
{
    self = [super init];
    if (self) {
        self.myStyle = style;
        if (style == AddMyAccount) {
            CGRect frame = self.view.frame;
            frame.size.width = 250;
            frame.size.height = 100;
            self.view.frame = frame;
        }else if (style == AddMyAddress){
            CGRect frame = self.view.frame;
            frame.size.width = 250;
            frame.size.height = 260;
            self.view.frame = frame;
        }else if (style == AddMyQuanZi) {
            CGRect frame = self.view.frame;
            frame.size.width = 250;
            frame.size.height = 100;
            self.view.frame = frame;
        }else if (style == SearchQuanZi) {
            CGRect frame = self.view.frame;
            frame.size.width = 250;
            frame.size.height = 100;
            self.view.frame = frame;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Ismove = NO;
    AllHeight = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.myStyle == AddMyAccount) {
        UILabel *accountName_Label =  [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
        [accountName_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
        [accountName_Label setBackgroundColor:[UIColor clearColor]];
        [accountName_Label setTextColor:RGB(238, 131, 97)];
        accountName_Label.text = @"支付宝账号:";
        accountName_Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:accountName_Label];
        
        self.accountName_Field = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 140, 30)];
        self.accountName_Field.placeholder = @"";
        self.accountName_Field.textColor = [UIColor grayColor];
        self.accountName_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.accountName_Field.delegate = self;
        self.accountName_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
        self.accountName_Field.layer.borderWidth = 1;
        self.accountName_Field.layer.cornerRadius = 4;
        [self.view addSubview:self.accountName_Field];
        
        
        UIButton *create = [UIButton buttonWithType:UIButtonTypeCustom];
        create = [[UIButton alloc] initWithFrame:CGRectMake(25, 50, 200, 30)];
        [create setTitle:@"添加" forState:UIControlStateNormal];
        [create setTitleColor:RGB(238, 131, 97) forState:UIControlStateNormal];
        create.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        create.layer.borderColor = RGB(198, 198, 198).CGColor;
        create.layer.borderWidth = 1.5;
        create.layer.cornerRadius =4;
        [create addTarget:self action:@selector(addAcount) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:create];
    }else if (self.myStyle == AddMyAddress){
        UILabel *person_Label =  [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
        [person_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
        [person_Label setBackgroundColor:[UIColor clearColor]];
        [person_Label setTextColor:RGB(238, 131, 97)];
        person_Label.text = @"收货人姓名:";
        person_Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:person_Label];
        
        self.person_Field = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 140, 30)];
        self.person_Field.placeholder = @"";
        self.person_Field.textColor = [UIColor grayColor];
        self.person_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.person_Field.delegate = self;
        self.person_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
        self.person_Field.layer.borderWidth = 1;
        self.person_Field.layer.cornerRadius = 4;
        [self.view addSubview:self.person_Field];
        
        
        UILabel *postcode_Label =  [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 80, 30)];
        [postcode_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
        [postcode_Label setBackgroundColor:[UIColor clearColor]];
        [postcode_Label setTextColor:RGB(238, 131, 97)];
        postcode_Label.text = @"邮编:";
        postcode_Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:postcode_Label];
        
        self.postcode_Field = [[UITextField alloc] initWithFrame:CGRectMake(100, 45, 140, 30)];
        self.postcode_Field.placeholder = @"";
        self.postcode_Field.textColor = [UIColor grayColor];
        self.postcode_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.postcode_Field.delegate = self;
        self.postcode_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
        self.postcode_Field.layer.borderWidth = 1;
        self.postcode_Field.layer.cornerRadius = 4;
        [self.view addSubview:self.postcode_Field];
        
        UILabel *telephone_Label =  [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 80, 30)];
        [telephone_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
        [telephone_Label setBackgroundColor:[UIColor clearColor]];
        [telephone_Label setTextColor:RGB(238, 131, 97)];
        telephone_Label.text = @"手机号:";
        telephone_Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:telephone_Label];
        
        self.telephone_Field = [[UITextField alloc] initWithFrame:CGRectMake(100, 80, 140, 30)];
        self.telephone_Field.placeholder = @"";
        self.telephone_Field.textColor = [UIColor grayColor];
        self.telephone_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.telephone_Field.delegate = self;
        self.telephone_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
        self.telephone_Field.layer.borderWidth = 1;
        self.telephone_Field.layer.cornerRadius = 4;
        [self.view addSubview:self.telephone_Field];
        
        UILabel *area_Label =  [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 80, 30)];
        [area_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
        [area_Label setBackgroundColor:[UIColor clearColor]];
        [area_Label setTextColor:RGB(238, 131, 97)];
        area_Label.text = @"所属地区:";
        area_Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:area_Label];
        
        self.area_Field = [[UITextField alloc] initWithFrame:CGRectMake(100, 115, 140, 30)];
        self.area_Field.placeholder = @"";
        self.area_Field.textColor = [UIColor grayColor];
        self.area_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.area_Field.delegate = self;
        self.area_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
        self.area_Field.layer.borderWidth = 1;
        self.area_Field.layer.cornerRadius = 4;
        [self.view addSubview:self.area_Field];
        
        UILabel *location_Label =  [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 80, 30)];
        [location_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
        [location_Label setBackgroundColor:[UIColor clearColor]];
        [location_Label setTextColor:RGB(238, 131, 97)];
        location_Label.text = @"收货地址:";
        location_Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:location_Label];
        
        self.location_Field = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 140, 30)];
        self.location_Field.placeholder = @"";
        self.location_Field.textColor = [UIColor grayColor];
        self.location_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.location_Field.delegate = self;
        self.location_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
        self.location_Field.layer.borderWidth = 1;
        self.location_Field.layer.cornerRadius = 4;
        [self.view addSubview:self.location_Field];
        
        
        UIButton *create = [UIButton buttonWithType:UIButtonTypeCustom];
        create = [[UIButton alloc] initWithFrame:CGRectMake(25, 190, 200, 30)];
        [create setTitle:@"添加" forState:UIControlStateNormal];
        [create setTitleColor:RGB(238, 131, 97) forState:UIControlStateNormal];
        create.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        create.layer.borderColor = RGB(198, 198, 198).CGColor;
        create.layer.borderWidth = 1.5;
        create.layer.cornerRadius =4;
        [create addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:create];
    }else if (self.myStyle == AddMyQuanZi) {
        UILabel *quanzi_Label =  [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
        [quanzi_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
        [quanzi_Label setBackgroundColor:[UIColor clearColor]];
        [quanzi_Label setTextColor:RGB(238, 131, 97)];
        quanzi_Label.text = @"圈子名称:";
        quanzi_Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:quanzi_Label];
        
        self.quanzi_Field = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 140, 30)];
        self.quanzi_Field.placeholder = @"";
        self.quanzi_Field.textColor = [UIColor grayColor];
        self.quanzi_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.quanzi_Field.delegate = self;
        self.quanzi_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
        self.quanzi_Field.layer.borderWidth = 1;
        self.quanzi_Field.layer.cornerRadius = 4;
        [self.view addSubview:self.quanzi_Field];
        
        
        UIButton *create = [UIButton buttonWithType:UIButtonTypeCustom];
        create = [[UIButton alloc] initWithFrame:CGRectMake(25, 50, 200, 30)];
        [create setTitle:@"添加" forState:UIControlStateNormal];
        [create setTitleColor:RGB(238, 131, 97) forState:UIControlStateNormal];
        create.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        create.layer.borderColor = RGB(198, 198, 198).CGColor;
        create.layer.borderWidth = 1.5;
        create.layer.cornerRadius =4;
        [create addTarget:self action:@selector(addQuanZi) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:create];
    }else if (self.myStyle == SearchQuanZi) {
        UILabel *SearchQuanZi_Label =  [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
        [SearchQuanZi_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
        [SearchQuanZi_Label setBackgroundColor:[UIColor clearColor]];
        [SearchQuanZi_Label setTextColor:RGB(238, 131, 97)];
        SearchQuanZi_Label.text = @"圈子名称:";
        SearchQuanZi_Label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:SearchQuanZi_Label];
        
        self.SearchQuanZi_Field = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 140, 30)];
        self.SearchQuanZi_Field.placeholder = @"";
        self.SearchQuanZi_Field.textColor = [UIColor grayColor];
        self.SearchQuanZi_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.SearchQuanZi_Field.delegate = self;
        self.SearchQuanZi_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
        self.SearchQuanZi_Field.layer.borderWidth = 1;
        self.SearchQuanZi_Field.layer.cornerRadius = 4;
        [self.view addSubview:self.SearchQuanZi_Field];
        
        
        UIButton *create = [UIButton buttonWithType:UIButtonTypeCustom];
        create = [[UIButton alloc] initWithFrame:CGRectMake(25, 50, 200, 30)];
        [create setTitle:@"搜索" forState:UIControlStateNormal];
        [create setTitleColor:RGB(238, 131, 97) forState:UIControlStateNormal];
        create.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        create.layer.borderColor = RGB(198, 198, 198).CGColor;
        create.layer.borderWidth = 1.5;
        create.layer.cornerRadius =4;
        [create addTarget:self action:@selector(searchQuanZi) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:create];
    }
    DLog(@"%f",self.view.frame.origin.y);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonAction
-(void)addAcount
{
    [self returnBack];
    [self.delegate addAccount:self.accountName_Field.text];
}

-(void)addAddress
{
    [self returnBack];
    [self.delegate addAddressWithPerson:self.person_Field.text PostCode:self.postcode_Field.text Tele:self.telephone_Field.text Area:self.area_Field.text Location:self.location_Field.text];
}

-(void)addQuanZi
{
    [self returnBack];
    [self.delegate addQuanZi:self.quanzi_Field.text];
}

-(void)searchQuanZi
{
    [self returnBack];
    [self.delegate searchQuanZi:self.SearchQuanZi_Field.text];
}


#pragma mark - UITextFieldDelegate
//TextField输入时键盘的位置改变；
#define Move_Height 15
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	CGRect frame = self.view.frame;
    frame.origin.y =AllHeight;
	self.view.frame = frame;
	[UIView commitAnimations];
	[textField resignFirstResponder];
    Ismove = NO;
    AllHeight = 0;
	return YES;
}

-(void)returnBack
{
    if (Ismove){
        NSTimeInterval animationDuration = 0.10f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect frame = self.view.frame;
        frame.origin.y =AllHeight;
        self.view.frame = frame;
        [UIView commitAnimations];
        [self.accountName_Field resignFirstResponder];
        [self.accountName_Field resignFirstResponder];
        [self.accountName_Field resignFirstResponder];
        [self.quanzi_Field resignFirstResponder];
        [self.SearchQuanZi_Field resignFirstResponder];
        Ismove = NO;
        AllHeight = 0;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGRect frame = self.view.frame;
    if (!Ismove) {
        AllHeight = frame.origin.y;
    }
	NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
    frame.origin.y -= Move_Height;
    self.view.frame =frame;
    Ismove = YES;
	[UIView commitAnimations];
}
@end
