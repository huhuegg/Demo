//
//  ReceivedRedEnvelopeViewController.h
//  freepai
//
//  Created by admin on 14/6/25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceivedRedEnvelopeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@property UITableView *tbView;

@end
