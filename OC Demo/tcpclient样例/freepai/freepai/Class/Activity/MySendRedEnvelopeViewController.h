//
//  MySendRedEnvelopeViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySendRedEnvelopeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@property (nonatomic,strong) UITableView *mySendRedEnvelopeTableView;
@property (nonatomic,strong) NSMutableArray *SendTimeList;
@property (nonatomic,strong) NSMutableDictionary *SendTimeDetails;
@end
