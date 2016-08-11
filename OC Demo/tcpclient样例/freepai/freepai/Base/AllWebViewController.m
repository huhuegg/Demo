//
//  AllWebViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-17.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "AllWebViewController.h"

@interface AllWebViewController ()<UIWebViewDelegate>
{
    NSString *URL;
    UIWebView *WEB;
    WebType type;
    NSDictionary *exchangeDetails;
}

@end

@implementation AllWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init:(NSString *)url withType:(WebType)webtype details:(NSDictionary *)details
{
    self = [super init];
    if (self) {
        URL = url;
        type = webtype;
        exchangeDetails = details;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    WEB = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 60)];
    WEB.delegate = self;
    [self.view addSubview:WEB];
    
    NSURL *url =[NSURL URLWithString:URL];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [WEB loadRequest:request];
    // Do any additional setup after loading the view.
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

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (type == WebType_Exchange) {
        
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
        [dataDict setObject:[CacheDataManager sharedInstance].uuid forKey:@"uuid"];
        [dataDict setObject:@"90ayop1232kzedbs" forKey:@"game_id"];
        [dataDict setObject:[exchangeDetails objectForKey:@"haggleitemid"] forKey:@"haggleitemid"];
        [dataDict setObject:[exchangeDetails objectForKey:@"title"] forKey:@"title"];
        [dataDict setObject:[exchangeDetails objectForKey:@"info"] forKey:@"info"];
        [dataDict setObject:[exchangeDetails objectForKey:@"price"] forKey:@"price"];
        [dataDict setObject:[exchangeDetails objectForKey:@"exchanged_count"] forKey:@"exchanged_count"];
        [dataDict setObject:[exchangeDetails objectForKey:@"projectstyle"] forKey:@"projectstyle"];
        DLog(@"%@",dataDict);
        NSError *error = nil;
        NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
        NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
        data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        data = [data stringByReplacingOccurrencesOfString:@" " withString:@""];
        DLog(@"%@",data);
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"app.exchange('%@')",data]];
    }else if (type == WebType_Exchange){
         [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"app.exchange('%@')",[CacheDataManager sharedInstance].uuid]];
    }
}

@end
