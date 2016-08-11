//
//  Test.m
//  TestXib
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ScrollMsgView.h"
#import "CacheDataManager.h"
#import "scrollTableViewCell.h"

@implementation ScrollMsgView
{
    NSTimer *refreshTimer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self refreshData];
    }
    return self;
}

-(void)stopRefreshData
{
    [refreshTimer invalidate];
    [self stopScrolling];
    refreshTimer = nil;
}

-(void)startRefreshData
{
    [self stopRefreshData];
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:20
                                                    target:self
                                                  selector:@selector(refreshData)
                                                  userInfo:nil
                                                   repeats:YES];
}

-(void)refreshData
{
    //DLog(@"uuid%@",[CacheDataManager sharedInstance].uuid);
    [[ServerDataManager sharedInstance] requestMainPageMessageRollGet:[CacheDataManager sharedInstance].uuid LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
        /*
        DLog(@"%@",reqRes);
        if (reqRes) {
            if ([reqRes isKindOfClass:[NSDictionary class]]) {
                id dict = [reqRes objectForKey:@"dataObject"];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    NSArray *context = @[[dict objectForKey:@"context"],@""];
                    [CacheDataManager sharedInstance].scrollTableCellArr = context;
                    [self reloadData];
                    [self startScrolling];
                }
            }else if ([reqRes isKindOfClass:[NSError class]]){
                [self refreshData];
            }
        }
         */
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    
                }
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CacheDataManager sharedInstance].scrollTableCellArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    scrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"scrollTableViewCell"  owner:self options:nil] lastObject];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.infoLabel.textAlignment = NSTextAlignmentCenter;
    cell.infoLabel.text = [CacheDataManager sharedInstance].scrollTableCellArr[indexPath.row];
    cell.infoLabel.font = [UIFont systemFontOfSize: 18.];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end
