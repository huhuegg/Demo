//
//  CreateGangViewController.m
//  freepai_client
//
//  Created by jiangchao on 14-5-27.
//  Copyright (c) 2014年 yunwei. All rights reserved.
//

#import "CreateGangViewController.h"
#import "constant.h"

@interface CreateGangViewController ()<UITextFieldDelegate>
{
    BOOL Ismove;
}

@end

@implementation CreateGangViewController
@synthesize Name_Field;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        CGRect frame = self.view.frame;
        frame.size.width = 250;
        frame.size.height = 150;
        self.view.frame = frame;
        
    }
    return self;
}

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
    Ismove = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *Verification_Label =  [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 250, 30)];
    //Verification_Label.center = CGPointMake(self.view.frame.size.width/2, 40);
    [Verification_Label setFont:[UIFont fontWithName:@"Arial" size:12]];
    [Verification_Label setBackgroundColor:[UIColor clearColor]];
    [Verification_Label setTextColor:RGB(238, 131, 97)];
    Verification_Label.text = @"请输入想要建立的圈子名称";
    Verification_Label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:Verification_Label];
    
    self.Name_Field = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 200, 30)];
    //Name_Field.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.Name_Field.placeholder = @"";
    self.Name_Field.textColor = [UIColor grayColor];
    self.Name_Field.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.Name_Field.delegate = self;
    self.Name_Field.layer.borderColor = RGB(198, 198, 198).CGColor;
    self.Name_Field.layer.borderWidth = 1;
    self.Name_Field.layer.cornerRadius = 4;
    [self.view addSubview:self.Name_Field];
    
    
    UIButton *create = [UIButton buttonWithType:UIButtonTypeCustom];
    create = [[UIButton alloc] initWithFrame:CGRectMake(90, 100, 60, 30)];
    //Send.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 40);
    [create setTitle:@"创建" forState:UIControlStateNormal];
    [create setTitleColor:RGB(238, 131, 97) forState:UIControlStateNormal];
    create.titleLabel.font = [UIFont systemFontOfSize: 10.0];
    create.layer.borderColor = RGB(198, 198, 198).CGColor;
    create.layer.borderWidth = 1.5;
    create.layer.cornerRadius =4;
    [create addTarget:self action:@selector(create_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:create];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonAction
-(void)create_touch
{
    [self.delegate createGang:self.Name_Field.text];
    [self returnBack];
}


#pragma mark - UITextFieldDelegate
//TextField输入时键盘的位置改变；
#define Move_Height 60
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	CGRect frame = self.view.frame;
    frame.origin.y += Move_Height;
	self.view.frame = frame;
	[UIView commitAnimations];
	[textField resignFirstResponder];
    Ismove = NO;
	return YES;
}


-(void)returnBack
{
    if (Ismove){
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect frame = self.view.frame;
        frame.origin.y += Move_Height;
        self.view.frame = frame;
        [UIView commitAnimations];
        [Name_Field resignFirstResponder];
        Ismove = NO;
    }

}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	CGRect frame = self.view.frame;
	NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	frame.origin.y -= Move_Height;
    self.view.frame =frame;
    Ismove = YES;
	[UIView commitAnimations];
}


@end
