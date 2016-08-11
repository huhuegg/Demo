//
//  Test.h
//  TestXib
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "DAAutoTableView.h"

@interface ScrollMsgView : DAAutoTableView<UITableViewDataSource,UITableViewDelegate>
-(void)stopRefreshData;
-(void)startRefreshData;
@end
