//
//  MessageViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "YukeyAudioBasicSetting.h"
#define REFRESH_HEADER_HEIGHT 52.0f
@interface MessageViewController ()

@end

@implementation MessageViewController

@synthesize textPull, textRelease, textLoading, refreshFooterView, refreshLabel, refreshArrow, refreshSpinner, hasMore, textNoMore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    
    self.messageList = [[NSMutableArray alloc] init];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"消息"]];
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
    
    UIImageView *head_Image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 90, 90)];
    head_Image.image = [UIImage imageNamed:@"MessageHeadIm"];
    if ([YukeyAudioBasicSetting fileExistsAtPath:[YukeyAudioBasicSetting getImagePathByFileName:@"image.png"]]) {
        head_Image.image = [UIImage imageWithContentsOfFile:[YukeyAudioBasicSetting getImagePathByFileName:@"image.png"]];
    }else{
        head_Image.image = [UIImage imageNamed:@"MeheadIm"];
    }
    [self.view addSubview:head_Image];
    
    
    UILabel *accountName = [[UILabel alloc] initWithFrame:CGRectMake(110, 100, 200, 30)];
    [accountName  setBackgroundColor:[UIColor clearColor]];
    [accountName  setFont:[UIFont fontWithName:@"Arial" size:16]];
    if (![[CacheDataManager sharedInstance].userName isEqualToString:@"None"]) {
        [accountName  setText:[NSString stringWithFormat:@"昵称:%@",[CacheDataManager sharedInstance].userName]];
    }else{
        [accountName  setText:[NSString stringWithFormat:@"昵称:--"]];
    }
    
    accountName.textAlignment = NSTextAlignmentLeft;
    [accountName  setTextColor:[UIColor orangeColor]];
    [self.view addSubview:accountName];

    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, 320, self.view.frame.size.height-220-TabViewHeight)];
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    self.messageTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.messageTableView];
    [self setupStrings];
    [self addPullToRefreshFooter];
    
    [self gotMessageList:@"None" startID:@"None"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.messageTableView = nil;
    self.messageList = nil;
}

#pragma mark - GetList
-(void)gotMessageList:(NSString *)operation startID:(NSString *)startID
{

    [[ServerDataManager sharedInstance] requestSingleMessageBox:[CacheDataManager sharedInstance].uuid LoginResource:@"None" Request:@"None" Operation:operation startID:startID completeBlock:^(id reqRes) {
        if (reqRes) {
            DLog(@"消息盒列表%@",reqRes);
            if ([reqRes isKindOfClass:[NSDictionary class]]) {
                id dict = [reqRes objectForKey:@"dataObject"];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    NSArray *details = [dict objectForKey:@"details"];
                    if ([startID isEqualToString:@"None"]) {
                        self.messageList = [NSMutableArray arrayWithArray:details];
                        [self.messageTableView reloadData];
                    }else{
                        [self.messageList addObjectsFromArray:details];
                        [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
                    }
                    
                    id lastDict = [self.messageList lastObject];
                    if ([lastDict isKindOfClass:[NSDictionary class]]) {
                        [CacheDataManager sharedInstance].MessageStartID = [lastDict objectForKey:@"actionid"];
                    }
                }else{
                        [self showMsgTitleIs:@"提示" message:@"没有查到相关数据" buttonText:@"好的"];
                        [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
                }
            }else if([reqRes isKindOfClass:[NSError class]]){
                    [self showMsgTitleIs:@"提示" message:@"没有查到相关数据" buttonText:@"好的"];
                    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
            }
        }
    }];
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [[self.messageList objectAtIndex:[indexPath row]] objectForKey:@"context"];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




- (void)setupStrings{
    textPull    = @"上拉刷新...";
    textRelease = @"释放开始刷新...";
    textLoading = @"正在加载...";
    textNoMore  = @"没有更多内容了...";
    hasMore = YES;
}

-(void)addPullToRefreshFooter{
    refreshFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.messageTableView.contentSize.height+REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshFooterView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshFooterView addSubview:refreshLabel];
    [refreshFooterView addSubview:refreshArrow];
    [refreshFooterView addSubview:refreshSpinner];
    [self.messageTableView addSubview:refreshFooterView];
    refreshFooterView.hidden = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading && scrollView.contentOffset.y > 0) {
        // Update the content inset, good for section headers
        self.messageTableView.contentInset = UIEdgeInsetsMake(0, 0, REFRESH_HEADER_HEIGHT, 0);
    }else if(!hasMore){
        refreshLabel.text = self.textNoMore;
        refreshArrow.hidden = YES;
    }else if (isDragging && scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= 0 ) {
        refreshFooterView.hidden = NO;
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        refreshArrow.hidden = NO;
        if (scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            refreshLabel.text = self.textRelease;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            refreshLabel.text = self.textPull;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading || !hasMore) return;
    isDragging = NO;
    
    //    CGPoint offset = scrollView.contentOffset;
    //    CGRect bounds = scrollView.bounds;
    //    CGSize size = scrollView.contentSize;
    //    UIEdgeInsets inset = scrollView.contentInset;
    //    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    //
    //    CGFloat maximumOffset = size.height;
    //
    //    (maximumOffset - currentOffset) <= -REFRESH_HEADER_HEIGHT)
    
    //上拉刷新
    if(scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT && scrollView.contentOffset.y > 0){
        refreshFooterView.hidden = NO;
        [self startLoading];
    }else{
        refreshFooterView.hidden = YES
        ;
    }
}

- (void)startLoading {
    isLoading = YES;
    
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    self.messageTableView.contentInset = UIEdgeInsetsMake(0, 0, REFRESH_HEADER_HEIGHT, 0);
    refreshLabel.text = self.textLoading;
    refreshArrow.hidden = YES;
    [refreshSpinner startAnimating];
    [UIView commitAnimations];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self.messageTableView.contentInset = UIEdgeInsetsZero;
    UIEdgeInsets tableContentInset = self.messageTableView.contentInset;
    tableContentInset.top = 0.0;
    self.messageTableView.contentInset = tableContentInset;
    
    [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    // Reset the header
    //NSLog(@"%f",self.messageTableView.contentSize.height);
   
    
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
     refreshFooterView.hidden = YES;
    [refreshFooterView setFrame:CGRectMake(0, self.messageTableView.contentSize.height+REFRESH_HEADER_HEIGHT, 320, 0)];
    [refreshSpinner stopAnimating];
    [self.messageTableView reloadData];

}

- (void)refresh {
    if ([[CacheDataManager sharedInstance].MessageStartID isEqualToString:@"None"]) {
        [self gotMessageList:@"None" startID:@"None"];
    }else{
        [self gotMessageList:@"after" startID:[CacheDataManager sharedInstance].MessageStartID];
    }
    
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


@end
